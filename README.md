# DevOps · FAP Labs

Laboratórios de André Chagas Assis Costa desenvolvidos durante a formação **FAP DevOps — Turma 5**.

Este repositório reúne exercícios menores de Git, containers, máquinas virtuais e infraestrutura como código. Cada laboratório possui suas instruções e uma referência ao repositório de origem.

## Laboratórios

| Área | Laboratório | O que foi praticado |
| --- | --- | --- |
| Git | [Primeiros comandos](git/primeiros-comandos/) | Inicialização, staging, commit, branch e remote |
| Git | [Boas práticas](git/boas-praticas/) | Colaboração, documentação e templates de issues e PRs |
| Docker | [Servidor HTTP Node.js](docker/node-http/) | Dockerfile, imagem, portas e volume |
| Vagrant | [Apache em Ubuntu](vagrant/apache/) | VM com VirtualBox, provisionamento Shell e porta encaminhada |
| Terraform | [AWS S3](terraform/aws-s3/) | Provider, resource, variáveis, data sources e outputs |
| Terraform | [Google Cloud Storage](terraform/gcp-storage/) | Bucket, validação de variáveis e consulta de recursos |

## Começar

```bash
git clone https://github.com/ded3v/devops-aponti-labs.git
cd devops-aponti-labs
```

Escolha um laboratório e siga o README da pasta. Os ambientes são independentes; não há comando único para iniciar todos.

## Projetos independentes

- [Vagrant + Jenkins](https://github.com/ded3v/vagrant-jenkins-cicd): duas VMs, testes e transferência por SCP.
- [CI Node.js](https://github.com/ded3v/jenkins-nodejs-ci): Jenkins e GitHub Actions.
- [Password Analyzer](https://github.com/ded3v/password-analyzer): Python e testes unitários.
- [Automação da turma](https://github.com/ded3v/aponti-fap-devops-turma5-2026): contribuição colaborativa.

## Origem e histórico

Consulte [ORIGENS.md](ORIGENS.md) para ver os repositórios e as árvores usadas na consolidação. Esta importação preserva os arquivos do estado consultado; o histórico de commits continua nos repositórios originais.

Quando disponível, o README anterior está em `README-original.md`. Os templates do guia de GitHub ficam dentro do laboratório correspondente, como material de estudo.

## Autoria

André Chagas Assis Costa — Recife/PE. Os créditos de atividades em grupo permanecem nos documentos originais.
