# Projeto Terraform com AWS

Atividade prática desenvolvida em sala para exercitar os conceitos básicos de Terraform e provisionamento de recursos na AWS.

O projeto cria um bucket S3, utiliza variável para definir a região, consulta informações com Data Sources e exibe resultados com Outputs.

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

### main.tf

Contém a configuração do provider AWS e o recurso responsável pela criação do bucket S3.

### variables.tf

Declara a variável `region`, seu tipo, valor padrão e uma validação para aceitar somente as regiões definidas na atividade.

### terraform.tfvars

Define o valor utilizado para a variável `region` durante a execução do projeto.

### data.tf

Utiliza Data Sources para consultar informações do bucket S3 e das zonas de disponibilidade da região escolhida.

### outputs.tf

Exibe no terminal informações do bucket criado e dos Data Sources consultados.

### .gitignore

Impede que arquivos locais e arquivos de estado do Terraform sejam enviados para o repositório.

## Conexão com a AWS

Antes de executar o Terraform, é necessário ter uma conta AWS, a AWS CLI e o Terraform instalados.

Para configurar as credenciais localmente:

```bash
aws configure
```

Serão solicitadas informações como:

```text
AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format
```

As credenciais não devem ser colocadas dentro dos arquivos Terraform nem enviadas para o GitHub.

Para verificar a conexão com a AWS:

```bash
aws sts get-caller-identity
```

## Como executar o projeto

### 1. Inicializar o Terraform

```bash
terraform init
```

Esse comando prepara o diretório de trabalho e baixa o provider necessário.

### 2. Formatar os arquivos

```bash
terraform fmt
```

Padroniza a formatação dos arquivos `.tf`.

### 3. Validar a configuração

```bash
terraform validate
```

Verifica se a sintaxe e a estrutura dos arquivos estão corretas.

### 4. Visualizar o plano

```bash
terraform plan
```

Mostra quais recursos serão criados antes de executar as alterações.

### 5. Criar a infraestrutura

```bash
terraform apply
```

Depois de conferir o plano, digite:

```text
yes
```

O Terraform criará o bucket S3 e mostrará os Outputs no terminal.

### 6. Consultar novamente os Outputs

```bash
terraform output
```

### 7. Remover a infraestrutura

Ao terminar a prática:

```bash
terraform destroy
```

Confirme digitando:

```text
yes
```

## Anotações do que foi aprendido

Durante a aula foram praticados os seguintes conceitos:

- Terraform como ferramenta de Infraestrutura como Código
- Uso do provider AWS para conexão com a nuvem
- Criação de recursos com o bloco `resource`
- Uso de variáveis com `variable`
- Sobrescrita de valores utilizando `terraform.tfvars`
- Validação de valores com `validation` e `contains`
- Consulta de recursos e informações existentes utilizando `data`
- Uso de `output` para exibir informações após a execução
- Comandos `terraform init`, `fmt`, `validate`, `plan`, `apply` e `destroy`
- Importância de não publicar credenciais e arquivos de estado no GitHub

## Observação

Durante a aula, Construímos os códigos em tempo real. Nesta versão foram mantidos os mesmos conceitos e estrutura vistos em sala, com adições de conceitos e comentários nos códigos por questao de didática
