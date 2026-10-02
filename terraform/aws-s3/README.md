# Terraform · AWS S3

Exercício de infraestrutura como código que cria um bucket S3 e consulta informações do bucket e das zonas de disponibilidade.

## Preparar e validar

```bash
cd terraform/aws-s3
terraform fmt -check
terraform init -backend=false
terraform validate
```

A inicialização baixa o provider. Não há restrição explícita de versão do provider nesta configuração; registre o lockfile gerado ao evoluir o laboratório.

## Provisionamento

Consulte [a documentação original](README-original.md) para a conexão com AWS. Configure suas credenciais fora do repositório e ajuste o nome fixo do bucket em `main.tf` para um nome globalmente único. O tfvars define a região `us-east-1`.

Revise `terraform plan` antes de executar `terraform apply`. A validação local não é evidência de provisionamento real.

## O que foi praticado

Provider, resource, data sources, variáveis, validação de região e outputs.

## Origem

Importado de [ded3v/terraform-aws-s3](https://github.com/ded3v/terraform-aws-s3).
