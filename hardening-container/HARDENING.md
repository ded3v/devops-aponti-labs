# Hardening de Containers

**André Chagas Assis Costa — DevOps Turma 5**

## 1. Problemas encontrados

Na análise da base do professor, encontrei configurações que aumentavam a exposição do ambiente. Também identifiquei que `app/package.json` estava vazio e que `server.js` somente imprimia uma mensagem. O Dockerfile executava `npm install` na raiz, onde não havia um `package.json`.

Por isso, além das medidas de segurança, foi necessário corrigir o manifest e preparar um servidor HTTP simples para testar a aplicação e sua conexão com o banco.

| Arquivo | Problema | Risco ou consequência |
| --- | --- | --- |
| Dockerfile | Ubuntu com tag latest | Imagem genérica, cujo conteúdo pode mudar entre builds |
| Dockerfile | Node e npm instalados por apt | Mais componentes e menor controle sobre a versão do Node |
| Dockerfile | COPY de todo o projeto, sem .dockerignore | Arquivos locais e senhas poderiam entrar na imagem |
| Dockerfile | Senha definida por ENV | Credencial registrada na configuração da imagem |
| Dockerfile | Sem definição de usuário | Aplicação executando como root |
| Dockerfile e app | Manifest vazio e instalação na pasta errada | Problemas no build e na execução |
| Compose | MySQL com tag latest | Possibilidade de atualização de versão sem revisão |
| Compose | Senha administrativa fraca no arquivo | Credencial exposta no repositório |
| Compose | Porta do banco publicada | Acesso direto ao banco pela máquina hospedeira |
| Compose | Aplicação publicada em todas as interfaces | Exposição maior do que o necessário para o teste local |
| Compose | Sem limites de recursos | Consumo excessivo de CPU, memória e processos |
| Compose | Sem healthchecks | Falta de verificação da disponibilidade dos serviços |
| Compose | Sem redução de capabilities | Permissões desnecessárias mantidas nos containers |
| Compose | Sem volume explicitamente configurado | Persistência dos dados sem organização clara no Compose |

A base não utilizava `privileged: true`, socket Docker, dispositivos ou pastas do host montadas nos containers. Esses pontos foram conferidos, mas não eram problemas presentes no projeto original.

## 2. Medidas aplicadas

### Imagem e build

A imagem Ubuntu foi substituída por `node:24-alpine`, que já contém o Node.js. O MySQL passou a usar a linha `8.4`. As duas imagens foram fixadas por digest SHA-256 para manter o mesmo conteúdo entre builds.

As dependências são instaladas com `npm ci --omit=dev --ignore-scripts`, usando o `package-lock.json`. O Dockerfile copia somente o manifest, o lockfile e o código necessário. O cache do npm é removido após a instalação.

O `.dockerignore` permite apenas os arquivos usados no build. Isso impede que `.env`, histórico Git e outros arquivos locais sejam enviados no contexto de construção.

**Por que uma imagem menor pode reduzir a superfície de ataque?**

Menos componentes significam menos pacotes para atualizar e menos possíveis falhas para explorar. Mesmo assim, uma imagem pequena também pode ter vulnerabilidades e precisa ser mantida atualizada.

### Menor privilégio

A aplicação executa com o usuário `node`, UID e GID 1000, em vez de root. Também foram aplicadas estas configurações:

- `cap_drop: [ALL]`: remove as capabilities da aplicação.
- `no-new-privileges:true`: impede que o processo obtenha novos privilégios.
- `read_only: true`: bloqueia alterações no sistema de arquivos da aplicação.

No banco, todas as capabilities foram removidas e somente `CHOWN`, `DAC_OVERRIDE`, `FOWNER`, `SETGID` e `SETUID` foram adicionadas novamente. Elas atendem à preparação dos arquivos e à troca de usuário feita pelo entrypoint oficial. A inicialização pode começar como root, mas o processo principal do MySQL executa como usuário mysql. Isso foi conferido nos testes.

O banco não recebeu `read_only: true` nesta versão, pois precisa escrever seus dados e outros arquivos durante a execução.

**Qual seria o impacto de uma aplicação comprometida executando como administrador?**

O atacante teria mais permissões para alterar arquivos, acessar informações e explorar falhas de isolamento. Ser root no container não significa automaticamente ser root no computador, mas aumenta o impacto de um comprometimento.

### Informações sensíveis

