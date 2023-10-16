class MunicipeFilter
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def filter
    perform_filtering
  end

  private

  def perform_filtering
    filtered_municipes = Municipe.all

    if params[:filtro].present?
      filtered_municipes = filter_by_full_name(filtered_municipes) if params[:filtro][:nome_completo].present?
      filtered_municipes = filter_by_cpf(filtered_municipes) if params[:filtro][:cpf].present?
      filtered_municipes = filter_by_cns(filtered_municipes) if params[:filtro][:cns].present?
      filtered_municipes = filter_by_email(filtered_municipes) if params[:filtro][:email].present?
      filtered_municipes = filter_by_telefone(filtered_municipes) if params[:filtro][:telefone].present?
    end

    return filtered_municipes
  end

  def filter_by_full_name(municipes)
    municipes.where("nome_completo ILIKE :filtro", filtro: "%#{params[:filtro][:nome_completo]}%")
  end

  def filter_by_cpf(municipes)
    municipes.where(cpf: params[:filtro][:cpf])
  end

  def filter_by_cns(municipes)
    municipes.where(cns: params[:filtro][:cns])
  end

  def filter_by_email(municipes)
    municipes.where("email ILIKE :filtro", filtro: "%#{params[:filtro][:email]}%")
  end

  def filter_by_telefone(municipes)
    municipes.where(telefone: params[:filtro][:telefone])
  end
end
