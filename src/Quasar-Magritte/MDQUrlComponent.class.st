Class {
	#name : #MDQUrlComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQUrlComponent >> inputType [

	^ 'url'
]

{ #category : #initialization }
MDQUrlComponent >> setExtraOf: inputTag [

	super setExtraOf: inputTag.

	inputTag type: self inputType
]
