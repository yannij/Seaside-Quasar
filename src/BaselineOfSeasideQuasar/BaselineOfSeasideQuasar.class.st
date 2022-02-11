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
			self voyage: spec.

			spec
				package: 'DockerUtility' with: [ spec requires: #('Seaside3') ];
				package: 'Quasar-Components' with: [ spec requires: #('Seaside3' 'NeoJSON') ];
				package: 'Stripe' with: [ spec requires: #('Quasar-Components') ];
				package: 'Quasar-Magritte' with: [ spec requires: #('Quasar-Components' 'DockerUtility' 'Magritte') ];
				package: 'Tidbit-ToDo' with: [ spec requires: #('Quasar-Magritte' 'Voyage') ];
				package: 'Tidbit-Loanex' with: [ spec requires: #('Quasar-Magritte' 'Voyage') ];
				package: 'Quasar-Demo' with: [ spec requires: #('Quasar-Magritte' 'Stripe') ].

			spec
				group: 'default' with: #('Quasar-Magritte');
				group: 'demo' with: #('Quasar-Demo');
				group: 'all' with: #('Quasar-Demo' 'Tidbit-ToDo' 'Tidbit-Loanex') ]
]

{ #category : #dependencies }
BaselineOfSeasideQuasar >> magritte: spec [

	spec
		baseline: 'Magritte'
		with: [ spec repository: 'github://magritte-metamodel/magritte:v3.7/source';
			loads: #( 'Magritte-Pharo-Seaside') ]
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
		with: [ spec repository: 'github://SeasideSt/Seaside:v3.4.5/repository';
			loads: #('Core' 'JSON' 'Email' 'Javascript' 'JQuery' 'Zinc' 'Seaside-Welcome') ]
]

{ #category : #dependencies }
BaselineOfSeasideQuasar >> voyage: spec [

	spec
		baseline: 'Voyage'
		with: [ spec repository: 'github://pharo-nosql/voyage:1.7.1/mc';
			loads: #( 'core' 'memory' 'mongo' ) ]
]
