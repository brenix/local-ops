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
		"cert-manager": {
			datasource: "Prometheus"
			gnetId:     20842
			revision:   3
		}
		"coredns": {
			datasource: "Prometheus"
			gnetId:     15762
			revision:   19
		}
		"nginx": {
			datasource: "Prometheus"
			gnetId:     14314
			revision:   2
		}
		"unifi-client-dpi": {
			datasource: "Prometheus"
			gnetId:     11310
			revision:   5
		}
		"unifi-clients": {
			datasource: "Prometheus"
			gnetId:     11315
			revision:   9
		}
		"unifi-sites": {
			datasource: "Prometheus"
			gnetId:     11311
			revision:   5
		}
		"unifi-uap": {
			datasource: "Prometheus"
			gnetId:     11314
			revision:   10
		}
		"unifi-usw": {
			datasource: "Prometheus"
			gnetId:     11312
			revision:   9
		}
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
