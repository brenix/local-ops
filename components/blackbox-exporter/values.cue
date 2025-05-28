package holos

#Values: {
	config: {
		modules: {
			http_2xx: null
			icmp_v4: {
				prober:  "icmp"
				timeout: "5s"
				icmp: {
					preferred_ip_protocol: "ip4"
				}
			}
		}
	}
	serviceMonitor: {
		enabled: true
		defaults: {
			interval:      "10s"
			scrapeTimeout: "10s"
		}
		targets: [
			{
				name:   "google-ping"
				url:    "google.com"
				module: "icmp_v4"
			},
		]
	}
	configReloader: enabled: true
}
