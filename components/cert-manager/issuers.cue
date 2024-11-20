package holos

Component: Resources: ClusterIssuer: {
	_common: {
		privateKeySecretRef: name: string
		solvers: [{
			dns01: cloudflare: {
				email: "brenix@gmail.com"
				apiKeySecretRef: {
					name: "cloudflare"
					key:  "CLOUDFLARE_API_KEY"
				}
			}
			selector: dnsZones: ["brenix.com"]
		}]
	}

	letsencrypt_staging: {
		metadata: name: "letsencrypt-staging"
		spec: acme: {
			server: "https://acme-staging-v02.api.letsencrypt.org/directory"
			privateKeySecretRef: _common.privateKeySecretRef & {name: metadata.name}
			solvers: _common.solvers
		}
	}

	letsencrypt_prod: {
		metadata: name: "letsencrypt-production"
		spec: acme: {
			server: "https://acme-v02.api.letsencrypt.org/directory"
			privateKeySecretRef: _common.privateKeySecretRef & {name: metadata.name}
			solvers: _common.solvers
		}
	}
}
