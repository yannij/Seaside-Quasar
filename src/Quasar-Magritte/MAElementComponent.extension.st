Extension { #name : #MAElementComponent }

{ #category : #'*Quasar-Magritte' }
MAElementComponent >> setFieldStyleOf: aFieldTag [
	| app |

	app := self mdqApplicationGet.
	aFieldTag stackLabel.
	aFieldTag filledIf: app viewStyleFilled.
	aFieldTag outlinedIf: app viewStyleOutlined.
	aFieldTag denseIf: app viewStyleDense
]
