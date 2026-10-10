# Hardening de Containers

**André Chagas Assis Costa — DevOps Turma 5**

Atividade baseada no projeto [hardening-container](https://github.com/carlhenriquex/hardening-container) do professor. O objetivo foi revisar a configuração dos containers e aplicar medidas de segurança, mantendo a aplicação funcionando.

## O que foi feito

- Troca da imagem Ubuntu por uma imagem do Node.js em Alpine.
- Imagens fixadas por digest e dependências instaladas pelo lockfile.
- Aplicação executando sem root, sem capabilities e com sistema de arquivos somente leitura.
- Senhas no `.env`, fora do Git e do build.
- Banco sem portas publicadas no computador.
- Limites de CPU, memória e processos nos dois serviços.
- Healthchecks para verificar a aplicação e o banco.

A base tinha um `package.json` vazio e um script que somente imprimia uma mensagem. O manifest foi corrigido e a mensagem foi mantida em um servidor HTTP simples. A rota `/ready` foi adicionada para testar a conexão com o MySQL.

## Como executar

É necessário ter Docker Desktop iniciado, usando containers Linux e Docker Compose v2.

O ZIP da atividade inclui o `.env` usado no ambiente local. Para executar a partir do GitHub, copie `.env.example` para `.env` e preencha as variáveis. Use um usuário da aplicação diferente de root e senhas fortes diferentes para a aplicação e o administrador do banco.

Na pasta do projeto, execute no PowerShell:

```powershell
docker compose config --quiet
docker compose up -d --build --wait --wait-timeout 180
docker compose ps
Invoke-RestMethod http://127.0.0.1:3000/
Invoke-RestMethod http://127.0.0.1:3000/ready
```

A rota `/` retorna `Olá mundo!`. A rota `/health` verifica se o servidor responde. A rota `/ready` executa `SELECT 1` e retorna `banco: conectado` quando a conexão funciona.

Para conferir os logs:

```powershell
docker compose logs --tail 50 app banco
```

## Testes

Executei os testes no Windows com Docker Desktop em 10/10/2026. Os dois containers ficaram saudáveis e todas as verificações do script passaram:

```powershell
powershell -ExecutionPolicy Bypass -File .\validar.ps1
```

O script verifica usuário, permissões, limites de recursos, bloqueio de escrita, portas publicadas e conexão com o banco. O registro fica em `evidencias-locais/validacao-docker.txt`. O resumo está em `docs/validacao-docker-windows.md`.

Durante os testes, a aplicação ficou saudável, mas a porta 3000 não apareceu no computador. A causa era sua conexão somente à rede interna. Foi adicionada a rede `frontend` à aplicação, mantendo o banco apenas na `backend`. Depois da correção, o acesso por `127.0.0.1:3000` funcionou.

## Parar o ambiente

```powershell
docker compose down
```

Esse comando mantém o volume do banco. O volume preserva os dados, mas não substitui um backup. Alterar uma senha no `.env` também não muda automaticamente a senha de um banco já inicializado.

## Arquivos

| Arquivo | Função |
| --- | --- |
| Dockerfile | Construção da imagem da aplicação |
| docker-compose.yml | Serviços, redes, volume e restrições |
| .env.example | Modelo das variáveis, sem valores |
| .gitignore | Exclusão de arquivos locais do Git |
| .dockerignore | Exclusão de arquivos do contexto de build |
| HARDENING.md | Problemas encontrados, alterações e respostas |
| validar.ps1 | Testes do ambiente no Windows |

O `.env` deve ficar somente no ambiente local e no ZIP solicitado para entrega. Ele não deve ser enviado ao GitHub.

## Referência

O enunciado foi preservado em `docs/atividade.md`. A análise inicial usou o commit `74c1bff84eff7882fd807053180ad37a5b4700ac` do repositório do professor.
