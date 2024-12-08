package holos

Component: {
	Name:      string
	Namespace: string

	Resources: DNSEndpoint: (Name): {
		metadata: name:      "cloudflared"
		metadata: namespace: Namespace
		spec: endpoints: [{
			dnsName:    "external.brenix.com"
			recordType: "CNAME"
			targets: ["7f90e49b-765b-4de7-854a-70e3d3d1e5eb.cfargotunnel.com"]
		}]
	}
}
