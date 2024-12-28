package holos

Component: {
	Name: string

	// Resources: ClusterSecretStore: "onepassword-connect": {
	// 	metadata: name: "onepassword-connect"
	// 	spec: provider: onepassword: {
	// 		connectHost: "http://onepassword-connect.security.svc.cluster.local:8080"
	// 		vaults: Kubernetes: 1
	// 		auth: secretRef: connectTokenSecretRef: {
	// 			name:      "onepassword-connect-secret"
	// 			key:       "token"
	// 			namespace: "security"
	// 		}
	// 	}
	// }

	Resources: ClusterSecretStore: doppler: {
		metadata: name: "doppler"
		spec: provider: doppler: {
			auth: secretRef: dopplerToken: {
				name:      "doppler-token-auth-api"
				key:       "dopplerToken"
				namespace: "security"
			}
		}
	}
}
