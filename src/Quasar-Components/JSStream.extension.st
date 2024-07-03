Extension { #name : 'JSStream' }

{ #category : '*Quasar-Components' }
JSStream >> jsonOn: aRenderer [

	aRenderer document nextPutAll: self asJavascript
]
