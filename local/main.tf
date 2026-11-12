terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.63"
    }
  }
}

variable "participante" {
  description = "Identificador que va en el nombre de los recursos."
  type        = string
  default     = "demo"

  validation {
    condition     = can(regex("^[a-z0-9]([a-z0-9-]{0,18}[a-z0-9])?$", var.participante))
    error_message = "Usa minúsculas, números y guiones, sin empezar ni terminar en guion (máximo 20 caracteres)."
  }
}

locals {
  nombre = "taller-${var.participante}"
}

provider "aws" {
  region = "us-east-1"

  # El emulador no tiene cuenta real ni servicio de metadatos.
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true
}

resource "aws_s3_bucket" "sitio" {
  bucket = "${local.nombre}-sitio"
}

resource "aws_s3_bucket_public_access_block" "sitio" {
  bucket                  = aws_s3_bucket.sitio.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_sqs_queue" "cola" {
  name = "${local.nombre}-cola"
}
