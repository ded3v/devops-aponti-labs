# GitHub Secrets

**André Chagas Assis Costa — DevOps Turma 5**

Atividade baseada no projeto [github_secrets_demo](https://github.com/carlhenriquex/github_secrets_demo) do professor. O objetivo foi retirar a mensagem escrita diretamente no workflow e recebê-la pelo GitHub Secrets.

## Alteração principal

O workflow passou a fornecer a variável desta forma:

```yaml
env:
  MENSAGEM_SECRETA: ${{ secrets.MENSAGEM_SECRETA }}
```

A aplicação continua lendo `process.env.MENSAGEM_SECRETA`. Quando recebe um valor, exibe apenas a confirmação de recebimento. O conteúdo da mensagem e seu tamanho não são exibidos.

## Organização no Labs

A aplicação está na pasta `github-secrets-demo`. O workflow executável fica em `.github/workflows/github-secrets-demo.yml`, na raiz do repositório Labs. O GitHub não executa workflows colocados dentro da pasta de uma atividade.

O workflow roda em pushes para main que alteram os arquivos desta atividade. Também pode ser iniciado manualmente na aba Actions, usando Run workflow.

## Configurar o Secret

No repositório `ded3v/devops-aponti-labs`, acesse:

```text
Settings → Secrets and variables → Actions → New repository secret
```

Use o nome `MENSAGEM_SECRETA` e preencha o valor com uma mensagem escolhida para a prática. O valor deve ser inserido somente nesse campo do GitHub, sem ser copiado para os arquivos do projeto.

## Etapas da pipeline

1. Baixar o código com checkout.
2. Configurar Node.js 22.
3. Instalar as dependências usando npm ci e o lockfile.
4. Executar a aplicação com o Secret fornecido pelo ambiente.

O Secret é disponibilizado somente na etapa que executa a aplicação. O workflow tem permissão de leitura do conteúdo do repositório.

## Validar no GitHub

Depois de configurar o Secret e enviar os arquivos, abra a aba Actions. Procure o workflow **GitHub Secrets - demonstração** e confira a etapa **Executar aplicação com o Secret**.

O resultado esperado é:

```text
Secret recebido pela aplicação com sucesso.
```

Se o Secret estiver ausente ou vazio, a aplicação termina com erro. Isso evita que a pipeline passe sem receber a configuração necessária.

A execução no GitHub foi concluída com sucesso em 10/10/2026. A aplicação confirmou o recebimento e o valor ficou mascarado nos logs. O link e o resultado estão em `docs/EVIDENCIAS.md`.

## Documentação

- [Respostas e explicação](docs/RESPOSTAS.md)
- [Evidências](docs/EVIDENCIAS.md)
- [Enunciado](docs/atividade.md)

Na base consultada, o workflow se chama `main.yml`, embora o enunciado use o nome `pipeline.yml`. No Labs ele foi renomeado para identificar esta atividade.