As credenciais foram retiradas dos arquivos de configuração versionados e passaram a ser fornecidas pelo `.env`. O Compose exige que as variáveis estejam preenchidas usando a sintaxe `${VAR:?mensagem}`.

O `.env` contém:

```env
DB_USER=...
DB_PASSWORD=...
DB_NAME=...
DB_ROOT_PASSWORD=...
```

O usuário da aplicação é diferente de root. A aplicação recebe somente sua própria senha; a senha administrativa é fornecida apenas ao banco. O root do MySQL está limitado a localhost. As senhas do ambiente são diferentes e foram geradas para esta prática.

O `.gitignore` exclui o `.env`, enquanto o `.env.example` contém somente os nomes das variáveis, sem valores. O `.dockerignore` também impede a inclusão do `.env` no build.

**1. Por que uma senha no Dockerfile representa um risco?**

Ela pode ficar registrada nas camadas, no histórico ou na configuração da imagem. Quem tiver acesso à imagem pode conseguir recuperar essa informação.

**2. Por que o .env não deve ir para o repositório?**

Porque contém as credenciais do ambiente. Além da exposição no arquivo, os valores poderiam continuar no histórico do Git mesmo depois de removidos.

**3. Qual é a finalidade do .env.example?**

Mostrar quais variáveis são necessárias para executar o projeto, sem divulgar as credenciais.

**4. Qual é a diferença entre a senha no Compose e a variável fornecida pelo .env?**

No Compose fica apenas a referência à variável. O valor é fornecido localmente na execução, evitando sua publicação no código. Isso não criptografa a senha: o arquivo local e o acesso administrativo ao Docker ainda precisam ser protegidos.

Se uma credencial já foi publicada, ela deve ser trocada. Apenas apagar o arquivo ou adicionar uma regra no `.gitignore` não resolve a exposição anterior.

### Rede

A aplicação publica somente `127.0.0.1:3000:3000`, permitindo o acesso pelo próprio computador. Ela participa de duas redes:

| Rede | Participantes | Função |
| --- | --- | --- |
| frontend | Aplicação | Permitir o acesso pela porta publicada no host |
| backend | Aplicação e banco | Comunicação com o MySQL |

A `backend` utiliza `internal: true`. O banco fica somente nessa rede e não publica portas no computador. A aplicação encontra o banco pelo nome de serviço `banco`.

Como a aplicação também participa da `frontend`, ela tem conectividade de saída por essa rede. O isolamento externo permanece no banco.

**É necessário publicar a porta do banco se somente a aplicação o utiliza?**

Não. A comunicação já acontece pela rede Docker. Retirar a publicação reduz a exposição direta do banco, embora administradores do Docker e serviços conectados à mesma rede ainda possam acessá-lo.

### Recursos e isolamento

Foram definidos estes limites:

| Serviço | CPU | Memória | Processos |
| --- | --- | --- | --- |
| Aplicação | 0,5 CPU | 256 MiB | 100 |
| Banco | 1 CPU | 768 MiB | 200 |

São valores iniciais para o laboratório. Uma aplicação com mais usuários ou dados precisaria de testes e ajustes.

Os logs têm rotação configurada em dois arquivos de 5 MB por serviço. Não há modo privileged, acesso ao socket Docker, dispositivos ou pastas do host montadas nos containers.

O banco grava os dados no volume `banco-dados`. Esse volume mantém os dados entre recriações do container, mas não substitui um backup.

**O que pode acontecer se um container consumir todos os recursos do host?**

Outros serviços podem ficar lentos ou parar. A falta de memória também pode causar encerramento de processos. Os limites reduzem esse risco; um container que ultrapassa seu próprio limite de memória pode ser encerrado.

### Funcionamento e healthchecks

A aplicação mantém a mensagem original na rota `/`. A rota `/health` verifica se o servidor responde, enquanto `/ready` faz uma consulta `SELECT 1` no MySQL com o usuário da aplicação.

Quando a conexão falha, `/ready` responde HTTP 503 sem mostrar detalhes internos ou credenciais. O Compose aguarda o banco ficar saudável antes de iniciar a aplicação. O servidor também trata o encerramento para fechar suas conexões.

## 3. Análise final

**1. Qual era o principal risco?**

A combinação de senha administrativa fraca no Compose e porta do banco publicada. Isso facilitava uma tentativa de acesso direto ao MySQL. A aplicação executando como root também aumentava o risco.

**2. Qual alteração foi mais importante?**

