Class {
	#name : #MDQCheckboxComponent,
	#superclass : #MACheckboxComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQCheckboxComponent >> inputAspect [

	^ #string
]

{ #category : #rendering }
MDQCheckboxComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false
]

{ #category : #rendering }
MDQCheckboxComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue |

	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qCheckbox.
	inputTag
		trueValue: self magritteDescription trueString;
		"falseValue: self magritteDescription falseString;"
		label: inputLabel.
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
MDQCheckboxComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]
