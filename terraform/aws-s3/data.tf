# Consulta informações do bucket criado pelo Terraform
data "aws_s3_bucket" "bucket_existente" {
  bucket = aws_s3_bucket.meu_bucket.bucket
}

# Consulta as zonas de disponibilidade disponíveis na região configurada
data "aws_availability_zones" "available" {
  state = "available"
}
