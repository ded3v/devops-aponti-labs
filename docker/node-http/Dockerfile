# Define a imagem base utilizada pelo nosso container.
# Escolhemos uma imagem oficial do Node.js baseada em Alpine
# por ser uma imagem menor e adequada para aplicações simples.
FROM node:22-alpine

# Adiciona informações sobre a imagem.
# LABEL funciona como uma espécie de metadado.
LABEL author="Andre Chagas"
LABEL description="Dockerfile de exemplo para atividade de Docker"
LABEL version="1.0"

# Cria uma variável de ambiente que poderá ser utilizada
# dentro do container durante sua execução.
ENV NODE_ENV=production
ENV PORT=3000

# Define a pasta principal de trabalho dentro do container.
# Os próximos comandos serão executados considerando /app.
WORKDIR /app

# Copia primeiro o package.json para dentro do container.
# COPY é utilizado quando queremos simplesmente copiar arquivos.
COPY package.json ./

# Instala as dependências necessárias para a aplicação.
# RUN executa comandos durante o processo de construção da imagem.
RUN npm install

# Copia os demais arquivos do projeto para a pasta /app.
COPY . .

# ADD também pode copiar arquivos para a imagem.
# Ele possui recursos adicionais em relação ao COPY,
# como trabalhar com arquivos compactados e determinadas fontes remotas.
ADD exemplo.txt /app/exemplo.txt

# Informa que nossa aplicação utiliza a porta 3000.
# EXPOSE documenta a porta utilizada pelo serviço.
EXPOSE 3000

# Define uma pasta que poderá ser utilizada como volume.
# Volumes são úteis quando queremos manter dados fora
# do ciclo de vida normal do container.
VOLUME ["/app/dados"]

# ENTRYPOINT define o programa principal executado
# quando o container é iniciado.
ENTRYPOINT ["node"]

# CMD fornece o argumento padrão para o ENTRYPOINT.
# Neste caso o resultado será equivalente a:
# node index.js
CMD ["index.js"]
