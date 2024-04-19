Class {
	#name : #MDQPhoneComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQPhoneComponent >> inputType [

	^ 'tel'
]

{ #category : #initialization }
MDQPhoneComponent >> setExtraOf: inputTag [

	super setExtraOf: inputTag.

	inputTag type: self inputType
]
