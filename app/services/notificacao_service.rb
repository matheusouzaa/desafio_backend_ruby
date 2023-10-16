class NotificacaoService
  def initialize(municipe)
    @municipe = municipe
    @sms_service = SMSService.new(municipe)
  end

  def notificar_criacao
    enviar_email_bem_vindo if @municipe.status == 'ativo'
    @sms_service.enviar_sms("Bem-vindo ao nosso serviço!") if @municipe.status == 'ativo'
  end

  def notificar_atualizacao
    enviar_email_atualizacao
    @sms_service.enviar_sms("Seu dados cadastrais foram atualizados!")
  end

  private

  def enviar_email_bem_vindo
    MunicipeMailer.bem_vindo_email(@municipe).deliver_now
  end

  def enviar_email_atualizacao
    MunicipeMailer.atualizacao_email(@municipe).deliver_now
  end
end
