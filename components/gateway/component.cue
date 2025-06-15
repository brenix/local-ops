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
					gatewayClassName: "cilium"
					addresses: [{
						type:  "IPAddress"
						value: "192.168.2.20"
					}]
					infrastructure: annotations: "external-dns.alpha.kubernetes.io/hostname": "external.brenix.com"
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
					gatewayClassName: "cilium"
					addresses: [{
						type:  "IPAddress"
						value: "192.168.2.21"
					}]
					infrastructure: annotations: "external-dns.alpha.kubernetes.io/hostname": "internal.brenix.com"
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
