package holos

#Values: {
	controller: {
		admissionWebhooks: objectSelector: matchExpressions: [{
			key:      "ingress-class"
			operator: "In"
			values: ["internal"]
		}]
		allowSnippetAnnotations: true
		config: {
			"block-user-agents":       "GPTBot,~*GPTBot*,ChatGPT-User,~*ChatGPT-User*,Google-Extended,~*Google-Extended*,CCBot,~*CCBot*,Omgilibot,~*Omgilibot*,FacebookBot,~*FacebookBot*" // taken from https://github.com/superseriousbusiness/gotosocial/blob/main/internal/web/robots.go
			"client-body-buffer-size": "100M"
			"client-body-timeout":     120
			"client-header-timeout":   120
			"disable-ipv6-dns":        true
			"enable-brotli":           "true"
			"enable-ocsp":             "true"
			"enable-real-ip":          "true"
			"hide-headers":            "Server,X-Powered-By"
			"hsts-max-age":            31449600
			"keep-alive":              120
			"keep-alive-requests":     10000
			"log-format-escape-json":  "true"
			"log-format-upstream": """
				{"time": "$time_iso8601", "remote_addr": "$proxy_protocol_addr", "x_forwarded_for": "$proxy_add_x_forwarded_for", "request_id": "$req_id", "remote_user": "$remote_user", "bytes_sent": $bytes_sent, "request_time": $request_time, "status": $status, "vhost": "$host", "request_proto": "$server_protocol", "path": "$uri", "request_query": "$args", "request_length": $request_length, "duration": $request_time, "method": "$request_method", "http_referrer": "$http_referer", "http_user_agent": "$http_user_agent"}

				"""
			"proxy-body-size":       0
			"proxy-buffer-size":     "16k"
			"ssl-buffer-size":       "2k"
			"ssl-protocols":         "TLSv1.3"
			"use-forwarded-headers": "true"
		}
		extraArgs: "default-ssl-certificate": "network/brenix.com-tls"
		ingressClassResource: {
			controllerValue: "k8s.io/internal"
			default:         true
			name:            "internal"
		}
		metrics: {
			enabled: false
			serviceMonitor: {
				enabled: false
				namespaceSelector: any: true
			}
		}
		replicaCount: 1
		resources: {
			limits: memory: "500Mi"
			requests: cpu:  "100m"
		}
		service: annotations: {
			"external-dns.alpha.kubernetes.io/hostname": "internal.brenix.com"
			"lbipam.cilium.io/ips":                      "192.168.2.21"
		}
		terminationGracePeriodSeconds: 120
		topologySpreadConstraints: [{
			labelSelector: matchLabels: {
				"app.kubernetes.io/component": "controller"
				"app.kubernetes.io/instance":  "nginx-internal"
				"app.kubernetes.io/name":      "ingress-nginx"
			}
			maxSkew:           1
			topologyKey:       "kubernetes.io/hostname"
			whenUnsatisfiable: "DoNotSchedule"
		}]
	}
	defaultBackend: enabled: false
	fullnameOverride: "nginx-internal"
}
