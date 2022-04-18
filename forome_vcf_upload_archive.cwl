#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  archive: File
  case_name: string
  case_assembly: int
  ocProject: string
  ocPod: string
  ocToken: string
  ocServer: string
  bucket_name: string
  access_key: string
  secret_key: string
  region_name: string
  output_format: string
  login: string
  password: string

steps:

  step1_extract_case:
    run: forome_tar_extract.cwl
    in:
      archive: archive
      case_name: case_name
    out: [dir, file_vcf, file_cfg, file_fam]

  step2_vep_annotation:
    run: forome_vep.cwl
    in:
      file_vcf: step1_extract_case/file_vcf
      case_name: case_name
      case_assembly: case_assembly
    out: [out]

  step3_java_annotation:
    run: forome_java_annotation.cwl
    in:
      output: step2_vep_annotation/out
      case_name: case_name
      directory: step1_extract_case/dir
    out: [out]

  step4_archive_case:
    run: forome_tar_archive.cwl
    in:
      output: step3_java_annotation/out
      case_name: case_name
      dataset: step1_extract_case/dir
    out: [archive]

  step5_upload_to_bucket:
    run: forome_aws_copy.cwl
    in:
      archive: step4_archive_case/archive
      bucket_name: bucket_name
      access_key: access_key
      secret_key: secret_key
      region_name: region_name
      output_format: output_format
      login: login
      password: password
    out: [log_upload_to_bucket]

  step6_upload_to_anfisa:
    run: forome_openshift.cwl
    in:
      log: step5_upload_to_bucket/log_upload_to_bucket
      ocProject: ocProject
      ocPod: ocPod
      ocToken: ocToken
      ocServer: ocServer
      case_name: case_name
      archive: step4_archive_case/archive
    out: [upload_log]

outputs:
  log_dir:
    type: Directory
    outputSource: step1_extract_case/dir
  log_vcf:
    type: File
    outputSource: step1_extract_case/file_vcf
  log_cfg:   
    type: File
    outputSource: step1_extract_case/file_cfg
  log_fam:
    type: File
    outputSource: step1_extract_case/file_fam
  log_vep:
    type: File
    outputSource: step2_vep_annotation/out
  log_java_annotation:
    type: File
    outputSource: step3_java_annotation/out
  log_archive:
    type: File
    outputSource: step4_archive_case/archive
  log_upload_to_bucket:
    type: File
    outputSource: step5_upload_to_bucket/log_upload_to_bucket
  log_upload_to_anfisa:
    type: File
    outputSource: step6_upload_to_anfisa/upload_log
