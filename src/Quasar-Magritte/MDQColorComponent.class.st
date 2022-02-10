Class {
	#name : #MDQColorComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQColorComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue |

	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qInput.
	"self mdsTextFieldStyleIsFilled" false
		ifTrue: [ inputTag filled ]
		ifFalse: [ inputTag outlined ].

	inputTag "type: self inputType;" label: inputLabel.

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true; modelValue: inputValue ]
		ifFalse: [ | modelName |
			modelName := inputLabel asCamelCase uncapitalized.
			self mdqApplicationGet vueRefsAdd: modelName -> inputValue.
			inputTag "name: modelName;" vModel: modelName.
			inputTag on: self inputAspect of: self.
			inputTag with: [
				html qTemplate vSlot: 'append'; with: [
					html qIcon name: 'colorize'; class: 'cursor-pointer'; with: [
						html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
							html qColor vModel: modelName ] ] ] ]
		].

	"self renderTextFieldHelpTextOn: html"
]
