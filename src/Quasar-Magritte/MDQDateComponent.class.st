Class {
	#name : #MDQDateComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQDateComponent >> dateHtml5 [

	^ self value
		ifNil: [ Date today yyyymmdd ]
		ifNotNil: [ :t | t isString ifTrue: [ t asDate ] ifFalse: [ t asDate yyyymmdd ] ]

]

{ #category : #accessing }
MDQDateComponent >> dateHtml5: aString [

	aString isEmpty ifFalse: [
		self value: (Date fromString: aString) ]
]

{ #category : #rendering }
MDQDateComponent >> inputAspect [

	^ #dateHtml5
]

{ #category : #rendering }
MDQDateComponent >> inputType [

	^ 'date'
]
