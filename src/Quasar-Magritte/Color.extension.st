Extension { #name : #Color }

{ #category : #'*Quasar-Magritte' }
Color >> jsonOn: aRenderer [

	aRenderer string: self asHTMLColor
]
