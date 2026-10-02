# Valores utilizados pelas variáveis do projeto.
# Caso a infraestrutura seja executada de verdade, substitua project_id pelo ID real do seu projeto GCP.
project_id = "meu-projeto-gcp"

# Região padrão utilizada pelo provider Google.
region = "southamerica-east1"

# Localização regional do bucket do Cloud Storage.
bucket_location = "SOUTHAMERICA-EAST1"

# O nome de um bucket precisa ser globalmente único na Google Cloud.
# Se for executar terraform apply, altere este valor caso o nome já esteja em uso.
bucket_name = "test-aponti-andre-gcp-2026"
