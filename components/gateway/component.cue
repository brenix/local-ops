package holos

holos: Component.BuildPlan

Component: #Kubernetes & {
	Name:      "gateway"
	Namespace: "kube-system"

	Resources: {
		Certificate: (Name): {
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
		PushSecret: (Name): {
			metadata: name:      "brenix.com-tls"
			metadata: namespace: Namespace
			spec: {
				secretStoreRefs: [{
					name: "doppler"
					kind: "ClusterSecretStore"
				}]
				selector: secret: name: "brenix.com-tls"
				template: {
					engineVersion: "v2"
					data: {
						"tls.crt": "{{ index . \"tls.crt\" | b64enc }}"
						"tls.key": "{{ index . \"tls.key\" | b64enc }}"
					}
				}
				data: [{
					match: {
						secretKey: "tls.crt"
						remoteRef: {
							remoteKey: "BRENIX_COM_CRT"
							property:  "tls.crt"
						}
					}
				}, {
					match: {
						secretKey: "tls.key"
						remoteRef: {
							remoteKey: "BRENIX_COM_KEY"
							property:  "tls.key"
						}
					}
				}]
			}

		}
		HTTPRoute: Redirect: {
			metadata: name:      "httpsredirect"
			metadata: namespace: Namespace
			spec: {
				parentRefs: [
					{
						name:        "internal"
						namespace:   "kube-system"
						sectionName: "http"
					},
					{
						name:        "external"
						namespace:   "kube-system"
						sectionName: "http"
					},
				]
				rules: [{
					filters: [{
						requestRedirect: {
							scheme:     "https"
							statusCode: 301
						}
						type: "RequestRedirect"
					}]
				}]
			}
		}
		Gateway: {
			External: {
				metadata: name:      "external"
				metadata: namespace: Namespace
				metadata: annotations: "external-dns.alpha.kubernetes.io/target": "external.brenix.com"
				spec: {
					gatewayClassName: "envoy"
					infrastructure: annotations: {
						"external-dns.alpha.kubernetes.io/hostname": "external.brenix.com"
						"lbipam.cilium.io/ips":                      "192.168.2.20"
					}
					listeners: [{
						name:     "http"
						protocol: "HTTP"
						port:     80
						hostname: "*.brenix.com"
						allowedRoutes: namespaces: from: "Same"
					}, {
						name:     "https"
						protocol: "HTTPS"
						port:     443
						hostname: "*.brenix.com"
						allowedRoutes: namespaces: from: "All"
						tls: certificateRefs: [{
							kind: "Secret"
							name: "brenix.com-tls"
						}]
					}]
				}
			}
			Internal: {
				metadata: name:      "internal"
				metadata: namespace: Namespace
				metadata: annotations: "external-dns.alpha.kubernetes.io/target": "internal.brenix.com"
				spec: {
					gatewayClassName: "envoy"
					infrastructure: annotations: {
						"external-dns.alpha.kubernetes.io/hostname": "internal.brenix.com"
						"lbipam.cilium.io/ips":                      "192.168.2.21"
					}
					listeners: [{
						name:     "http"
						protocol: "HTTP"
						port:     80
						hostname: "*.brenix.com"
						allowedRoutes: namespaces: from: "Same"
					}, {
						name:     "https"
						protocol: "HTTPS"
						port:     443
						hostname: "*.brenix.com"
						allowedRoutes: namespaces: from: "All"
						tls: certificateRefs: [{
							kind: "Secret"
							name: "brenix.com-tls"
						}]
					}]
				}
			}
		}
	}
}
