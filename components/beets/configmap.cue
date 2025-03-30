package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ConfigMap: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		data: {
			"config.yaml": """
				directory: /music
				library: /config/beets.db
				paths:
				  default: $albumartist/$year - $album%aunique{}/$track-$title
				  singleton: Non-Album/$artist - $title
				  comp: Compilations/$album%aunique{}/$track $title
				plugins: fetchart embedart permissions
				import:
				  move: true
				fetchart:
				  auto: yes
				embedart:
				  auto: yes
				  ifempty: yes
				permissions:
				  file: 644
				  dir: 755

				"""
		}
	}
}
