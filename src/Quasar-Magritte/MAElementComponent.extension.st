Extension { #name : #MAElementComponent }

{ #category : #'*Quasar-Magritte' }
MAElementComponent >> errorMessage [

	^ nil
]

{ #category : #'*Quasar-Magritte' }
MAElementComponent >> errorMessage: anObject [
]

{ #category : #'*Quasar-Magritte' }
MAElementComponent >> setErrorMessageOf: anInputTag [

	"anInputTag hint: 'foobar'."
	self errorMessage ifNotNil: [ :value |
		anInputTag qerror: true; errorMessage: value ]
]

{ #category : #'*Quasar-Magritte' }
MAElementComponent >> setFieldStyleOf: aFieldTag [
	| app |

	app := self mdqApplicationGet.
	aFieldTag stackLabel.
	app viewStyleFilled ifTrue: [ aFieldTag filled ] ifFalse: [ aFieldTag outlined ].
	aFieldTag denseIf: app viewStyleDense.
	self setErrorMessageOf: aFieldTag
]
