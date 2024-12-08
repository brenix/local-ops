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
				data: {
					MONGO_USER: "{{ .username }}"
					MONGO_PASS: "{{ .password }}"
				}
			}
			dataFrom: [{extract: key: "mongodb"}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "onepassword-connect"
		}
	}
}
