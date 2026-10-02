# Consulta informações do bucket criado pelo próprio Terraform.
data "google_storage_bucket" "bucket_existente" {
  # Utiliza o nome do recurso criado em main.tf para realizar a consulta.
  name = google_storage_bucket.meu_bucket.name

  # Define o projeto onde o bucket deve ser consultado.
  project = var.project_id
}

# Consulta informações da configuração atual do provider Google.
data "google_client_config" "atual" {
  # Este Data Source não exige argumentos e retorna dados como projeto e região do provider.
}
