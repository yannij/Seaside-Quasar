Extension { #name : #Date }

{ #category : #'*Quasar-Magritte' }
Date >> jsonOn: aRenderer [

	aRenderer string: self yyyymmdd
]
