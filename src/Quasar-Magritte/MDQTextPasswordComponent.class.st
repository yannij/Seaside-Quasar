Class {
	#name : #MDQTextPasswordComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQTextPasswordComponent >> inputType [

	^ 'password'
]

{ #category : #rendering }
MDQTextPasswordComponent >> setExtraOf: inputTag [

	inputTag type: self inputType
]
