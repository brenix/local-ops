package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "cloudflared"
	Namespace: "network"
	Chart: {
		name:    "app-template"
		version: "3.7.0"
		release: "cloudflared"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace

	Resources: ConfigMap: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		data: "config.yaml": """
			originRequest:
			  originServerName: external.brenix.com

			ingress:
			  - hostname: brenix.com
			    service: https://nginx-external-controller.network.svc.cluster.local:443
			  - hostname: "*.brenix.com"
			    service: https://nginx-external-controller.network.svc.cluster.local:443
			  - service: http_status:404
			"""
	}
}
