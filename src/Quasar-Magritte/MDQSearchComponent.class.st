Class {
	#name : #MDQSearchComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQSearchComponent >> inputType [

	^ 'search'
]

{ #category : #rendering }
MDQSearchComponent >> renderTemplateOn: html vModel: aName [

	html qTemplate vSlot: 'append'; with: [
		html qIcon name: 'search' ] 
]

{ #category : #initialization }
MDQSearchComponent >> setExtraOf: inputTag [

	inputTag type: self inputType
]
