#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [tar]
arguments:
- -xzvf
- $(inputs.archive)
inputs:
  archive:
    type: File
  case_name:
    type: string

outputs:
  dir:
    type: Directory
    outputBinding:
      glob: "*"
  file_vcf:
    type: File
    outputBinding:
      glob: "$(inputs.case_name)/*.vcf"
  file_cfg:
    type: File
    outputBinding:
      glob: "$(inputs.case_name)/*.cfg"
  file_fam:
    type: File
    outputBinding:
      glob: "$(inputs.case_name)/*.fam"
