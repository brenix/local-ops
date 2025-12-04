package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "metallb"
	Namespace: "kube-system"
	KubeVersion: "1.32.0"
	Chart: {
		name:    "metallb"
		version: "0.15.3"
		repository: {
			name: "metallb"
			url:  "https://metallb.github.io/metallb"
		}
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
