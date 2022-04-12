#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [curl]
inputs:
  case_uri:
    type: string
    inputBinding:
      prefix: -O

outputs:
  data:
    type: File?
    outputBinding:
      glob: "*.tar.gz"