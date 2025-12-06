package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "nginx-internal"
	Namespace:   "network"
	EnableHooks: true
	KubeVersion: "1.32.0"
	Chart: {
		name:    "ingress-nginx"
		version: "4.14.1"
		release: "nginx-internal"
		repository: {
			name: "ingress-nginx"
			url:  "https://kubernetes.github.io/ingress-nginx"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
