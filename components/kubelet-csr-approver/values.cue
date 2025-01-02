package holos

#Values: {
	replicas:            1
	providerRegex:       #"^k\d+$"#
	bypassDnsResolution: true
	metrics: {
		enable: true
		servicemonitor: enabled: true
	}
	resources: limits: cpu: null
}
