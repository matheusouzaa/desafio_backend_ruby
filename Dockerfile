


# Use uma imagem oficial do Ruby como ponto de partida
FROM ruby:3.0.6

# Instale dependências
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libvips

# Crie e defina o diretório de trabalho
RUN mkdir /myapp
WORKDIR /myapp

# Copie o Gemfile e o Gemfile.lock para o contêiner
COPY Gemfile Gemfile.lock ./

# Instale as gems
RUN bundle install

# Copie o restante do aplicativo para o contêiner
COPY . .

# Exponha a porta 3000
EXPOSE 3000

# Comando padrão para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
