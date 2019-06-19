GCLOUD_PROJECT:=$(shell gcloud config list project --format="value(core.project)")

PHONY: build
build:
	gcloud builds submit --tag  gcr.io/${GCLOUD_PROJECT}/go-helloworld

PHONY: cloudrun-deploy
cloudrun-deploy:
	gcloud beta run deploy --image gcr.io/${GCLOUD_PROJECT}/go-helloworld

PHONY: gae-standard-deploy
gae-standard-deploy:
	gcloud app deploy 

PHONY: gke-deploy
gke-deploy:
	kubectl apply -f k8s/deployments.yaml
	kubectl apply -f k8s/service.yaml

PHONY: gke-delete
gke-delete:
	kubectl delete -f k8s/deployments.yaml
	kubectl delete -f k8s/service.yaml
