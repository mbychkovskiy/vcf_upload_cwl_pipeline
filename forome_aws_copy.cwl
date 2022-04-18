#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
requirements:
  ShellCommandRequirement: {}
arguments:
- shellQuote: false
  valueFrom: >
    echo "[default]" > /home/$(inputs.login)/.aws/credentials &&
    echo "aws_access_key_id = $(inputs.access_key)" >> /home/$(inputs.login)/.aws/credentials &&
    echo "aws_secret_access_key = $(inputs.secret_key)" >> /home/$(inputs.login)/.aws/credentials &&
    echo "[default]" > /home/$(inputs.login)/.aws/config &&
    echo "region = $(inputs.region_name)" >> /home/$(inputs.login)/.aws/config &&
    echo "output = $(inputs.output_format)" >> /home/$(inputs.login)/.aws/config &&
    echo $(inputs.password) | su -c 'aws --endpoint-url https://s3.us-south.cloud-object-storage.appdomain.cloud s3 cp $(inputs.archive.path) $(inputs.bucket_name)' $(inputs.login)

inputs:
  access_key:
    type: string
  secret_key:
    type: string
  region_name:
    type: string
  output_format:
    type: string
  archive:
    type: File
  bucket_name:
    type: string
  login:
    type: string
  password:
    type: string

outputs:
  log_upload_to_bucket:
    type: stdout

stdout: upload_to_bucket.log
