package holos

#Values: {
	controllers: main: {
		replicas: 1
		strategy: "Recreate"
		containers: main: {
			env: {
				MUMBLE_ACCEPT_UNKNOWN_SETTINGS: false
				MUMBLE_VERBOSE:                 false
				PUID:                           1000
				PGID:                           1000
				// MUMBLE_CHOWN_DATA:              false
			}
			envFrom: [{
				secretRef: name: "mumble"
			}]
			image: {
				repository: "ghcr.io/mumble-voip/mumble-server"
				tag:        "v1.5.735"
			}
			resources: {
				requests: {
					cpu:    "100m"
					memory: "64M"
				}
				limits: memory: "256M"
			}
		}
	}
	service: main: {
		controller: "main"
		type:       "LoadBalancer"
		annotations: "lbipam.cilium.io/ips": "192.168.2.17"
		externalTrafficPolicy: "Local"
		ports: {
			// http: {
			// 	enabled: false
			// }
			"mumble-tcp": {
				enabled:  true
				primary:  true
				port:     64738
				protocol: "TCP"
			}
			"mumble-udp": {
				enabled:  true
				port:     64738
				protocol: "UDP"
			}
		}
	}
	persistence: {
		data: {
			enabled:       true
			existingClaim: "mumble"
		}
	}
}
