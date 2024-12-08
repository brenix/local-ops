package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		spec: {
			target: name: "gitea-admin"
			target: template: {
				engineVersion: "v2"
				data: {
					username: "{{ .USERNAME }}"
					password: "{{ .PASSWORD }}"
					email:    "{{ .EMAIL }}"
				}
			}
			dataFrom: [{extract: key: "gitea"}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "onepassword-connect"
		}
	}
}
