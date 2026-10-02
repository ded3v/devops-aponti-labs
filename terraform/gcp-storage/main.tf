# Define os requisitos gerais do Terraform utilizados neste projeto.
terraform {
  # Define a versão mínima do Terraform necessária para executar a configuração.
  required_version = ">= 1.5.0"

  # Declara os providers externos necessários para o projeto.
  required_providers {
    # Utiliza o provider oficial da Google Cloud mantido pela HashiCorp.
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

# Configura o provider Google utilizando o projeto e a região definidos nas variáveis.
provider "google" {
  project = var.project_id
  region  = var.region
}

# Cria um bucket no Google Cloud Storage para demonstrar o provisionamento com Terraform.
resource "google_storage_bucket" "meu_bucket" {
  # O nome do bucket deve ser globalmente único dentro do Google Cloud Storage.
  name = var.bucket_name

  # Define a localização física onde os dados do bucket serão armazenados.
  location = var.bucket_location

  # Informa em qual projeto da Google Cloud o recurso será criado.
  project = var.project_id

  # Evita a remoção automática do bucket caso ele ainda possua objetos armazenados.
  force_destroy = false

  # Centraliza o controle de acesso no IAM, sem utilizar ACLs individuais por objeto.
  uniform_bucket_level_access = true
}
