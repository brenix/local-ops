package holos

#Values: {
	controllers: main: {
		annotations: "reloader.stakater.com/auto": "true"
		containers: main: {
			env: TZ: "America/Los_Angeles"
			envFrom: [{
				secretRef: name: "recyclarr"
			}]
			image: {
				repository: "ghcr.io/recyclarr/recyclarr"
				tag:        "7.4.0"
			}
			resources: {
				limits: memory: "200Mi"
				requests: {
					cpu:    "10m"
					memory: "50Mi"
				}
			}
		}
		statefulset: volumeClaimTemplates: [{
			accessMode: "ReadWriteOnce"
			name:       "config"
			size:       "1Gi"
		}]
		type: "statefulset"
	}
	persistence: "config-file": {
		globalMounts: [{
			path:     "/config/recyclarr.yml"
			readOnly: true
			subPath:  "recyclarr.yml"
		}]
		name: "recyclarr"
		type: "configMap"
	}
	service: main: {
		controller: "main"
		enabled:    false
	}
}
