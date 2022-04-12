#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  case_uri: string
  case_name: string
  case_assembly: int
steps:

  step1_download_case:
    run: forome_download_case.cwl
    in:
      case_uri: case_uri
    out: [data]

  step2_extract_case:
    run: forome_tar_extract.cwl
    in:
      archive: step1_download_case/data
      case_name: case_name
    out: [dir, file_vcf, file_cfg, file_fam]

  step3_vep_37_annotation:
    run: forome_vep_37.cwl
    in:
      assembly: case_assembly
      file_vcf: step2_extract_case/file_vcf
      case_name: case_name
    when: $(inputs.assembly == 37)
    out: []

  step3_vep_38_annotation:
    run: forome_vep_38.cwl
    in:
      assembly: case_assembly
      file_vcf: step2_extract_case/file_vcf
      case_name: case_name
    when: $(inputs.assembly == 38)
    out: []

  step4_java_annotation:
    run: forome_java_annotation.cwl
    in:
      case_name: case_name
      directory: step2_extract_case/dir
    out: [out]

  step5_archive_case:
    run: forome_tar_archive.cwl
    in:
      output: step4_java_annotation/out
      case_name: case_name
      dataset: step2_extract_case/dir
    out: [archive]

outputs:
  log_download:
    type: File
    outputSource: step1_download_case/data
  log_dir:
    type: Directory
    outputSource: step2_extract_case/dir
  log_vcf:
    type: File
    outputSource: step2_extract_case/file_vcf
  log_cfg:   
    type: File
    outputSource: step2_extract_case/file_cfg
  log_fam:
    type: File
    outputSource: step2_extract_case/file_fam
  log_archive:
    type: File
    outputSource: step5_archive_case/archive

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}