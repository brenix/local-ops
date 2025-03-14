package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ConfigMap: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		metadata: annotations: "kustomize.toolkit.fluxcd.io/substitute": "disabled"
		data: "recyclarr.yml": """
			sonarr:
			  sonarr:
			    base_url: http://sonarr.default.svc.cluster.local:8989
			    api_key: !env_var SONARR_API_KEY

			    delete_old_custom_formats: true
			    replace_existing_custom_formats: true

			    include:
			      - template: sonarr-quality-definition-series
			      - template: sonarr-v4-quality-profile-web-1080p
			      - template: sonarr-v4-custom-formats-web-1080p

			    quality_definition:
			      type: series
			      preferred_ratio: 0

			    quality_profiles:
			      - name: WEB-1080p
			      - name: Any
			        reset_unmatched_scores:
			          enabled: true
			        upgrade:
			          allowed: false
			          until_quality: WEB 1080p
			          until_score: 3000
			        quality_sort: top
			        qualities:
			          - name: WEB 1080p
			            qualities: ["WEBDL-1080p", "WEBRip-1080p"]
			          - name: HDTV-1080p
			          - name: WEB 720p
			            qualities: ["WEBDL-720p", "WEBRip-720p"]
			          - name: HDTV-720p
			          - name: WEB 480p
			            qualities: ["WEBDL-480p", "WEBRip-480p"]
			          - name: DVD
			          - name: SDTV

			    custom_formats:
			      - trash_ids:
			          - c9eafd50846d299b862ca9bb6ea91950 # x265
			        assign_scores_to:
			          - name: WEB-1080p
			            score: 3000
			          - name: Any
			            score: 3000
			      - trash_ids:
			          - cddfb4e32db826151d97352b8e37c648 # x264
			        assign_scores_to:
			          - name: WEB-1080p
			            score: 2000
			          - name: Any
			            score: 2000
			      - trash_ids:
			          - 32b367365729d530ca1c124a0b180c64 # Bad Dual Groups
			          - 82d40da2bc6923f41e14394075dd4b03 # No-RlsGroup
			          - e1a997ddb54e3ecbfe06341ad323c458 # Obfuscated
			          - 06d66ab109d4d2eddb2794d21526d140 # Retags
			          - 1b3994c551cbb92a2c781af061f4ab44 # Scene
			        assign_scores_to:
			          - name: WEB-1080p
			          - name: Any
			      - trash_ids:
			          - 1bef6c151fa35093015b0bfef18279e5 # 2160p
			        assign_scores_to:
			          - name: WEB-1080p
			            score: -100
			          - name: Any
			            score: -100
			      
			radarr:
			  radarr:
			    base_url: http://radarr.default.svc.cluster.local:7878
			    api_key: !env_var RADARR_API_KEY

			    delete_old_custom_formats: true
			    replace_existing_custom_formats: true

			    quality_definition:
			      type: movie
			      preferred_ratio: 0

			    quality_profiles:
			      - name: SQP-1 (1080p)

			    include:
			      - template: radarr-quality-definition-sqp-streaming
			      - template: radarr-quality-profile-sqp-1-1080p
			      - template: radarr-custom-formats-sqp-1-1080p

			    custom_formats:
			      - trash_ids:
			          - 7a0d1ad358fee9f5b074af3ef3f9d9ef # hallowed
			          - b6832f586342ef70d9c128d40c07b872 # Bad Dual Groups
			          - 90cedc1fea7ea5d11298bebd3d1d3223 # EVO (no WEBDL)
			          - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5 # No-RlsGroup
			          - 7357cf5161efbf8c4d5d0c30b4815ee2 # Obfuscated
			          - 5c44f52a8714fdd79bb4d98e2673be1f # Retags
			          - f537cf427b64c38c8e36298f657e4828 # Scene
			        assign_scores_to:
			          - name: SQP-1 (1080p)
			      - trash_ids:
			          - 9170d55c319f4fe40da8711ba9d8050d # x265
			        assign_scores_to:
			          - name: SQP-1 (1080p)
			            score: 3000
			      - trash_ids:
			          - 2899d84dc9372de3408e6d8cc18e9666 # x264
			        assign_scores_to:
			          - name: SQP-1 (1080p)
			            score: 2000
			      - trash_ids:
			          - fb392fb0d61a010ae38e49ceaa24a1ef # 2160p
			        assign_scores_to:
			          - name: SQP-1 (1080p)
			            score: -100

			"""
	}
}
