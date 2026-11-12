param([int]$Puerto = 9297)
$dir = "$env:USERPROFILE\.aws\emulator\$Puerto"

$env:AWS_ENDPOINT_URL = "https://127.0.0.1:$Puerto"
$env:AWS_SHARED_CREDENTIALS_FILE = "$dir\emulator_credentials"
$env:AWS_CONFIG_FILE = "$dir\config"
$env:AWS_CA_BUNDLE = "$dir\ca.pem"
$env:NODE_EXTRA_CA_CERTS = "$dir\ca.pem"
$env:AWS_EC2_METADATA_DISABLED = "true"
$env:AWS_DISABLE_HOST_PREFIX_INJECTION = "true"
$env:AWS_REGION = "us-east-1"
$env:AWS_DEFAULT_REGION = "us-east-1"

# Que ninguna credencial real se cuele en la sesión.
foreach ($v in "AWS_ACCESS_KEY_ID","AWS_SECRET_ACCESS_KEY","AWS_SESSION_TOKEN","AWS_PROFILE") {
  Remove-Item "Env:$v" -ErrorAction SilentlyContinue
}
