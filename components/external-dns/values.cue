package holos

#Values: {
	domainFilters: ["brenix.com"]
	env: [{
		name: "CF_API_EMAIL"
		valueFrom: secretKeyRef: {
			key:  "CF_API_EMAIL"
			name: "external-dns-cloudflare"
		}
	}, {
		name: "CF_API_KEY"
		valueFrom: secretKeyRef: {
			key:  "CF_API_KEY"
			name: "external-dns-cloudflare"
		}
	}]
	extraArgs: [
		"--cloudflare-dns-records-per-page=1000",
		"--cloudflare-proxied",
		"--crd-source-apiversion=externaldns.k8s.io/v1alpha1",
		"--crd-source-kind=DNSEndpoint",
		"--gateway-name=external",
	]
	fullnameOverride: "external-dns-cloudflare"
	podAnnotations: "secret.reloader.stakater.com/reload": "external-dns-cloudflare-secret"
	policy:   "sync"
	provider: "cloudflare"
	serviceMonitor: enabled: true
	sources: [
		"crd",
		"gateway-httproute",
		"gateway-grpcroute",
		"gateway-tlsroute",
		"gateway-tcproute",
		"gateway-udproute",
	]
	triggerLoopOnEvent: true
	txtOwnerId:         "default"
	txtPrefix:          "k8s."
}
