# VCF Upload cwl pipeline

## Overview
VCF upload cwl pipeline is used to automatic VEP and Java annotations and upload an annotated dataset to Anfisa Pod deployed to IBM OpenShift cluster.

In order to upload annotated archive to the IBM bucket and upload dataset to Anfisa Pod "oc cli" and "aws cli" should be installed to annotation server.

## Run cwl pipeline

Firstly, needs to activate venv environment
```
source /data/astorage/venv/bin/activate
```

Navigate to the folder with the cwl pipeline. There are two options to run the cwl pipeline:
1. Run cwl pipeline for the dataset archive available by the public url
```
cwl-runner forome_vcf_upload_uri.cwl inp-job.yml
```
Specify case_uri and comment lines 4-6 in inp-job.yml input file.
Example:
```
case_uri: https://forome-dataset-public.s3.us-south.cloud-object-storage.appdomain.cloud/pgp3140_wgs_rtg1997.tar.gz
case_assembly: 38
case_name: pgp3140_wgs_rtg1997
#archive:
#  class: File
#  path: pgp3140_wgs_rtg1997.tar.gz
```

2. Run cwl pipeline for the dataset archive located on the server. In this case place archive to the same folder with cwl pipeline.
```
cwl-runner forome_vcf_upload_archive.cwl inp-job.yml
```
Specify archive and comment 1 line in inp-job.yml input file.
Example:
```
#case_uri: https://forome-dataset-public.s3.us-south.cloud-object-storage.appdomain.cloud/pgp3140_wgs_rtg1997.tar.gz
case_assembly: 38
case_name: pgp3140_wgs_rtg1997
archive:
  class: File
  path: pgp3140_wgs_rtg1997.tar.gz
```

Note: If dataset contains filename with illegal characters then run cwl-runner with argument ```--relax-path-checks```
Example:
```
cwl-runner --relax-path-checks <cwl workflow> <input file>
```

### CWL paratemeters (inp-job.yml)

| Parameter      | Description                                                                                                               | Required  |
| -------------- | --------------------------------------------------------------------------------------------------------------------------| :------:  |
| case_uri       | URL to the dataset archive                                                                                                | Yes*      |
| case_assembly  | Look through the inventory file .cfg, specify assembly 37 or 38                                                           | Yes       |
| case_name      | Name of the case                                                                                                          | Yes       |
| archive        | Name of the archive with dataset. Archive should be placed to the the same folder with cwl pipeline                       | Yes*      |
| ocProject      | OpenShift project (namespace) name                                                                                        | Yes       |
| ocToken        | Token of the service account to connect to OpenShift cluster                                                              | Yes       |
| ocServer       | OpenShift server                                                                                                          | Yes       |
| ocPod          | Anfisa backend Pod name                                                                                                   | Yes       |
| bucket_name    | Name of the bucket in the IBM cloud                                                                                       | Yes       |
| access_key     | Storage access key ID                                                                                                     | Yes       |
| secret_key     | Storage secret key                                                                                                        | Yes       |
| region_name    | Storage region                                                                                                            | Yes       |
| output_format  | Is used to build and store credentials for IBM bucket (should be json)                                                    | Yes       |
| login          | Login name on the server where cwl pipeline runs                                                                          | Yes       |
| password       | Password for the login                                                                                                    | Yes       |

*should be specified one of the parameter according to the run option.
