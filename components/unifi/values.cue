package holos

#Values: {
	controllers: main: containers: main: {
		env: {
			MONGO_DBNAME: "unifi"
			MONGO_HOST:   "mongodb.default.svc.cluster.local"
			MONGO_PORT:   27017
			PGID:         1000
			PUID:         1000
			TZ:           "America/Los_Angeles"
		}
		envFrom: [{
			secretRef: name: "unifi"
		}]
		image: {
			pullPolicy: "Always"
			repository: "lscr.io/linuxserver/unifi-network-application"
			tag:        "8.6.9"
		}
	}
	ingress: main: {
		annotations: "nginx.ingress.kubernetes.io/backend-protocol": "HTTPS"
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
	persistence: data: {
		accessMode: "ReadWriteOnce"
		enabled:    true
		globalMounts: [{path: "/config"}]
		size: "1Gi"
		type: "persistentVolumeClaim"
	}
	service: main: {
		annotations: "metallb.universe.tf/loadBalancerIPs": "192.168.2.2"
		controller:            "main"
		externalTrafficPolicy: "Local"
		ports: {
			controller: {
				enabled:  true
				port:     8080
				protocol: "TCP"
			}
			discovery: {
				enabled:  true
				port:     10001
				protocol: "UDP"
			}
			http: {
				port:     8443
				protocol: "HTTPS"
			}
			"portal-http": {
				enabled:  false
				port:     8880
				protocol: "HTTP"
			}
			"portal-https": {
				enabled:  false
				port:     8843
				protocol: "HTTPS"
			}
			speedtest: {
				enabled:  true
				port:     6789
				protocol: "TCP"
			}
			stun: {
				enabled:  true
				port:     3478
				protocol: "UDP"
			}
			syslog: {
				enabled:  true
				port:     5514
				protocol: "UDP"
			}
		}
		type: "LoadBalancer"
	}
}
