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
	| fieldTag inputTag inputLabel inputValue modelName app |

	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.
	modelName := inputLabel asCamelCase uncapitalized.
	app := self mdqApplicationGet.

	fieldTag := html qField
		vModel: modelName;
		filledIf: app viewStyleFilled;
		outlinedIf: app viewStyleOutlined;
		denseIf: app viewStyleDense;
		yourself.

	fieldTag with: [
		inputTag := html qCheckbox.
		inputTag
			denseIf: app viewStyleDense;
			trueValue: self magritteDescription trueString;
			falseValue: self magritteDescription falseString;
			label: inputLabel.
		aReadonlyFlag
			ifTrue: [
				inputTag readonly: true; modelValue: inputValue ]
			ifFalse: [
				modelName := inputLabel asCamelCase uncapitalized.
				app vueRefsAdd: modelName -> inputValue.
				inputTag "name: modelName;" vModel: modelName.
				inputTag on: self inputAspect of: self
			] ]
]

{ #category : #rendering }
MDQCheckboxComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]
