Extension { #name : #WAComponent }

{ #category : #'*Quasar-Demo' }
WAComponent >> qdemoApp [

	^ self session
		ifNil: [ nil ]
		ifNotNil: [ :value | value presenter ]
]
