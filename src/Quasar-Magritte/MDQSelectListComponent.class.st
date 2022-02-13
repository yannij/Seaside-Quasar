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

	self renderSelectOn: html readonly: readonlyFlag.
	"self renderTextFieldHelpTextOn: html"
]

{ #category : #rendering }
MDQSelectListComponent >> renderSelectOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app |

	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qSelect.
	inputTag color: 'primary'.

	app := self mdqApplicationGet.
	inputTag filledIf: app viewStyleFilled.
	inputTag outlinedIf: app viewStyleOutlined.
	inputTag denseIf: app viewStyleDense.

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true ]
		ifFalse: [ | modelName modelOptionsName |
			modelName := inputLabel asCamelCase uncapitalized.
			self mdqApplicationGet vueRefsAdd: modelName -> inputValue.
			modelOptionsName := modelName, 'Options'.
			self mdqApplicationGet quasarDataAdd: modelOptionsName.
			html document addLoadScript: (JSStream on: (self vueOptionDataNamed: modelOptionsName)).

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
