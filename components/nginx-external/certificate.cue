package holos

Component: {
	Name:      string
	Namespace: string

	Resources: Certificate: (Name): {
		metadata: name:      "brenix.com"
		metadata: namespace: Namespace
		spec: {
			secretName: "brenix.com-tls"
			issuerRef: {
				name: "letsencrypt-production"
				kind: "ClusterIssuer"
			}
			commonName: "brenix.com"
			dnsNames: [
				"brenix.com",
				"*.brenix.com",
			]
		}
	}
}
