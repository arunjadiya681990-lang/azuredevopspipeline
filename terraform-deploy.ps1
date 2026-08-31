param(
    [string]$TerraformDirectory = ".",
    [string]$Environment = "dev"
)

$ErrorActionPreference = "Stop"

Write-Host "========================================"
Write-Host "Terraform Deployment Started"
Write-Host "Environment: $Environment"
Write-Host "========================================"

# Terraform directory mein jana
Set-Location $TerraformDirectory

# Terraform installed hai ya nahi
Write-Host "`nChecking Terraform version..."
terraform version

if ($LASTEXITCODE -ne 0) {
    throw "Terraform is not installed or not available in PATH."
}

# Terraform Init
Write-Host "`n========================================"
Write-Host "Running Terraform Init"
Write-Host "========================================"

terraform init `
    -input=false `
    -upgrade

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

# Terraform Validate
Write-Host "`n========================================"
Write-Host "Running Terraform Validate"
Write-Host "========================================"

terraform validate

if ($LASTEXITCODE -ne 0) {
    throw "Terraform validate failed."
}

# Terraform Plan
Write-Host "`n========================================"
Write-Host "Running Terraform Plan"
Write-Host "========================================"

terraform plan `
    -input=false `
    -out="tfplan"

if ($LASTEXITCODE -ne 0) {
    throw "Terraform plan failed."
}

# Terraform Apply
Write-Host "`n========================================"
Write-Host "Running Terraform Apply"
Write-Host "========================================"

terraform apply `
    -input=false `
    -auto-approve `
    "tfplan"

if ($LASTEXITCODE -ne 0) {
    throw "Terraform apply failed."
}

Write-Host "`n========================================"
Write-Host "Terraform Deployment Successful!"
Write-Host "========================================" -ForegroundColor Green