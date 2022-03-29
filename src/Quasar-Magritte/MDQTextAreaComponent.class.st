Class {
	#name : #MDQTextAreaComponent,
	#superclass : #MDQTextInputComponent,
	#instVars : [
		'mdsFieldHeight'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQTextAreaComponent >> inputType [

	^ 'textarea'
]

{ #category : #rendering }
MDQTextAreaComponent >> setExtraOf: inputTag [

	inputTag type: self inputType.
	inputTag attributeAt: 'rows' put: 5.
	"inputTag attributeAt: 'autogrow' put: true."
]
