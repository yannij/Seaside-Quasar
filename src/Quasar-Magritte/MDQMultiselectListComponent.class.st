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

	self renderMultiselectOn: html readonly: readonlyFlag
]

{ #category : #rendering }
MDQMultiselectListComponent >> renderMultiselectOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.

	inputTag := html qSelect emitValue; mapOptions.
	self setFieldStyleOf: inputTag.
	inputTag color: 'primary'.
	inputTag multiple; label: inputLabel.

	app viewStyleDense ifTrue: [
		inputTag optionsDense ].

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true ]
		ifFalse: [ | modelName modelOptionsName listValues optionsList |
			modelName := inputLabel asCamelCase uncapitalized.
			modelOptionsName := modelName, 'Options'.

			inputTag "name: modelName;" vModel: modelName.
			inputTag options: modelOptionsName.
			inputTag on: #value of: self.
			inputTag multipleCallbackValue: self availableList.
			listValues := inputTag values. "values is set by #multipleCallbackValue:"
			inputValue := self selectedList collect: [ :each | listValues keyAtValue: each ].
			optionsList := OrderedCollection new.
			self availableList withIndexDo: [ :eachOption :index | optionsList add: ({ 'label' -> eachOption. 'value' -> index} asDictionary) ].
			app vueRefsAdd: modelOptionsName -> optionsList.
			app vueRefsAdd: modelName -> inputValue.
		]
]

{ #category : #rendering }
MDQMultiselectListComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]

{ #category : #accessing }
MDQMultiselectListComponent >> value: anObject [
	"for breakpoint"
	^ super value: anObject
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
