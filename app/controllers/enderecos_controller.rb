class EnderecosController < ApplicationController
  before_action :set_endereco, only: %i[ show edit update destroy ]

  def index
    @enderecos = Endereco.all
  end

  def show;  end

  def new
    @endereco = Endereco.new
  end

  def edit
  end

  def create
    @endereco = Endereco.new(endereco_params)
    if @endereco.save
      redirect_to enderecos_path, notice: 'Endereço criado com sucesso.'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @endereco.update(endereco_params)
        format.html { redirect_to endereco_url(@endereco), notice: "Endereco was successfully updated." }
        format.json { render :show, status: :ok, location: @endereco }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @endereco.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_endereco
      @endereco = Endereco.find(params[:id])
    end

    def endereco_params
      params.require(:endereco).permit(:cep, :logradouro, :complemento, :bairro, :cidade, :uf, :codigo_ibge, :municipe_id)
    end
end
