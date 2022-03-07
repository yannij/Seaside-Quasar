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

	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qSelect.
	inputTag color: 'primary'.

	app := self mdqApplicationGet.
	inputTag
		filledIf: app viewStyleFilled;
		outlinedIf: app viewStyleOutlined;
		denseIf: app viewStyleDense;
		label: inputLabel.

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true ]
		ifFalse: [ | modelName modelOptionsName |
			modelName := inputLabel asCamelCase uncapitalized.
			modelOptionsName := modelName, 'Options'.
			self mdqApplicationGet vueRefsAdd: modelName -> inputValue.
			self mdqApplicationGet vueRefsAdd: modelOptionsName -> self options.

			inputTag "name: modelName;" vModel: modelName.
			inputTag options: modelOptionsName.
			inputTag on: self inputAspect of: self
		]
]

{ #category : #rendering }
MDQSelectListComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]

{ #category : #rendering }
MDQSelectListComponent >> vueOptionDataNamed: aName [
	| data |

	data := OrderedCollection new.
	self options keysAndValuesDo: [ :index :item |
		data add: {'label' -> (self labelForOption: item). 'value' -> item greaseString} asDictionary ].

	^ String streamContents: [ :stream |
		stream nextPutAll: 'const '; nextPutAll: aName; nextPutAll: ' = '.
		stream nextPutAll: data asJson
	]
]
