# Testes no Windows — 10/10/2026

Executei o script de validação no PowerShell, com Docker Desktop iniciado:

```powershell
powershell -ExecutionPolicy Bypass -File .\validar.ps1
```

Horário de início registrado: `2026-10-10T15:22:33.2382306-03:00`.

| Verificação | Resultado |
| --- | --- |
| Build da aplicação | Concluído, com cache de camadas |
| Aplicação e banco | Healthy |
| Porta da aplicação | 127.0.0.1:3000->3000/tcp |
| Sistema de arquivos da aplicação | Somente leitura |
| Modo privileged | Desativado nos dois containers |
| Capabilities da aplicação | Removidas; efetivas zeradas |
| Novos privilégios | Bloqueados; NoNewPrivs=1 |
| Limites da aplicação | 0,5 CPU e 256 MiB |
| Limites do banco | 1 CPU e 768 MiB |
| Portas do banco publicadas no host | Nenhuma |
| UID da aplicação | 1000 |
| Escrita em /app | Bloqueada |
| Processo principal do banco | Sem root |
| Rota inicial | Mensagem Olá mundo! |
| Consulta SELECT 1 | Concluída com o usuário da aplicação |

Ao final, o script exibiu: `Todas as verificações do script passaram.`

Este arquivo resume os resultados. O registro completo foi salvo em `evidencias-locais/validacao-docker.txt`. Essa pasta é ignorada pelo Git e pode ser anexada ao ZIP da entrega.

Antes da validação final, foi necessário corrigir a rede da aplicação. Ela passou a utilizar `frontend` e `backend`, enquanto o banco continuou apenas na `backend` interna.

Essas verificações não substituem um teste de carga ou uma auditoria completa de segurança.
