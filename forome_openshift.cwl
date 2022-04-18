#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
requirements:
  ShellCommandRequirement: {}
arguments:
- shellQuote: false
  valueFrom: >

    oc login --token=$(inputs.ocToken) --server=$(inputs.ocServer)

    oc project $(inputs.ocProject)

    oc exec $(inputs.ocPod) -- mkdir /anfisa/a-setup/data/$(inputs.case_name)

    oc exec $(inputs.ocPod) -- tar -xzvf /mnt/forome-datasets/Annotated/$(inputs.archive.basename) -C /anfisa/a-setup/data/$(inputs.case_name)

    oc exec $(inputs.ocPod) -- sh -c 'PYTHONPATH=/anfisa/anfisa/ python3 -u -m app.storage -c /anfisa/anfisa.json -m create --reportlines 1000 -f -k xl -i /anfisa/a-setup/data/$(inputs.case_name)/$(inputs.case_name).cfg xl_$(inputs.case_name)'

inputs:
  ocProject:
    type: string
  ocToken:
    type: string
  ocServer:
    type: string
  ocPod:
    type: string
  case_name:
    type: string
  archive:
    type: File
  

outputs:
  upload_log:
    type: stdout

stdout: upload_to_anfisa.log

