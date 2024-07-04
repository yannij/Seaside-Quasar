Extension { #name : 'MAStringWriter' }

{ #category : '*Quasar-Magritte' }
MAStringWriter >> visitHexColorDescription: aDescription [

	stream nextPutAll: self object
]
