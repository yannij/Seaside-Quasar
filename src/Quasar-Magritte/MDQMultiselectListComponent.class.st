Class {
	#name : #MDQMultiselectListComponent,
	#superclass : #MAMultiselectListComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQMultiselectListComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false
]

{ #category : #rendering }
MDQMultiselectListComponent >> renderFieldOn: html readonly: readonlyFlag [

	self renderMultiselectOn: html readonly: readonlyFlag.
	"self renderTextFieldHelpTextOn: html"
]

{ #category : #rendering }
MDQMultiselectListComponent >> renderMultiselectOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app |

	inputTag := html qSelect.
	inputLabel := self magritteDescription label.
	inputTag color: 'primary'.

	inputTag multiple; label: inputLabel.

	app := self mdqApplicationGet.
	inputTag filledIf: app viewStyleFilled.
	inputTag outlinedIf: app viewStyleOutlined.
	inputTag denseIf: app viewStyleDense.
	inputTag denseIf: app viewStyleDense.

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true ]
		ifFalse: [ | modelName modelOptionsName listValues |
			modelName := inputLabel asCamelCase uncapitalized.
			modelOptionsName := modelName, 'Options'.
			self mdqApplicationGet quasarDataAdd: modelOptionsName.
			html document addLoadScript: (JSStream on: (self vueOptionDataNamed: modelOptionsName)).

			inputTag "name: modelName;" vModel: modelName.
			inputTag options: modelOptionsName.
			inputTag on: #value of: self.
			inputTag multipleCallbackValue: self availableList.
			listValues := inputTag values. "set by #multipleCallbackValue: above"
			inputValue := self selectedList collect: [ :each | listValues keyAtValue: each ].
			self mdqApplicationGet vueRefsAdd: modelName -> inputValue.
		]
]

{ #category : #rendering }
MDQMultiselectListComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]

{ #category : #rendering }
MDQMultiselectListComponent >> vueOptionDataNamed: aName [
	| data |

	data := OrderedCollection new.
	self availableList keysAndValuesDo: [ :index :item |
		data add: {'label' -> (self labelForOption: item). 'value' -> index} asDictionary ].

	^ String streamContents: [ :stream |
		stream nextPutAll: 'const '; nextPutAll: aName; nextPutAll: ' = '.
		stream nextPutAll: data asJson
	]
]
