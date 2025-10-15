package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "cloudflared"
	Namespace: "network"
	Chart: {
		name:    "app-template"
		version: "4.4.0"
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
			  http2Origin: true
			  originServerName: external.brenix.com

			ingress:
			  - hostname: brenix.com
			    service: https://envoy-kube-system-external-e7092cdf.kube-system.svc.cluster.local
			  - hostname: "*.brenix.com"
			    service: https://envoy-kube-system-external-e7092cdf.kube-system.svc.cluster.local
			  - service: http_status:404
			"""
	}
}
