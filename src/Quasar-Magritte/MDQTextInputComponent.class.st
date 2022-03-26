Class {
	#name : #MDQTextInputComponent,
	#superclass : #MATextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQTextInputComponent >> inputAspect [

	^ #string
]

{ #category : #rendering }
MDQTextInputComponent >> inputType [

	^ 'text'
]

{ #category : #rendering }
MDQTextInputComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false
]

{ #category : #rendering }
MDQTextInputComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app |

	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qInput.
	inputTag stackLabel.
	inputTag label: inputLabel.

	app := self mdqApplicationGet.
	inputTag filledIf: app viewStyleFilled.
	inputTag outlinedIf: app viewStyleOutlined.
	inputTag denseIf: app viewStyleDense.

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true; modelValue: inputValue ]
		ifFalse: [ | modelName |
			modelName := inputLabel asCamelCase uncapitalized.
			self mdqApplicationGet vueRefsAdd: modelName -> inputValue.
			inputTag
				"name: modelName;" vModel: modelName;
				on: self inputAspect of: self;
				with: [ self renderTemplateOn: html vModel: modelName ]
		]
]

{ #category : #rendering }
MDQTextInputComponent >> renderTemplateOn: html vModel: aName [
	"Subclasses may enhance"
]

{ #category : #rendering }
MDQTextInputComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]
