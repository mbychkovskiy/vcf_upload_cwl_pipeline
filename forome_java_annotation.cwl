#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
baseCommand: ["bash"]
arguments:
- "/data/annotation/annotation_test.sh"
- $(inputs.directory.path)/$(inputs.case_name).cfg
inputs:
  case_name:
    type: string
  directory:
    type: Directory

outputs:
  out:
    type: stdout

stdout: java_output.txt