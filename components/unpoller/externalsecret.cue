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
				data: unpoller_password: "{{ .UNPOLLER_PASS }}"
			}
			data: [{secretKey: "UNPOLLER_PASS", remoteRef: {key: "UNPOLLER_PASS"}}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
