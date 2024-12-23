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
		"node-exporter-full": {
			datasource: "Prometheus"
			gnetId:     1860
			revision:   33
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
	"grafana.ini": analytics: check_for_updates: false
	ingress: {
		enabled: true
		hosts: ["grafana.brenix.com"]
		ingressClassName: "internal"
		tls: [{
			hosts: ["grafana.brenix.com"]
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
	testFramework: enabled: false
}
