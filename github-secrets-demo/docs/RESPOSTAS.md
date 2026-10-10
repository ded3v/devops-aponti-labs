# Utilização de GitHub Secrets

**André Chagas Assis Costa — DevOps Turma 5**

## Problema encontrado

Na configuração original, a mensagem estava escrita diretamente no campo `env` do workflow `.github/workflows/main.yml`. Como o arquivo fazia parte do repositório, o valor poderia ser visto por qualquer pessoa com acesso ao código.

A correção foi substituir o valor pela referência `${{ secrets.MENSAGEM_SECRETA }}`. O Secret deve ser cadastrado nas configurações do repositório Labs. Também foi retirada a impressão da quantidade de caracteres da mensagem; a aplicação confirma o recebimento sem mostrar informações sobre seu conteúdo.

## Questões da situação inicial

**1. Onde o segredo estava armazenado?**

No próprio arquivo do workflow, como valor da variável `MENSAGEM_SECRETA`.

**2. Quem poderia visualizar essa informação?**

Qualquer pessoa com acesso ao repositório. Em um repositório público, isso inclui qualquer visitante.

**3. Por que essa prática não é recomendada?**

Porque mistura informações sensíveis com o código e permite que elas fiquem registradas no histórico do Git.

**4. O que poderia acontecer se fosse uma senha ou um token real?**

Alguém poderia usar a credencial para acessar um serviço, consultar dados ou realizar ações com as permissões daquele usuário ou token. A credencial exposta precisaria ser revogada ou trocada.

## Como o Secret chega à aplicação

Nome utilizado: `MENSAGEM_SECRETA`.

O valor fica cadastrado em Settings → Secrets and variables → Actions, como Repository secret. Durante a execução, o GitHub Actions resolve a referência no workflow e fornece o valor na variável de ambiente da etapa que inicia a aplicação.

O código lê essa variável com:

```javascript
const mensagem = process.env.MENSAGEM_SECRETA;
```

Se estiver ausente, o programa termina com erro. Se estiver preenchida, imprime apenas a confirmação de recebimento.

O fluxo é: Secret cadastrado no GitHub → workflow → variável de ambiente → aplicação Node.js.

## Questões da atividade

**1. Qual é a diferença entre armazenar no pipeline.yml e no GitHub Secrets?**

No arquivo YAML, o valor fica junto do código e pode ser visto no repositório. No GitHub Secrets, ele é armazenado separadamente e fornecido durante a execução autorizada do workflow.

**2. Onde o valor fica configurado?**

Nas configurações do repositório, em Settings → Secrets and variables → Actions, na aba Secrets.

**3. O valor deve ser colocado no código da aplicação?**

Não. A aplicação deve receber o valor pelo ambiente, sem ter a senha ou a mensagem escrita no código.

**4. Qual é a função de process.env.MENSAGEM_SECRETA?**

Ler a variável de ambiente chamada `MENSAGEM_SECRETA` no processo Node.js.

**5. Por que utilizar Secrets é importante em uma pipeline CI/CD?**

Para usar credenciais sem publicá-las nos arquivos do projeto. Isso separa a configuração sensível do código e facilita a troca dos valores sem editar a aplicação. Mesmo assim, o workflow precisa ser confiável e não deve imprimir os secrets.

**6. Por que uma senha de banco não deve ficar diretamente no YAML?**

Porque o arquivo é versionado. Quem tiver acesso ao código ou ao histórico poderia recuperar a senha e tentar utilizá-la para acessar o banco.

## Validação

As verificações locais estão em `docs/validacao-local.txt`. A execução da pipeline com o Secret cadastrado ainda precisa ser confirmada no GitHub e registrada em `docs/EVIDENCIAS.md`.

## Referências

- [Projeto do professor](https://github.com/carlhenriquex/github_secrets_demo).
- [Uso de Secrets no GitHub Actions](https://docs.github.com/pt/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets).
