package holos

#Values: {
	admin: existingSecret: "grafana-admin"
	dashboardProviders: "dashboardproviders.yaml": {
		apiVersion: 1
		providers: [{
			disableDeletion: false
			editable:        true
			folder:          ""
			name:            "default"
			options: path: "/var/lib/grafana/dashboards/default"
			orgId: 1
			type:  "file"
		}]
	}
	dashboards: default: {
		"ceph-cluster": {
			gnetId:     2842
			revision:   18
			datasource: "Prometheus"
		}
		"ceph-osd": {
			gnetId:     5336
			revision:   9
			datasource: "Prometheus"
		}
		"ceph-pools": {
			gnetId:     5342
			revision:   9
			datasource: "Prometheus"
		}
		"cert-manager": {
			datasource: "Prometheus"
			gnetId:     20842
			revision:   3
		}
		"coredns": {
			datasource: "Prometheus"
			gnetId:     15762
			revision:   21
		}
		"envoy-gateway": {
			url:        "https://raw.githubusercontent.com/envoyproxy/gateway/refs/heads/main/charts/gateway-addons-helm/dashboards/envoy-gateway-global.json"
			datasource: "Prometheus"
		}
		"envoy-proxy": {
			url:        "https://raw.githubusercontent.com/envoyproxy/gateway/refs/heads/main/charts/gateway-addons-helm/dashboards/envoy-proxy-global.json"
			datasource: "Prometheus"
		}
		"external-dns": {
			gnetId:     15038
			revision:   3
			datasource: "Prometheus"
		}
		"kubernetes-api-server": {
			gnetId:     15761
			revision:   19
			datasource: "Prometheus"
		}
		"kubernetes-global": {
			gnetId:     15757
			revision:   43
			datasource: "Prometheus"
		}
		"kubernetes-namespaces": {
			gnetId:     15758
			revision:   42
			datasource: "Prometheus"
		}
		"kubernetes-nodes": {
			gnetId:     15759
			revision:   37
			datasource: "Prometheus"
		}
		"kubernetes-pods": {
			gnetId:     15760
			revision:   36
			datasource: "Prometheus"
		}
		"kubernetes-volumes": {
			gnetId:     11454
			revision:   14
			datasource: "Prometheus"
		}
		"node-exporter-full": {
			gnetId:   1860
			revision: 42
			datasource: [{name: "DS_PROMETHEUS", value: "Prometheus"}]
		}
		// "unifi-client-dpi": {
		// 	datasource: "Prometheus"
		// 	gnetId:     11310
		// 	revision:   5
		// }
		// "unifi-clients": {
		// 	datasource: "Prometheus"
		// 	gnetId:     11315
		// 	revision:   9
		// }
		// "unifi-sites": {
		// 	datasource: "Prometheus"
		// 	gnetId:     11311
		// 	revision:   5
		// }
		// "unifi-uap": {
		// 	datasource: "Prometheus"
		// 	gnetId:     11314
		// 	revision:   10
		// }
		// "unifi-usw": {
		// 	datasource: "Prometheus"
		// 	gnetId:     11312
		// 	revision:   9
		// }
	}
	datasources: "datasources.yaml": {
		apiVersion: 1
		datasources: [{
			access:    "proxy"
			isDefault: true
			jsonData: timeInterval: "1m"
			name: "Prometheus"
			type: "prometheus"
			url:  "http://prometheus-operated:9090/"
		}]
	}
	"grafana.ini": {
		analytics: check_for_updates: false
		date_formats: {
			full_date:       "MMM Do, YYYY @ hh:mm:ss a"
			interval_second: "hh:mm:ss A"
			interval_minute: "hh:mm A"
			interval_hour:   "MMM DD hh:mm A"
			interval_day:    "MMM DD"
			interval_month:  "YYYY-MM"
			interval_year:   "YYYY"
		}
	}
	route: main: {
		enabled: true
		hostnames: ["grafana.brenix.com"]
		parentRefs: [{
			name:        "internal"
			namespace:   "kube-system"
			sectionName: "https"
		}]
	}
	persistence: {
		enabled: true
		size:    "1Gi"
	}
	plugins: [
		"grafana-piechart-panel",
		"grafana-worldmap-panel",
		"grafana-clock-panel",
	]
	serviceAccount: autoMount: true
	serviceMonitor: enabled:   true
	sidecar: {
		dashboards: {
			enabled:         true
			searchNamespace: "ALL"
		}
		datasources: {
			enabled:         true
			searchNamespace: "ALL"
		}
	}
	testFramework: enabled:   false
	deploymentStrategy: type: "Recreate"
}
