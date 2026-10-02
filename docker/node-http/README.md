# Docker · API HTTP com Node.js

Servidor HTTP simples para praticar instruções do Dockerfile. Utiliza Node.js 22 Alpine e não depende de pacotes externos.

## Executar

A partir da raiz de `devops-aponti-labs`:

```bash
cd docker/node-http
docker build -t fap-node-http:1.0 .
docker run --rm --name fap-node-http -p 3000:3000 -v fap-node-data:/app/dados fap-node-http:1.0
```

Acesse [http://localhost:3000](http://localhost:3000). Use Ctrl+C para encerrar. O volume exemplifica persistência, mas a aplicação atual não grava arquivos nele.

## O que foi praticado

Imagem base, diretório de trabalho, variáveis, COPY, ADD, RUN, EXPOSE, VOLUME, ENTRYPOINT e CMD. `EXPOSE` documenta a porta; `-p` faz a publicação no host.

## Origem

Importado de [ded3v/Dockerfile-use-test](https://github.com/ded3v/Dockerfile-use-test).
