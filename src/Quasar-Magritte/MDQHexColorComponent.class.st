Class {
	#name : #MDQHexColorComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQHexColorComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qInput.
	self setFieldStyleOf: inputTag.
	inputTag "type: self inputType;" label: inputLabel.

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true; modelValue: inputValue ]
		ifFalse: [ | modelName |
			modelName := self magritteDescription mdqLabelAsSafeIdentifier.
			app vueRefsSet: modelName -> inputValue.
			inputTag "name: modelName;" vModel: modelName.
			inputTag on: self inputAspect of: self.
			inputTag with: [
				html qTemplate vSlot: 'prepend'; with: [
					html div
						style: 'width: 24px; height: 24px';
						vBind: 'style' with: '{background: ', modelName, '}' ].
				html qTemplate vSlot: 'append'; with: [
					html qIcon name: 'colorize'; class: 'cursor-pointer'; with: [
						html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
							html qColor vModel: modelName ] ] ] ]
		]
]
