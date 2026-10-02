# Configura o provider AWS utilizando a região definida na variável region
provider "aws" {
  region = var.region
}

# Cria um bucket S3 na AWS
resource "aws_s3_bucket" "meu_bucket" {
  bucket = "test-aponti-andre"
}
