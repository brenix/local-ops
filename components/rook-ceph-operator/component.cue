package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "rook-ceph-operator"
	Namespace: "rook-ceph"
	KubeVersion: "1.32.0"
	Chart: {
		name:    "rook-ceph"
		version: "v1.18.8"
		release: "rook-ceph-operator"
		repository: {
			name: "rook-ceph"
			url:  "https://charts.rook.io/release"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
