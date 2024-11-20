package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		spec: {
			target: name: Name
			target: template: {
				engineVersion: "v2"
				data: unpoller_password: "{{ .password }}"
			}
			dataFrom: [{extract: key: Name}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "onepassword-connect"
		}
	}
}
