Class {
	#name : #MDQEmailComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQEmailComponent >> inputType [

	^ 'email'
]

{ #category : #initialization }
MDQEmailComponent >> setExtraOf: inputTag [

	inputTag type: self inputType
]
