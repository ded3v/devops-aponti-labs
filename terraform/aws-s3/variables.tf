# Define a região utilizada pelo provider AWS
variable "region" {
  description = "Região utilizada para criação dos recursos"
  type        = string
  nullable    = false
  default     = "sa-east-1"

  # Valida se a região informada está entre as permitidas
  validation {
    condition = contains(
      ["us-east-1", "us-east-2", "sa-east-1"],
      var.region
    )

    error_message = "Erro: esta variável aceita apenas as regiões us-east-1, us-east-2 e sa-east-1."
  }
}
