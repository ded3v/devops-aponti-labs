# Exibe o nome do bucket criado pelo Terraform após o processamento da configuração.
output "nome_do_bucket" {
  # Obtém diretamente o atributo name do recurso google_storage_bucket.
  value = google_storage_bucket.meu_bucket.name
}

# Exibe a localização configurada para o bucket.
output "localizacao_do_bucket" {
  # Retorna a região/localização utilizada na criação do recurso.
  value = google_storage_bucket.meu_bucket.location
}

# Exibe o ID do projeto associado ao bucket consultado pelo Data Source.
output "projeto_do_bucket" {
  # O valor é obtido através do Data Source declarado em data.tf.
  value = data.google_storage_bucket.bucket_existente.project
}

# Exibe o link de referência do bucket retornado pelo Data Source.
output "self_link_do_bucket" {
  # O self_link identifica o recurso através de uma referência fornecida pela API do Google Cloud.
  value = data.google_storage_bucket.bucket_existente.self_link
}

# Exibe o projeto atualmente configurado no provider Google.
output "projeto_provider" {
  # Consulta o projeto através do Data Source google_client_config.
  value = data.google_client_config.atual.project
}

# Exibe a região atualmente configurada no provider Google.
output "regiao_provider" {
  # Consulta a região definida no provider para facilitar a conferência da configuração.
  value = data.google_client_config.atual.region
}
