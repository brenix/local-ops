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

			    custom_formats:
			      - trash_ids:
			          - 834e534f103938853ffced4203b53e72 # 2.0 Stereo
			        assign_scores_to:
			          - name: WEB-1080p
			            score: 100

			      - trash_ids:
			          - 47435ece6b99a0b477caf360e79ba0bb # x265 (HD)
			          - 1bef6c151fa35093015b0bfef18279e5 # 2160p
			        assign_scores_to:
			          - name: WEB-1080p
			            score: -100

			      - trash_ids:
			          - 32b367365729d530ca1c124a0b180c64 # Bad Dual Groups
			          - 82d40da2bc6923f41e14394075dd4b03 # No-RlsGroup
			          - e1a997ddb54e3ecbfe06341ad323c458 # Obfuscated
			          - 06d66ab109d4d2eddb2794d21526d140 # Retags
			        assign_scores_to:
			          - name: WEB-1080p

			      
			radarr:
			  radarr:
			    base_url: http://radarr.default.svc.cluster.local:7878
			    api_key: !env_var RADARR_API_KEY

			    delete_old_custom_formats: true
			    replace_existing_custom_formats: true

			    include:
			      - template: radarr-quality-definition-sqp-streaming
			      - template: radarr-quality-profile-sqp-1-1080p
			      - template: radarr-custom-formats-sqp-1-1080p

			    quality_definition:
			      type: movie
			      preferred_ratio: 0

			    quality_profiles:
			      - name: SQP-1 (1080p)

			    custom_formats:
			      - trash_ids:
			          - 2899d84dc9372de3408e6d8cc18e9666 # x264
			        assign_scores_to:
			          - name: SQP-1 (1080p)
			            score: 1000

			      - trash_ids:
			          - 89dac1be53d5268a7e10a19d3c896826 # 2.0 Stereo
			        assign_scores_to:
			          - name: SQP-1 (1080p)
			            score: 100

			      - trash_ids:
			          - 839bea857ed2c0a8e084f3cbdbd65ecb # x265 (no HDR/DV)
			          - fb392fb0d61a010ae38e49ceaa24a1ef # 2160p
			        assign_scores_to:
			          - name: SQP-1 (1080p)
			            score: -100

			      - trash_ids:
			          - b6832f586342ef70d9c128d40c07b872 # Bad Dual Groups
			          - cc444569854e9de0b084ab2b8b1532b2 # Black and White Editions
			          - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5 # No-RlsGroup
			          - 7357cf5161efbf8c4d5d0c30b4815ee2 # Obfuscated
			          - 5c44f52a8714fdd79bb4d98e2673be1f # Retags
			        assign_scores_to:
			          - name: SQP-1 (1080p)

			"""
	}
}
