package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "velero"
	Namespace: "velero"
	Chart: {
		name:    "velero"
		version: "11.1.1"
		release: "velero"
		repository: {
			name: "vmware-tanzu"
			url:  "https://vmware-tanzu.github.io/helm-charts"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
