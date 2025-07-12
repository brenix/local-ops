package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:      "rook-ceph-cluster"
	Namespace: "rook-ceph"
	Chart: {
		name:    "rook-ceph-cluster"
		version: "v1.17.6"
		release: "rook-ceph-cluster"
		repository: {
			name: "rook-ceph"
			url:  "https://charts.rook.io/release"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
