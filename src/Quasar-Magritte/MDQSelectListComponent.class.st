Class {
	#name : #MDQSelectListComponent,
	#superclass : #MASelectListComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQSelectListComponent >> inputAspect [

	^ #string
]

{ #category : #rendering }
MDQSelectListComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false
]

{ #category : #rendering }
MDQSelectListComponent >> renderFieldOn: html readonly: readonlyFlag [

	self renderSelectOn: html readonly: readonlyFlag
]

{ #category : #rendering }
MDQSelectListComponent >> renderSelectOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qSelect emitValue; mapOptions.
	self setFieldStyleOf: inputTag.
	app viewStyleDense ifTrue: [ inputTag optionsDense ].
	aReadonlyFlag ifTrue: [ inputTag optionDisable ].
	inputTag label: inputLabel.
	inputTag color: 'primary'.
	inputTag useInput; newValueMode.

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true ]
		ifFalse: [ | modelName modelOptionsName |
			modelName := self magritteDescription mdqLabelAsSafeIdentifier.
			modelOptionsName := modelName, 'Options'.
			app vueRefsSet: modelName -> inputValue.
			app vueRefsSet: modelOptionsName -> self options.

			inputTag "name: modelName;" vModel: modelName.
			inputTag vBind: 'options' with: modelOptionsName.
			inputTag on: self inputAspect of: self
		]
]

{ #category : #rendering }
MDQSelectListComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]
