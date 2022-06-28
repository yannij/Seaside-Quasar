Extension { #name : #MAStringReader }

{ #category : #'*Quasar-Magritte' }
MAStringReader >> visitHexColorDescription: aDescription [

	(self contents notEmpty and: [ self contents allSatisfy: [ :each | '#0123456789ABCDEFabcdef.' includes: each ] ])
		ifFalse: [ MAReadError signal ].
	self object: self contents
]
