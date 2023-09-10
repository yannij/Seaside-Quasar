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
	| inputTag inputLabel inputValue app modelName modelOptionsName |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.

	inputTag := html qSelect "emitValue; mapOptions".
	modelName := self magritteDescription mdqLabelAsSafeIdentifier.
	inputTag vModel: modelName.
	self setFieldStyleOf: inputTag.
	app viewStyleDense ifTrue: [ inputTag optionsDense ].
	inputTag label: inputLabel.
	inputTag color: 'primary'.

	inputTag useInput; newValueModeAddUnique.
	inputTag on: self inputAspect of: self.
	inputValue := self perform: self inputAspect.
	app vueRefsSet: modelName -> inputValue.

	modelOptionsName := modelName, 'Options'.
	inputTag vBind: 'options' with: modelOptionsName.
	app vueRefsSet: modelOptionsName -> self options.

	aReadonlyFlag ifTrue: [
		inputTag readonly: true ]
]

{ #category : #rendering }
MDQSelectListComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]
