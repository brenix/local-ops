package holos

#Values: {
	global: leaderElection: namespace: "cert-manager"

	crds: enabled: true

	dns01RecursiveNameservers: "https://1.1.1.1:443/dns-query,https://1.0.0.1:443/dns-query"

	dns01RecursiveNameserversOnly: true

	prometheus: {
		enabled: true
		servicemonitor: enabled: true
	}

	startupapicheck: enabled: false
}
