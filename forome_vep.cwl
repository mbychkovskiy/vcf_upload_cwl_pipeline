#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
baseCommand: ["bash"]
arguments:
- /data/astorage/Anfisa-Annotations/pipeline/projects/ensembl-vep/run$(inputs.case_assembly).sh
- $(inputs.file_vcf)
inputs:
  file_vcf:
    type: File
  case_name:
    type: string
  case_assembly:
    type: int

outputs:
  out:
    type: stdout

stdout: vep.log
