Extension { #name : 'JSFunction' }

{ #category : '*Quasar-Components' }
JSFunction >> jsonOn: aRenderer [

	aRenderer document nextPutAll: self asJavascript
]
