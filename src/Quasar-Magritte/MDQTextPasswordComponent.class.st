Class {
	#name : 'MDQTextPasswordComponent',
	#superclass : 'MDQTextInputComponent',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'rendering' }
MDQTextPasswordComponent >> inputType [

	^ 'password'
]

{ #category : 'rendering' }
MDQTextPasswordComponent >> setExtraOf: inputTag [

	super setExtraOf: inputTag.

	inputTag type: self inputType
]
