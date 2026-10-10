# Base específica para Node.js, com menos componentes do que Ubuntu + apt.
FROM node:24-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1

ENV NODE_ENV=production
WORKDIR /app

# O lockfile torna a instalação das dependências reproduzível.
COPY app/package.json app/package-lock.json ./
RUN npm ci --omit=dev --ignore-scripts && npm cache clean --force

# Copia somente o código necessário, sem .env, Git ou documentação.
COPY app/server.js ./server.js

# Usuário node já existe na imagem oficial e não tem privilégios de root.
# Os arquivos pertencem a root: node pode ler, mas não alterar o código.
USER node
EXPOSE 3000
CMD ["node", "server.js"]
