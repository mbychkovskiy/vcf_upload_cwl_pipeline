#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["tar"]
arguments:
- -czvf
- $(inputs.case_name)_annotated.tar.gz
- -C
- $(inputs.dataset)
- .
inputs:
  dataset:
    type: Directory
  case_name:
    type: string
  output:
    type: File

outputs:
  archive:
    type: File
    outputBinding:
      glob: "*.tar.gz"
