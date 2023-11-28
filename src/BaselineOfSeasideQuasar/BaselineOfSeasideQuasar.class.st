Class {
	#name : #BaselineOfSeasideQuasar,
	#superclass : #BaselineOf,
	#category : #BaselineOfSeasideQuasar
}

{ #category : #baselines }
BaselineOfSeasideQuasar >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			self neoJSON: spec.
			self seaside: spec.
			self magritte: spec.
			self soil: spec.

			spec
				package: 'Quasar-Components' with: [ spec requires: #('Seaside3' 'NeoJSON') ];
				package: 'Quasar-Demo' with: [ spec requires: #('Quasar-Components' 'Soil') ];
				package: 'Quasar-Magritte' with: [ spec requires: #('Quasar-Components' 'Magritte') ];
				package: 'DockerUtility' with: [ spec requires: #('Seaside3') ];
				package: 'Stripe' with: [ spec requires: #('Quasar-Components') ];
				package: 'Quasar-Material' with: [ spec requires: #('Quasar-Magritte' 'DockerUtility' 'Stripe') ].

			spec
				group: 'default' with: #('Quasar-Demo');
				group: 'quasar' with: #('Quasar-Components');
				group: 'material' with: #('Quasar-Material');
				group: 'all' with: #('Quasar-Demo' 'Quasar-Material') ]
]

{ #category : #dependencies }
BaselineOfSeasideQuasar >> magritte: spec [

	spec
		baseline: 'Magritte'
		with: [ spec repository: 'github://yannij/magritte:master/source';
			loads: #( 'Magritte-Seaside') ]
]

{ #category : #dependencies }
BaselineOfSeasideQuasar >> neoJSON: spec [

	spec
		baseline: 'NeoJSON'
		with: [ spec repository: 'github://svenvc/NeoJSON:v17/repository' ]
]

{ #category : #dependencies }
BaselineOfSeasideQuasar >> seaside: spec [

	spec
		baseline: 'Seaside3'
		with: [ spec repository: 'github://SeasideSt/Seaside:v3.4.7/repository';
			loads: #('Core' 'JSON' 'Email' 'Javascript' 'Zinc') ]
]

{ #category : #dependencies }
BaselineOfSeasideQuasar >> soil: spec [

	spec
		baseline: 'Soil'
		with: [ spec repository: 'github://yannij/Soil:main/src' ]
]
