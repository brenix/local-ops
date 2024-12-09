package holos

#Values: {
	controllers: cloudflared: {
		annotations: "reloader.stakater.com/auto": "true"
		containers: main: {
			args: [
				"tunnel",
				"--config",
				"/etc/cloudflared/config/config.yaml",
				"run",
				"7f90e49b-765b-4de7-854a-70e3d3d1e5eb",
			]
			env: {
				NO_AUTOUPDATE:              true
				TUNNEL_CRED_FILE:           "/etc/cloudflared/creds/credentials.json"
				TUNNEL_METRICS:             "0.0.0.0:8080"
				TUNNEL_ORIGIN_ENABLE_HTTP2: true
				TUNNEL_POST_QUANTUM:        true
				TUNNEL_TRANSPORT_PROTOCOL:  "quic"
			}
			image: {
				repository: "docker.io/cloudflare/cloudflared"
				tag:        "2024.11.1"
			}
			probes: {
				liveness: {
					custom:  true
					enabled: true
					spec: {
						failureThreshold: 3
						httpGet: {
							path: "/ready"
							port: 8080
						}
						initialDelaySeconds: 0
						periodSeconds:       10
						timeoutSeconds:      1
					}
				}
				readiness: {
					custom:  true
					enabled: true
					spec: {
						failureThreshold: 3
						httpGet: {
							path: "/ready"
							port: 8080
						}
						initialDelaySeconds: 0
						periodSeconds:       10
						timeoutSeconds:      1
					}
				}
			}
			resources: {
				limits: memory: "256Mi"
				requests: cpu:  "10m"
			}
			securityContext: {
				allowPrivilegeEscalation: false
				capabilities: drop: ["ALL"]
				readOnlyRootFilesystem: true
			}
		}
		pod: {
			securityContext: {
				runAsGroup:   568
				runAsNonRoot: true
				runAsUser:    568
			}
			topologySpreadConstraints: [{
				labelSelector: matchLabels: "app.kubernetes.io/name": "cloudflared"
				maxSkew:           1
				topologyKey:       "kubernetes.io/hostname"
				whenUnsatisfiable: "DoNotSchedule"
			}]
		}
		replicas: 1
		strategy: "RollingUpdate"
	}
	persistence: {
		config: {
			globalMounts: [{
				path:     "/etc/cloudflared/config/config.yaml"
				readOnly: true
				subPath:  "config.yaml"
			}]
			name: "cloudflared"
			type: "configMap"
		}
		creds: {
			globalMounts: [{
				path:     "/etc/cloudflared/creds/credentials.json"
				readOnly: true
				subPath:  "credentials.json"
			}]
			name: "cloudflared-tunnel"
			type: "secret"
		}
	}
	service: main: {
		controller: "cloudflared"
		ports: http: port: 8080
	}
	serviceMonitor: main: {
		endpoints: [{
			interval:      "1m"
			path:          "/metrics"
			port:          "http"
			scheme:        "http"
			scrapeTimeout: "10s"
		}]
		serviceName: "cloudflared"
	}
}
