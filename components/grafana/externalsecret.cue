package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: "grafana-admin": {
		metadata: name:      "grafana-admin"
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: {
				engineVersion: "v2"
				data: {
					"admin-user":     "{{ .username }}"
					"admin-password": "{{ .password }}"
				}
			}
			dataFrom: [{extract: key: "grafana"}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "onepassword-connect"
		}
	}
}
