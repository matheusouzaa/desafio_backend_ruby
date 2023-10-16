class Municipe < ApplicationRecord
  has_one :endereco

  enum status: {  ativo: 1, inativo: 0 }.freeze

  before_validation :limpar_cpf

  validates :nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :status, presence: true
  validates :cpf, uniqueness: true, format: { with: /\A\d{11}\z/, message: "deve conter 11 dígitos numéricos" }
  validates :cns, uniqueness: true, format: { with: /\A\d{15}\z/, message: "deve conter 15 dígitos numéricos" }
  validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "inválido" }
  validate :valid_data_nascimento

  accepts_nested_attributes_for :endereco

  def valid_data_nascimento
    if data_nascimento.present? && data_nascimento >= Date.today
      errors.add(:data_nascimento, "deve ser anterior à data atual")
    end
  end

  after_create :notificar_criacao
  after_update :notificar_atualizacao

  def formatted_cpf
    self.cpf.insert(3, '.').insert(7, '.').insert(11, '-')
  end

  def formatted_data_nascimento
    self.data_nascimento.strftime("%d/%m/%Y")
  end

  def formatted_telefone
    self.telefone.gsub(/(\d{2})(\d{5})(\d{4})/, '(\1) \2-\3')
  end

  def formatted_status
    self.status == 1 ? 'Ativo' : 'Inativo'
  end

  private

  def limpar_cpf
    self.cpf = cpf.gsub(/\D/, '')
  end

  def notificar_criacao
    notificacao_service.notificar_criacao
  end

  def notificar_atualizacao
    notificacao_service.notificar_atualizacao
  end

  def notificacao_service
    @notificacao_service ||= NotificacaoService.new(self)
  end
end
