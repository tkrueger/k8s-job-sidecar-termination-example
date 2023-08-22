#!/bin/sh

kind create cluster --config kind-config.yaml --wait 120s || echo "using existing kind cluster"
cd sidecar
docker build . -t sidecar
cd ..
kind load docker-image sidecar
kubectl create ns sidecar-trial || echo "using existing ns sidecar-trial"
kubectl -n sidecar-trial apply -f job-with-sidecar.yaml
kubectl -n sidecar-trial wait --for=condition=Ready pods -l job-name=countdown
kubectl -n sidecar-trial logs jobs/countdown --all-containers --prefix -f

