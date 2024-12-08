package holos

#Values: {
	certController: serviceMonitor: {
		enabled:  true
		interval: "1m"
	}
	installCRDs: true
	serviceMonitor: {
		enabled:  true
		interval: "1m"
	}
	webhook: serviceMonitor: {
		enabled:  true
		interval: "1m"
	}
}
