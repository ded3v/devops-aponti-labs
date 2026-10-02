# Projeto Terraform com Google Cloud

Atividade prática desenvolvida para exercitar os conceitos básicos de **Terraform** e provisionamento de infraestrutura na **Google Cloud Platform (GCP)**.

O projeto demonstra a configuração do provider Google, a criação de um bucket no **Google Cloud Storage**, o uso de variáveis, Data Sources e Outputs. De acordo com a proposta da atividade, a conexão real com a nuvem não é obrigatória; portanto, os códigos foram preparados com base na documentação oficial.

## Arquivos do projeto

```text
.
├── .gitignore
├── data.tf
├── main.tf
├── outputs.tf
├── README.md
├── terraform.tfvars
└── variables.tf
```

## O que cada arquivo faz

### `main.tf`

Contém o bloco `terraform`, a declaração do provider oficial `hashicorp/google`, a configuração do provider Google e o recurso `google_storage_bucket`, responsável pela criação de um bucket no Google Cloud Storage.

### `variables.tf`

Declara as variáveis utilizadas pelo projeto:

- `project_id`: identifica o projeto da Google Cloud;
- `region`: define a região padrão do provider;
- `bucket_location`: define a localização do bucket;
- `bucket_name`: define o nome globalmente único do bucket.

Também contém validações para evitar valores vazios ou fora das opções utilizadas no exercício.

### `terraform.tfvars`

Define os valores utilizados pelas variáveis durante a execução. O valor de `project_id` é apenas um exemplo e deve ser substituído pelo ID real de um projeto caso a infraestrutura seja criada de verdade.

### `data.tf`

Utiliza Data Sources para consultar informações:

- `google_storage_bucket`: consulta os dados do bucket criado pelo Terraform;
- `google_client_config`: consulta informações da configuração atual do provider Google.

### `outputs.tf`

Exibe informações importantes após a execução, como:

- nome do bucket;
- localização;
- projeto associado;
- link de referência do bucket;
- projeto e região configurados no provider.

### `.gitignore`

Evita o envio ao GitHub de arquivos locais, arquivos de estado, planos do Terraform e possíveis arquivos de credenciais.

## Conexão com a Google Cloud

A conexão real com a Google Cloud **não é obrigatória para esta atividade**. Caso fosse necessário executar o projeto, seria preciso ter:

- uma conta Google Cloud;
- um projeto criado na GCP;
- Google Cloud CLI (`gcloud`) instalada;
- Terraform instalado.

### 1. Fazer login na Google Cloud

```bash
gcloud auth login
```

### 2. Selecionar o projeto

```bash
gcloud config set project SEU_PROJECT_ID
```

### 3. Configurar as Application Default Credentials

Para uso local com Terraform, pode ser utilizado:

```bash
gcloud auth application-default login
```

O Terraform consegue utilizar essas credenciais automaticamente através do mecanismo de **Application Default Credentials (ADC)**.

> As credenciais não devem ser escritas diretamente nos arquivos `.tf` nem enviadas para o GitHub.

### 4. Conferir o projeto ativo

```bash
gcloud config get-value project
```

Antes de executar o Terraform, também seria necessário substituir no arquivo `terraform.tfvars`:

```hcl
project_id = "meu-projeto-gcp"
```

pelo ID real do projeto Google Cloud.

## Como executar o projeto

### 1. Inicializar o Terraform

```bash
terraform init
```

Prepara o diretório de trabalho e baixa o provider Google necessário para o projeto.

### 2. Formatar os arquivos

```bash
terraform fmt
```

Padroniza a formatação dos arquivos Terraform.

### 3. Validar a configuração

```bash
terraform validate
```

Verifica a sintaxe e a estrutura da configuração.

### 4. Visualizar o plano de execução

```bash
terraform plan
```

Mostra os recursos que o Terraform pretende criar antes de qualquer alteração na nuvem.

### 5. Criar a infraestrutura

```bash
terraform apply
```

Após conferir o plano, a execução pode ser confirmada digitando:

```text
yes
```

O Terraform criaria o bucket no Google Cloud Storage e exibiria os Outputs configurados.

### 6. Consultar os Outputs

```bash
terraform output
```

### 7. Remover a infraestrutura

Ao finalizar a prática:

```bash
terraform destroy
```

Depois, confirmar digitando:

```text
yes
```

## Anotações do que foi aprendido

Durante a atividade foram praticados os seguintes conceitos:

- Terraform como ferramenta de Infraestrutura como Código (IaC);
- diferença entre configuração do Terraform, provider e recursos;
- uso do provider Google para trabalhar com a Google Cloud;
- criação de recursos com o bloco `resource`;
- criação de um bucket usando `google_storage_bucket`;
- uso de variáveis com o bloco `variable`;
- sobrescrita de valores através do arquivo `terraform.tfvars`;
- validação de variáveis com `validation`, `contains`, `regex` e outras funções;
- uso de Data Sources para consultar informações existentes;
- uso de `output` para exibir informações após o processamento;
- utilização dos comandos `terraform init`, `fmt`, `validate`, `plan`, `apply`, `output` e `destroy`;
- importância de não publicar arquivos de estado nem credenciais no GitHub;
- uso de Application Default Credentials (ADC) para autenticação local do Terraform na Google Cloud.

## Observação

Os códigos deste projeto foram desenvolvidos para atender à atividade acadêmica e reproduzir, na Google Cloud, os mesmos conceitos praticados anteriormente com Terraform na AWS aqui na mesma pasta dos peojetos. A conexão e o provisionamento real dos recursos não são obrigatórios para fins desse projeto, mas o deixa preparado para tal com foco no aprendizado didático da atividade.

## Referências

- Documentação oficial do Terraform Provider Google: https://registry.terraform.io/providers/hashicorp/google/latest/docs
- Recurso Google Cloud Storage Bucket: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
- Data Source Google Cloud Storage Bucket: https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_bucket
- Autenticação do Terraform na Google Cloud: https://cloud.google.com/docs/terraform/authentication
