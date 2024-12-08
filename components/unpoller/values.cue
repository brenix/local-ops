package holos

#Values: {
	controllers: main: {
		annotations: "reloader.stakater.com/auto": "true"
		containers: main: {
			env: {
				UP_INFLUXDB_DISABLE: true
				UP_UNIFI_DEFAULT_PASS: valueFrom: secretKeyRef: {
					key:  "unpoller_password"
					name: "unpoller"
				}
				UP_UNIFI_DEFAULT_ROLE:       "local-ops"
				UP_UNIFI_DEFAULT_URL:        "https://unifi.default:8443"
				UP_UNIFI_DEFAULT_USER:       "unpoller"
				UP_UNIFI_DEFAULT_VERIFY_SSL: false
			}
			image: {
				repository: "ghcr.io/unpoller/unpoller"
				tag:        "v2.11.2"
			}
			resources: {
				limits: memory: "500Mi"
				requests: {
					cpu:    "10m"
					memory: "100Mi"
				}
			}
		}
	}
	service: main: {
		controller: "main"
		ports: http: port: 9130
	}
	serviceMonitor: main: {
		enabled: true
		endpoints: [{
			interval:      "2m"
			path:          "/metrics"
			port:          "http"
			scheme:        "http"
			scrapeTimeout: "5s"
		}]
		serviceName: "unpoller"
	}
}
