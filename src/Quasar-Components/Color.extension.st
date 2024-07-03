Extension { #name : 'Color' }

{ #category : '*Quasar-Components' }
Color >> jsonOn: aRenderer [

	aRenderer string: self asHTMLColor
]
