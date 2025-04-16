package holos

holos: Component.BuildPlan

Component: #Helm & {
	Name:        "kubelet-csr-approver"
	Namespace:   "kube-system"
	EnableHooks: true
	Chart: {
		name:    "kubelet-csr-approver"
		version: "1.2.7"
		release: "kubelet-csr-approver"
		repository: {
			name: "postfinance"
			url:  "https://postfinance.github.io/kubelet-csr-approver"
		}
	}

	Values: #Values

	KustomizeConfig: Kustomization: namespace: Namespace
}
