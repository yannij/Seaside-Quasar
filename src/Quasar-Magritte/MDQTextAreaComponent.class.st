Class {
	#name : #MDQTextAreaComponent,
	#superclass : #MATextAreaComponent,
	#instVars : [
		'mdsFieldHeight'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #initialization }
MDQTextAreaComponent >> initialize [

	super initialize.

	self mdsFieldHeight: 2
]

{ #category : #rendering }
MDQTextAreaComponent >> inputAspect [

	^ #string
]

{ #category : #rendering }
MDQTextAreaComponent >> inputType [

	^ 'textarea'
]

{ #category : #accessing }
MDQTextAreaComponent >> mdsFieldHeight [

	^ mdsFieldHeight
]

{ #category : #accessing }
MDQTextAreaComponent >> mdsFieldHeight: anObject [

	mdsFieldHeight := anObject
]

{ #category : #accessing }
MDQTextAreaComponent >> mdsFieldHeightGet [

	^ self mdsFieldHeight max: 3
]

{ #category : #rendering }
MDQTextAreaComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false

]

{ #category : #rendering }
MDQTextAreaComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue |

	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qInput.
	"self mdsTextFieldStyleIsFilled
		ifTrue: [ inputTag filled ]
		ifFalse: [ inputTag outlined ]."

	inputTag type: self inputType; label: inputLabel.
	"inputTag inputStyle: 'height: ', (self mdsTextFieldHeightOf: self mdsFieldHeightGet) printString, 'px'."
	inputTag inputStyle: 'resize: none'.
	"inputTag attributeAt: 'rows' put: self mdsFieldHeightGet."
	"inputTag attributeAt: 'autogrow' put: true."

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true; modelValue: inputValue ]
		ifFalse: [ | modelName |
			modelName := inputLabel asCamelCase uncapitalized.
			self mdqApplicationGet vueRefsAdd: modelName -> inputValue.
			inputTag "name: modelName;" vModel: modelName.
			inputTag on: self inputAspect of: self
		].

	"self renderTextFieldHelpTextOn: html"
]

{ #category : #rendering }
MDQTextAreaComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true

]
