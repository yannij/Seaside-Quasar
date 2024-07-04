Extension { #name : 'MAToManyRelationDescription' }

{ #category : '*Quasar-Magritte' }
MAToManyRelationDescription class >> mdqDefaultComponentClasses [

	^ Array with: MDQOneToManyComponent
]

{ #category : '*Quasar-Magritte' }
MAToManyRelationDescription >> mdqIsToMany [

	^ true
]