Retirar a publicação da porta do banco e substituir as credenciais por valores fornecidos localmente. Essas mudanças reduziram a exposição direta. A execução sem root complementa essa proteção.

**3. O que poderia acontecer se a aplicação fosse comprometida?**

O atacante poderia usar as permissões do usuário node e as credenciais da aplicação para acessar o banco. Os dados do banco da aplicação ainda estariam em risco. As restrições reduzem as possibilidades de alterar o código e obter novos privilégios, mas não eliminam todos os danos de uma invasão.

**4. Como o menor privilégio foi aplicado?**

Com usuário sem root, remoção de capabilities da aplicação, bloqueio de novos privilégios, sistema de arquivos somente leitura e separação da senha administrativa. O banco mantém apenas as capabilities usadas na inicialização. Em um sistema real, também seria necessário ajustar as permissões SQL às operações da aplicação.

**5. Por que o .env não deve ser enviado ao repositório?**

Porque contém valores sensíveis que não devem ficar acessíveis no código nem no histórico do Git.

**6. Qual é a função do .env.example?**

Servir como modelo para configurar o ambiente, mostrando as variáveis necessárias sem preencher as senhas.

**7. Como adicionar verificações em uma pipeline CI/CD?**

A pipeline poderia validar o Compose, verificar o Dockerfile com Hadolint, procurar secrets no código e analisar dependências e imagens com ferramentas como Trivy. Depois do build, poderia subir o ambiente de teste e conferir as rotas HTTP e a conexão com o banco. Os testes devem usar credenciais próprias para esse ambiente. Essas são propostas; não foi criada uma pipeline nesta atividade.

**8. Quais medidas poderiam ser aplicadas em Kubernetes?**

Seria possível configurar execução sem root, impedir elevação de privilégios, remover capabilities e limitar CPU e memória. Também seriam importantes NetworkPolicies, Secrets protegidos por controle de acesso e criptografia em repouso, probes de saúde e um Service interno para o banco. A persistência precisaria de volumes e uma estratégia de backup. As permissões necessárias à inicialização do MySQL também teriam que ser verificadas nesse ambiente.

## 4. Testes e resultados

Executei `validar.ps1` no Windows com Docker Desktop em 10/10/2026. Os dois containers ficaram saudáveis e todas as verificações do script passaram:

- Build da aplicação concluído.
- Aplicação com UID 1000 e processo principal do banco sem root.
- Capabilities efetivas da aplicação zeradas e NoNewPrivs=1.
- Escrita em `/app` bloqueada.
- Limites de CPU e memória conferidos na configuração dos containers.
- Banco sem portas publicadas no host.
- Aplicação acessível em `127.0.0.1:3000`.
- Mensagem original retornada por HTTP.
- Consulta `SELECT 1` autenticada com o usuário da aplicação.

O resumo está em `docs/validacao-docker-windows.md`. O registro completo foi salvo em `evidencias-locais/validacao-docker.txt` pelo script.

Também foram realizadas verificações iniciais de sintaxe, dependências, rotas e proteção do `.env`. Elas estão resumidas em `docs/validacao-local.txt`. A consulta `npm audit --omit=dev` não apontou vulnerabilidades naquele momento; esse resultado não cobre todos os componentes da imagem.

Os testes confirmam os pontos verificados pelo script. Não foram feitos testes de carga, invasão ou uma auditoria completa de segurança. Também não houve comparação da execução original em containers antes das alterações.

## 5. Problema de rede durante os testes

No primeiro teste, os dois containers ficaram saudáveis, mas a aplicação não estava acessível pela porta 3000. O comando `docker compose ps` mostrava apenas `3000/tcp`, sem o endereço do host.

A aplicação estava conectada somente à rede interna. Foi adicionada a rede `frontend`, mantendo o banco apenas na `backend`. Depois de recriar os containers, a porta apareceu como `127.0.0.1:3000->3000/tcp`. O acesso HTTP e a consulta ao banco funcionaram.

## Referências

- Enunciado da atividade: `docs/atividade.md`.
- [Serviços no Docker Compose](https://docs.docker.com/reference/compose-file/services/).
- [Redes no Docker Compose](https://docs.docker.com/reference/compose-file/networks/).
- [Imagem oficial MySQL](https://hub.docker.com/_/mysql).
- [Entrypoint oficial do MySQL 8.4](https://github.com/docker-library/mysql/blob/master/8.4/docker-entrypoint.sh).
- [Imagem oficial Node.js](https://hub.docker.com/_/node).
