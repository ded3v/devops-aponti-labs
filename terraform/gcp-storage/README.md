# Terraform · Google Cloud Storage

Configuração de um bucket com acesso uniforme via IAM. Inclui variáveis validadas, consultas ao bucket e ao provider, além de outputs.

## Preparar e validar

Requisito: Terraform 1.5 ou superior. O provider Google é declarado na série `~> 7.0`.

```bash
cd terraform/gcp-storage
terraform fmt -check
terraform init -backend=false
terraform validate
```

A inicialização precisa baixar o provider. Validar a configuração não comprova que recursos foram criados na cloud.

## Provisionamento

Consulte [o guia completo](README-original.md) para a autenticação. Preencha `project_id` e escolha um `bucket_name` único no `terraform.tfvars` antes de executar `terraform plan` e, após revisar o resultado, `terraform apply`.

O código usa `force_destroy = false`: objetos existentes precisam ser removidos antes de destruir o bucket. A execução na cloud requer projeto, permissões e configuração de faturamento apropriados.

## O que foi praticado

Provider, resource, data sources, variáveis com validation e outputs. Os valores no tfvars são exemplos.

## Origem

Importado de [ded3v/Terraform-GoogleCloud](https://github.com/ded3v/Terraform-GoogleCloud).
