package holos

#Values: {
	controllers: main: {
		annotations: "reloader.stakater.com/auto": "true"
		containers: main: {
			image: {
				repository: "ghcr.io/home-operations/beets"
				tag:        "2.3.1"
			}
			env: {
				BEETS_CONFIG_PATH: "/config/.config/beets/config.yaml"
				BETANIN_HOST:      "0.0.0.0"
				BETANIN_PORT:      80
				TZ:                "America/Los_Angeles"
			}
			probes: {
				liveness: enabled:  true
				readiness: enabled: true
				startup: {
					enabled: true
					spec: {
						failureThreshold: 30
						periodSeconds:    10
					}
				}
			}
			securityContext: {
				allowPrivilegeEscalation: false
				readOnlyRootFilesystem:   true
				capabilities: drop: ["ALL"]
			}
			resources: {
				requests: cpu:  "10m"
				limits: memory: "1Gi"
			}
		}
	}
	defaultPodOptions: securityContext: {
		runAsNonRoot:        true
		runAsUser:           1000
		runAsGroup:          1000
		fsGroup:             1000
		fsGroupChangePolicy: "OnRootMismatch"
	}
	service: main: {
		controller: "main"
		ports: http: port: 80
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
		config: type: "emptyDir"
		media: {
			type:   "nfs"
			server: "truenas.home.arpa"
			path:   "/mnt/main/media"
			advancedMounts: main: main: [{
				path:    "/media/downloads/soulseek/complete"
				subPath: "downloads/soulseek/complete"
			}, {
				path:    "/music"
				subPath: "music"
			}]
		}
		"config-file": {
			type: "configMap"
			name: "beets"
			globalMounts: [{
				path:     "/config/.config/beets/config.yaml"
				subPath:  "config.yaml"
				readOnly: true
			}]
		}
		"secret-file": {
			type: "secret"
			name: "beets"
			globalMounts: [{
				path:     "/config/.config/betanin/config.toml"
				subPath:  "config.toml"
				readOnly: true
			}]
		}
		tmp: type: "emptyDir"
	}
}
