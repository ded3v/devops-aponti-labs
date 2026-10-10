# Evidência da pipeline

A pipeline foi executada em 10/10/2026, às 16:42 no horário de Brasília, após o envio dos commits para main.

- Workflow: **GitHub Secrets - demonstração**.
- Job: `executar`.
- Resultado: **Success**.
- Commit: `aafadd8d91bb6c68d1894ba55de57490086c069d`.
- [Link da execução](https://github.com/ded3v/devops-aponti-labs/actions/runs/38080865458).

As etapas de checkout, configuração do Node.js, instalação das dependências e execução da aplicação passaram.

Na etapa **Executar aplicação com o Secret**, o log mostrou a variável mascarada:

```text
MENSAGEM_SECRETA: ***
```

A aplicação exibiu:

```text
Secret recebido pela aplicação com sucesso.
```

Isso confirma que a variável chegou à aplicação sem que seu valor fosse mostrado nos logs. O workflow contém somente a referência `${{ secrets.MENSAGEM_SECRETA }}`.

A execução apresentou avisos sobre o runtime das actions v4 e uma futura mudança de ubuntu-latest. Esses avisos não impediram a execução. O Node.js configurado para a aplicação foi o 22.
