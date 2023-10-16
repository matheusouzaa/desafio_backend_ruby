class MunicipeMailer < ApplicationMailer
  def bem_vindo_email(municipe)
    @municipe = municipe
    mail(to: @municipe.email, subject: 'Bem-vindo ao nosso serviço')
  end

  def atualizacao_email(municipe)
    @municipe = municipe
    mail(to: @municipe.email, subject: 'Status alterado')
  end
end