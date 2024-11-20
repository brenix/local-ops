package holos

#Values: {
	global: leaderElection: namespace: "cert-manager"

	crds: enabled: true

	dns01RecursiveNameservers: "1.1.1.1:53,9.9.9.9:53"

	dns01RecursiveNameserversOnly: true

	podDnsConfig: nameservers: ["1.1.1.1", "9.9.9.9"]

	prometheus: {
		enabled: true
		servicemonitor: enabled: true
	}

	startupapicheck: enabled: false
}
