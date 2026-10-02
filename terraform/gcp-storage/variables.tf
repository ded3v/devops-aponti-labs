# Define o ID do projeto da Google Cloud onde os recursos seriam provisionados.
variable "project_id" {
  # Descrição exibida pelo Terraform para documentar a finalidade da variável.
  description = "ID do projeto da Google Cloud"
  type        = string
  nullable    = false

  # Impede que o projeto seja informado como uma string vazia.
  validation {
    condition     = length(trimspace(var.project_id)) > 0
    error_message = "Erro: project_id não pode ser vazio."
  }
}

# Define a região padrão utilizada pelo provider Google.
variable "region" {
  description = "Região padrão utilizada pelo provider Google"
  type        = string
  nullable    = false

  # Utiliza São Paulo como região padrão por ser uma região disponível na América do Sul.
  default = "southamerica-east1"

  # Restringe a atividade a algumas regiões válidas utilizadas como exemplo.
  validation {
    condition = contains(
      ["southamerica-east1", "us-central1", "us-east1"],
      var.region
    )

    error_message = "Erro: use southamerica-east1, us-central1 ou us-east1."
  }
}

# Define a localização física do bucket no Google Cloud Storage.
variable "bucket_location" {
  description = "Localização do bucket no Google Cloud Storage"
  type        = string
  nullable    = false

  # Mantém a localização do bucket alinhada com a região padrão do projeto.
  default = "SOUTHAMERICA-EAST1"

  # Valida as localizações escolhidas para este exercício.
  validation {
    condition = contains(
      ["SOUTHAMERICA-EAST1", "US-CENTRAL1", "US-EAST1"],
      var.bucket_location
    )

    error_message = "Erro: use SOUTHAMERICA-EAST1, US-CENTRAL1 ou US-EAST1."
  }
}

# Define o nome do bucket que seria criado no Google Cloud Storage.
variable "bucket_name" {
  description = "Nome globalmente único do bucket"
  type        = string
  nullable    = false

  # Garante um nome básico compatível com o padrão utilizado pelo Cloud Storage.
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9._-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "Erro: use entre 3 e 63 caracteres minúsculos, números, ponto, hífen ou sublinhado."
  }
}
