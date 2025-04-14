package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			BEETS_HOST:                     "beets.default.svc.cluster.local"
			DOTNET_BUNDLE_EXTRACT_BASE_DIR: "/tmp/.net"
			TZ:                             "America/Los_Angeles"
			SLSKD_APP_DIR:                  "/config"
			SLSKD_HTTP_PORT:                80
			SLSKD_NO_AUTH:                  true
			SLSKD_NO_HTTPS:                 true
			SLSKD_SLSK_LISTEN_PORT:         50300
		}
		envFrom: [{
			secretRef: name: "slskd"
		}]
		image: {
			repository: "ghcr.io/slskd/slskd"
			tag:        "0.22.4"
		}
		probes: {
			liveness: {
				enabled: true
				custom:  true
				spec: {
					httpGet: {
						path: "/health"
						port: 80
					}
					initialDelaySeconds: 0
					periodSeconds:       10
					timeoutSeconds:      1
					failureThreshold:    3
				}
			}
			readiness: {
				enabled: true
				custom:  true
				spec: {
					httpGet: {
						path: "/health"
						port: 80
					}
					initialDelaySeconds: 0
					periodSeconds:       10
					timeoutSeconds:      1
					failureThreshold:    3
				}
			}
		}
		securityContext: {
			allowPrivilegeEscalation: false
			readOnlyRootFilesystem:   true
			capabilities: drop: ["ALL"]
		}
		resources: {
			requests: {
				cpu:    "10m"
				memory: "128Mi"
			}
			limits: memory: "1Gi"
		}
	}
	defaultPodOptions: securityContext: {
		runAsNonRoot:        true
		runAsUser:           1000
		runAsGroup:          1000
		fsGroup:             1000
		fsGroupChangePolicy: "OnRootMismatch"
	}
	ingress: main: {
		className: "internal"
		hosts: [{
			host: "{{.Release.Name }}.brenix.com"
			paths: [{
				path: "/"
				service: {
					identifier: "main"
					port:       "http"
				}
			}]
		}]
		tls: [{
			hosts: ["{{.Release.Name }}.brenix.com"]
		}]
	}
	persistence: {
		config: {
			existingClaim: "slskd-data"
		}
		"config-file": {
			type:        "configMap"
			name:        "slskd"
			defaultMode: 0o775
			globalMounts: [{
				path:     "/config/slskd.yml"
				subPath:  "slskd.yml"
				readOnly: true
			}, {
				path:     "/scripts/beets.sh"
				subPath:  "beets.sh"
				readOnly: true
			}]
		}
		media: {
			enabled: true
			type:    "nfs"
			server:  "truenas.home.arpa"
			path:    "/mnt/main/media"
			globalMounts: [{path: "/music", subPath: "music"}, {path: "/media/downloads/soulseek", subPath: "downloads/soulseek"}]
		}
		tmp: type: "emptyDir"
	}
	service: main: {
		annotations: "lbipam.cilium.io/ips": "192.168.2.6"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: {
			http: {
				primary: true
				port:    80
			}
			soulseek: {
				enabled:  true
				port:     50300
				protocol: "TCP"
			}
		}
		type: "LoadBalancer"
	}
}
