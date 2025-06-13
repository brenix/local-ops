package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "cloudflared"
	Namespace: "network"
	Chart: {
		name:    "app-template"
		version: "4.1.1"
		release: "cloudflared"
		repository: {
			name: "bjw-s"
			url:  "https://bjw-s-labs.github.io/helm-charts"
		}
	}

	APIVersions: ["gateway.networking.k8s.io/v1/HTTPRoute"]

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
			    service: https://cilium-gateway-external.kube-system.svc.cluster.local
			  - hostname: "*.brenix.com"
			    service: https://cilium-gateway-external.kube-system.svc.cluster.local
			  - service: http_status:404
			"""
	}
}
