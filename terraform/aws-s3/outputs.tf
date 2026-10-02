# Exibe o nome do bucket criado
output "nome_do_bucket" {
  value = aws_s3_bucket.meu_bucket.bucket
}

# Exibe o ID do bucket criado
output "id_do_bucket" {
  value = aws_s3_bucket.meu_bucket.id
}

# Exibe as informações consultadas pelo Data Source do bucket
output "informacao_data" {
  value = data.aws_s3_bucket.bucket_existente
}

# Exibe as zonas de disponibilidade encontradas na região
output "aws_availability_zones" {
  value = data.aws_availability_zones.available
}
