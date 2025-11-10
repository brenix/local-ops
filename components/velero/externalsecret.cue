package holos

Component: {
	Namespace: string

	Resources: ExternalSecret: "minio-creds": {
		metadata: name:      "minio-creds"
		metadata: namespace: Namespace
		spec: {
			target: name: "minio-creds"
			target: template: {
				engineVersion: "v2"
				data: {
					"aws": """
						[default]
						aws_access_key_id = "{{ .MINIO_USER }}"
						aws_secret_access_key = "{{ .MINIO_PASSWORD }}"
						"""
				}
			}
			data: [
				{secretKey: "MINIO_USER", remoteRef: {key: "MINIO_USER"}},
				{secretKey: "MINIO_PASSWORD", remoteRef: {key: "MINIO_PASSWORD"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
