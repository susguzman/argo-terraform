docker run -v $PWD:/opt/tf -w /opt/tf -it hashicorp/terraform:1.1.3 init

docker run -v $PWD:/opt/tf -w /opt/tf -it hashicorp/terraform:1.1.3 validate

docker run -v $PWD:/opt/tf -w /opt/tf -it hashicorp/terraform:1.1.3 plan

docker run -v $PWD:/opt/tf -w /opt/tf -it hashicorp/terraform:1.1.3 apply -auto-approve
