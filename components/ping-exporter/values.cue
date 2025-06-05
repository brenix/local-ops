package holos

#Values: {
	config: {
		targets: [
			// "8.8.8.8",
			"google.com",
			"192.168.1.1",
			"204.154.217.202",
		]

		dns: nameserver: "192.168.1.1"

		ping: {
			interval: "5s"
			timeout:  "3s"
		}
	}

	serviceMonitor: enabled: true
	testConnection: enabled: false
}
