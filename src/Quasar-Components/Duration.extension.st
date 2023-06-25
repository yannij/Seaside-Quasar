Extension { #name : #Duration }

{ #category : #'*Quasar-Components' }
Duration >> jsonOn: aRenderer [

	"aRenderer number: self asMilliSeconds"
	aRenderer string: self greaseString
]
