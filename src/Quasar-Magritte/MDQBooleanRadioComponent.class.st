Class {
	#name : #MDQBooleanRadioComponent,
	#superclass : #MDQRadioGroupComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQBooleanRadioComponent >> booleanValue [

	^ self value
]

{ #category : #rendering }
MDQBooleanRadioComponent >> booleanValue: aString [

	self value: (aString = self magritteDescription trueString)
]

{ #category : #rendering }
MDQBooleanRadioComponent >> inputAspect [

	^ #booleanValue
]

{ #category : #rendering }
MDQBooleanRadioComponent >> valForOption: anOption [

	^ self labelForOption: anOption
]
