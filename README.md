docker run -v $PWD:/opt/tf -w /opt/tf -e GOOGLE_BACKEND_CREDENTIALS=TF_VAR_json_credential -it hashicorp/terraform:1.1.3 init -backend=true

docker run -v $PWD:/opt/tf -w /opt/tf -e GOOGLE_BACKEND_CREDENTIALS=TF_VAR_json_credential -it hashicorp/terraform:1.1.3 validate

docker run -v $PWD:/opt/tf -w /opt/tf -e GOOGLE_BACKEND_CREDENTIALS=TF_VAR_json_credential -it hashicorp/terraform:1.1.3 plan 

docker run -v $PWD:/opt/tf -w /opt/tf -e GOOGLE_BACKEND_CREDENTIALS=TF_VAR_json_credential -it hashicorp/terraform:1.1.3 apply -auto-approve
