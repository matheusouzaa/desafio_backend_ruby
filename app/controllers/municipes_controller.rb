class MunicipesController < ApplicationController
  before_action :set_municipe, only: %i[ show edit update]

  def index
    @municipes = MunicipeFilterService.filter(params)
  end

  def show
    @municipe = Municipe.find(params[:id])
  end

  def new
    @municipe = Municipe.new
    @endereco = @municipe.build_endereco
  end

  def edit
    @municipe = Municipe.find(params[:id])
  end

  def create
    byebug
    @municipe = Municipe.new(municipe_params)
    byebug
    if @municipe.save
      redirect_to municipes_path, notice: 'Municipe cadastrado com sucesso.'
    else
      render :new
    end
  end


  def update
    @municipe = Municipe.find(params[:id])
    byebug
    if @municipe.update(municipe_params)
      redirect_to municipes_path, notice: 'Municipe atualizado com sucesso.'
    else
      render :edit
    end
  end

  private
    def set_municipe
      @municipe = Municipe.find(params[:id])
    end

  def municipe_params
    params.require(:municipe).permit(
      :nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :foto, :status,
      endereco_attributes: [:cep, :logradouro, :complemento, :bairro, :cidade, :uf, :codigo_ibge]
    )
  end
end
