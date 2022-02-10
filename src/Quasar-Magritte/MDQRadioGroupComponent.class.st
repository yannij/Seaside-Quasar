Class {
	#name : #MDQRadioGroupComponent,
	#superclass : #MARadioGroupComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #testing }
MDQRadioGroupComponent >> hasLabelId [

	^ false
]

{ #category : #rendering }
MDQRadioGroupComponent >> inputAspect [

	^ #value
]

{ #category : #rendering }
MDQRadioGroupComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false
]

{ #category : #rendering }
MDQRadioGroupComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputLabel inputValue inputTag modelName |

	inputValue := self perform: self inputAspect.
	inputLabel := self magritteDescription label.
	modelName := inputLabel asCamelCase uncapitalized.
	self mdqApplicationGet vueRefsAdd: modelName -> (self labelForOption: inputValue).

	self optionsWithIndexDo: [ :each :index |
		inputTag := html qRadio.
		inputTag
			"name: modelName;" vModel: modelName;
			callback: (GRDelayedSend receiver: self selector: self inputAspect asMutator);
			val: (self valForOption: each);
			label: (self labelForOption: each) ]
		separatedBy: [  ].

	"self renderTextFieldHelpTextOn: html"
]

{ #category : #rendering }
MDQRadioGroupComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]

{ #category : #rendering }
MDQRadioGroupComponent >> valForOption: anOption [

	^ anOption
]
