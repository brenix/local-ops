package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "metallb"
	Namespace: "kube-system"
	Chart: {
		name:    "metallb"
		version: "0.15.2"
		repository: {
			name: "metallb"
			url:  "https://metallb.github.io/metallb"
		}
	}

	KustomizeConfig: Kustomization: namespace: Namespace
}
