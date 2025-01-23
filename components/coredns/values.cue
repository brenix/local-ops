package holos

#Values: {
	replicaCount: 2
	resources: limits: cpu: null
	service: {
		clusterIP: "10.96.0.10"
	}
	serviceAccount: {
		create: true
	}
	priorityClassName: "system-cluster-critical"

	prometheus: service: enabled: true
	prometheus: monitor: enabled: true

	servers: [{
		zones: [{zone: "."}]
		port: 53
		plugins: [{
			name: "errors"
		}, {
			// Serves a /health endpoint on :8080, required for livenessProbe
			name:        "health"
			configBlock: "lameduck 5s"
		}, {

			// Serves a /ready endpoint on :8181, required for readinessProbe
			name: "ready"
		}, {
			// Required to query kubernetes API for data
			name:       "kubernetes"
			parameters: "cluster.local in-addr.arpa ip6.arpa"
			configBlock: """
				pods insecure
				fallthrough in-addr.arpa ip6.arpa
				ttl 30
				"""
		}, {
			name:       "template"
			parameters: "IN AAAA"
			configBlock: """
				rcode NOERROR
				"""
		}, {

			// Serves a /metrics endpoint on :9153, required for serviceMonitor
			name:       "prometheus"
			parameters: "0.0.0.0:9153"
		}, {
			name:       "forward"
			parameters: ". /etc/resolv.conf"
		}, {
			name:       "cache"
			parameters: 300
			configBlock: """
				success 10000 300 300
				denial 10000 5 5
				prefetch 30%
				"""
		}, {
			name: "loop"
		}, {
			name: "reload"
		}, {
			name: "loadbalance"
		}]
	}]
}
