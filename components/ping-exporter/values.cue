package holos

#Values: {
	config: {
		targets: [
			"8.8.8.8",
		]

		dns: nameserver: "192.168.1.1"

		ping: {
			interval: "30s"
			timeout:  "3s"
		}
	}

	serviceMonitor: enabled: true
	testConnection: enabled: false
}
