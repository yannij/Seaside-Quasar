Class {
	#name : 'MDQCheckboxComponent',
	#superclass : 'MACheckboxComponent',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'accessing' }
MDQCheckboxComponent >> inputAspect [

	^ #string
]

{ #category : 'rendering' }
MDQCheckboxComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false
]

{ #category : 'rendering' }
MDQCheckboxComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| fieldTag inputTag inputLabel inputValue modelName app |

	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.
	modelName := self magritteDescription mdqLabelAsSafeIdentifier.
	app := self mdqApplicationGet.

	fieldTag := html qField.
	self setFieldStyleOf: fieldTag.
	fieldTag vModel: modelName.

	fieldTag with: [
		inputTag := html qCheckbox.
		inputTag
			denseIf: app viewStyleDense;
			trueValue: self magritteDescription trueString;
			falseValue: self magritteDescription falseString;
			label: inputLabel withAsteriskIfRequired: self magritteDescription isRequired.
		aReadonlyFlag
			ifTrue: [
				inputTag readonly: true; modelValue: inputValue ]
			ifFalse: [
				app vueRefsSet: modelName -> inputValue.
				inputTag "name: modelName;" vModel: modelName.
				inputTag on: self inputAspect of: self
			] ]
]

{ #category : 'rendering' }
MDQCheckboxComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]
