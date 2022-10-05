Extension { #name : #Duration }

{ #category : #'*Quasar-Magritte' }
Duration >> jsonOn: aRenderer [

	"aRenderer number: self asMilliSeconds"
	aRenderer string: self greaseString
]
