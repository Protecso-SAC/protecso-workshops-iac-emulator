# Uso: source emulador-env.sh [puerto]
PUERTO="${1:-9297}"
DIR="$HOME/.aws/emulator/$PUERTO"

export AWS_ENDPOINT_URL="https://127.0.0.1:$PUERTO"
export AWS_SHARED_CREDENTIALS_FILE="$DIR/emulator_credentials"
export AWS_CONFIG_FILE="$DIR/config"
export AWS_CA_BUNDLE="$DIR/ca.pem"
export NODE_EXTRA_CA_CERTS="$DIR/ca.pem"
export AWS_EC2_METADATA_DISABLED=true
export AWS_DISABLE_HOST_PREFIX_INJECTION=true
export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=us-east-1

# Que ninguna credencial real se cuele en la sesión.
unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_PROFILE
