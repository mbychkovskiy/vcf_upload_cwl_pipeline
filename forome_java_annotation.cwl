#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
baseCommand: ["bash", "/data/annotation/annotation_fg.sh"]
arguments:
- $(inputs.directory.path)/$(inputs.case_name).cfg

inputs:
  case_name:
    type: string
  directory:
    type: Directory

outputs:
  out:
    type: stdout

stdout: java_annotation.log
