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
					"admin-user":     "{{ .GRAFANA_USER }}"
					"admin-password": "{{ .GRAFANA_PASS }}"
				}
			}
			data: [
				{secretKey: "GRAFANA_USER", remoteRef: {key: "GRAFANA_USER"}},
				{secretKey: "GRAFANA_PASS", remoteRef: {key: "GRAFANA_PASS"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
