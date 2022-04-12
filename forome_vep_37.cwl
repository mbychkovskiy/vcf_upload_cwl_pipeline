#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
baseCommand: ["bash", "/data/astorage/Anfisa-Annotations/pipeline/projects/ensembl-vep/run37.sh"]
arguments:
- $(inputs.file_vcf)
inputs:
  file_vcf:
    type: File
  case_name:
    type: string

outputs: []