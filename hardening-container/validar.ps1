# Execute na pasta do projeto com Docker Desktop iniciado (containers Linux).
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
New-Item -ItemType Directory -Force evidencias-locais | Out-Null
Start-Transcript -Path evidencias-locais/validacao-docker.txt -Force
function Invoke-Docker {
    & docker @args
    if ($LASTEXITCODE -ne 0) { throw 'Comando Docker falhou. Confira a saída acima.' }
}
function Assert-True($condition, $message) {
    if (-not $condition) { throw $message }
    Write-Host "PASSOU: $message"
}
try {
    Write-Host "Validação real em Docker: $(Get-Date -Format o)"
    # Não use config sem --quiet: a saída completa pode revelar secrets.
    Invoke-Docker compose config --quiet
    Invoke-Docker compose up -d --build --wait --wait-timeout 180
    Invoke-Docker compose ps
    $appId = (Invoke-Docker compose ps -q app).Trim()
    $dbId = (Invoke-Docker compose ps -q banco).Trim()
    # Inspeciona somente configurações de segurança, sem imprimir o Environment.
    $app = Invoke-Docker inspect --format '{{json .HostConfig}}' $appId | ConvertFrom-Json
    $db = Invoke-Docker inspect --format '{{json .HostConfig}}' $dbId | ConvertFrom-Json
    Assert-True ($app.ReadonlyRootfs -eq $true) 'Filesystem da aplicação somente leitura'
    Assert-True ($app.Privileged -eq $false -and $db.Privileged -eq $false) 'Containers sem privileged'
    Assert-True ($app.CapDrop -contains 'ALL') 'Aplicação remove todas as capabilities'
    Assert-True ($app.SecurityOpt -contains 'no-new-privileges:true') 'Aplicação sem novos privilégios'
    Assert-True ($app.NanoCpus -eq 500000000 -and $app.Memory -eq 268435456) 'Aplicação: 0,5 CPU e 256 MiB'
    Assert-True ($db.NanoCpus -eq 1000000000 -and $db.Memory -eq 805306368) 'Banco: 1 CPU e 768 MiB'
    $ports = Invoke-Docker inspect --format '{{json .NetworkSettings.Ports}}' $dbId | ConvertFrom-Json
    $published = @($ports.PSObject.Properties | Where-Object { $null -ne $_.Value })
    Assert-True ($published.Count -eq 0) 'Banco sem portas publicadas'
    $uid = (Invoke-Docker compose exec -T app id -u).Trim()
    Assert-True ($uid -eq '1000') 'Aplicação usa UID 1000, sem root'
    Invoke-Docker compose exec -T app node -e "const fs=require('fs'); const s=fs.readFileSync('/proc/self/status','utf8'); if(!/^CapEff:\s+0+$/m.test(s)||!/^NoNewPrivs:\s+1$/m.test(s))process.exit(1); console.log('Capabilities efetivas zeradas e NoNewPrivs=1');"
    Invoke-Docker compose exec -T app node -e "try { require('fs').writeFileSync('/app/teste-escrita','x'); process.exit(1); } catch(e) { if(!['EROFS','EACCES'].includes(e.code)) throw e; console.log('Escrita em /app bloqueada'); }"
    # O PID 1 do banco deve ser mysqld, executado pelo usuário mysql.
    $dbStatus = (Invoke-Docker compose exec -T banco cat /proc/1/status) -join "`n"
    $dbUid = [regex]::Match($dbStatus, '(?m)^Uid:\s+(\d+)').Groups[1].Value
    Assert-True ($dbUid -ne '0' -and $dbUid -match '^\d+$') 'Processo principal do banco sem root'
    $respostaInicial = Invoke-RestMethod http://localhost:3000/
    Assert-True ($respostaInicial.mensagem -eq 'Olá mundo!') 'HTTP: mensagem original preservada'
    $ready = Invoke-RestMethod http://localhost:3000/ready
    Assert-True ($ready.banco -eq 'conectado') 'HTTP: SELECT 1 autenticado com usuário da aplicação'
    Write-Host 'Todas as verificações do script passaram.'
} finally {
    Stop-Transcript
}
