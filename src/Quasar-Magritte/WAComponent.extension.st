Extension { #name : #WAComponent }

{ #category : #'*Quasar-Magritte' }
WAComponent >> mdqApplicationGet [

	^ self session
		ifNil: [ nil ]
		ifNotNil: [ :value | value presenter ]
]
