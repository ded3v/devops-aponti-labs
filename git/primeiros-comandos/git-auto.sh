#!/bin/bash

echo "Inicializando o Git..."
git init

echo "Adicionando todos os arquivos..."
git add .

echo "Criando o primeiro commit..."
git commit -m "Primeiro commit"

echo "Renomeando a branch para main..."
git branch -M main

echo "Adicionando o repositório remoto..."
git remote add origin https://github.com/ded3v/ApontiTestes.git

echo "Enviando para o GitHub..."
git push -u origin main

echo "Projeto enviado com sucesso!"
