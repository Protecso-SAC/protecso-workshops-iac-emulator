# Ejemplos del taller AWS Emulator en local

Código de práctica del taller [AWS Emulator en local](https://workshop.protecso.io/aws-emulator/00-introduccion/)
de los Workshops Protecso. Con el emulador de AWS corriendo en tu máquina, usas el
CLI, un SDK y Terraform sin una cuenta de AWS.

Esta carpeta se mantiene en el monorepo
[`protecso-workshops`](https://github.com/Protecso-SAC/protecso-workshops)
(`workshops/aws-emulator/`), que es la fuente de verdad. Este repositorio es una copia
publicada: no edites aquí, abre los cambios en el monorepo.

## Contenido

| Ruta | Para qué |
| ---- | -------- |
| `Dockerfile` | Construye la imagen del emulador (AWS no publica una) |
| `emulador-env.sh` / `emulador-env.ps1` | Apuntan tu terminal al emulador y borran credenciales reales |
| `local/main.tf` | Terraform de un bucket privado y una cola SQS contra el emulador |
| `ejemplos/prueba.mjs` | Script del SDK de JavaScript que escribe y lee un elemento de DynamoDB |

## Cómo se usa

Necesitas `docker` y el AWS CLI v2. La guía explica cada paso y qué deberías ver.

```bash
# Imagen: aarch64 en Mac con Apple Silicon o PC con Arm; x86_64 en Intel o AMD
docker build --build-arg ARCH=aarch64 -t aws-emulator .

# Emulador (déjalo corriendo en su propia terminal)
mkdir -p ~/.aws/emulator
docker run --rm --memory=2g --memory-swap=2g -p 127.0.0.1:9297:9297 \
  -e HOME="$HOME" -v "$HOME/.aws/emulator:$HOME/.aws/emulator" \
  aws-emulator -p 9297 --telemetry off

# En otra terminal
source emulador-env.sh
aws sts get-caller-identity --query Account --output text   # 000000000000
```

En Windows, usa `. .\emulador-env.ps1` y los comandos de PowerShell de la guía.

## Qué está probado

Se ejecutó todo con Docker sobre Colima en un Mac con Apple Silicon: la imagen, el CLI,
el script de JavaScript y Terraform 1.16.1 (`apply` y un `plan` limpio después). No se
probaron Windows, Docker Desktop, WSL ni un pipeline de CI.

## Límites que importan

El emulador no evalúa las políticas de IAM como AWS, funciona como una sola cuenta y una
sola región, y lo que no implementa responde HTTP 501. Un resultado verde aquí no
reemplaza una prueba en AWS antes de producción.
