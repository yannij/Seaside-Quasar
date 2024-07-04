Extension { #name : 'MAMultipleOptionDescription' }

{ #category : '*Quasar-Magritte' }
MAMultipleOptionDescription class >> mdqDefaultComponentClasses [

	^ Array with: MDQMultiselectListComponent
]

{ #category : '*Quasar-Magritte' }
MAMultipleOptionDescription >> mdqIsToMany [

	^ true
]
