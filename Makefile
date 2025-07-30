deploy:
	bash scripts/deploy.sh

app:
	kubectl apply -f manifests/app-deployment.yaml

dashboards:
	kubectl create configmap node-exporter-dashboard \
		--from-file=dashboards/node-exporter.json \
		-n monitoring --dry-run=client -o yaml |
		kubectl label -f - grafana_dashboard="1" | \
		kubectl apply -f -

port-forward:
	kubectl port-forward -n monitoring svc/grafana 3000:80
