Class {
	#name : #MDQMultiselectListComponent,
	#superclass : #MAMultipleSelectionComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #testing }
MDQMultiselectListComponent class >> isAbstract [
	^ false
]

{ #category : #testing }
MDQMultiselectListComponent >> isDistinct [
	^ true
]

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
	| inputTag inputLabel inputValue app modelName modelOptionsName listValues optionsList |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.

	inputTag := html qSelect emitValue; mapOptions.
	modelName := self magritteDescription mdqLabelAsSafeIdentifier.
	inputTag vModel: modelName.
	self setFieldStyleOf: inputTag.
	app viewStyleDense ifTrue: [ inputTag optionsDense ].
	inputTag label: inputLabel.
	inputTag color: 'primary'.

	inputTag multiple; useChips.
	inputTag on: #value of: self.
	inputTag multipleCallbackValue: self availableList.
	listValues := inputTag values. "values is set by #multipleCallbackValue:"
	inputValue := self selectedList collect: [ :each | listValues keyAtValue: each ].
	optionsList := OrderedCollection new.
	self availableList withIndexDo: [ :eachOption :index |
		optionsList add: ({ 'label' -> eachOption. 'value' -> index} asDictionary) ].
	"Options needed for labels to display in multi-select"
	modelOptionsName := modelName, 'Options'.
	inputTag vBind: 'options' with: modelOptionsName.
	app vueRefsSet: modelOptionsName -> optionsList.

	app vueRefsSet: modelName -> inputValue.

	aReadonlyFlag ifTrue: [
		inputTag readonly: true ]
]

{ #category : #rendering }
MDQMultiselectListComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]
