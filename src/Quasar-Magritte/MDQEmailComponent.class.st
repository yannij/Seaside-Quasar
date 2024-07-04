Class {
	#name : 'MDQEmailComponent',
	#superclass : 'MDQTextInputComponent',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'rendering' }
MDQEmailComponent >> inputType [

	^ 'email'
]

{ #category : 'initialization' }
MDQEmailComponent >> setExtraOf: inputTag [

	super setExtraOf: inputTag.

	inputTag type: self inputType
]
