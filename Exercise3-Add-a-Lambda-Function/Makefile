#Makefile

.PHONY: all

all: init plan build

init:
	rm -rf .terraform/modules/
	terraform init -reconfigure

plan: init
	terraform plan -refresh=true

build: init
	terraform apply -auto-approve

taint:
	terraform taint -allow-missing null_resource.bots  
	terraform taint -allow-missing null_resource.intents  
	terraform taint -allow-missing null_resource.slot-type 

check: init
	terraform plan -detailed-exitcode

destroy: init
	terraform destroy -force

docs:
	terraform-docs md . > README.md

valid:
	tflint
	terraform fmt -check=true -diff=true
