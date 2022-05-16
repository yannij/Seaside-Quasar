Class {
	#name : #MDQTextInputComponent,
	#superclass : #MATextInputComponent,
	#instVars : [
		'readonlyForced'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQTextInputComponent >> beReadonlyForced [

	self readonlyForced: true
]

{ #category : #rendering }
MDQTextInputComponent >> fieldPrefix [

	^ nil
]

{ #category : #rendering }
MDQTextInputComponent >> fieldSuffix [

	^ nil
]

{ #category : #rendering }
MDQTextInputComponent >> inputAspect [

	^ #string
]

{ #category : #rendering }
MDQTextInputComponent >> inputType [

	^ 'text'
]

{ #category : #testing }
MDQTextInputComponent >> isReadonlyForced [

	^ readonlyForced = true
]

{ #category : #accessing }
MDQTextInputComponent >> readonlyForced [

	^ readonlyForced
]

{ #category : #accessing }
MDQTextInputComponent >> readonlyForced: anObject [

	readonlyForced := anObject
]

{ #category : #rendering }
MDQTextInputComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false
]

{ #category : #rendering }
MDQTextInputComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qInput.
	self setFieldStyleOf: inputTag.
	self setExtraOf: inputTag.
	inputTag label: inputLabel.
	self fieldPrefix ifNotNil: [ :prefixValue | inputTag prefix: prefixValue ].
	self fieldSuffix ifNotNil: [ :suffixValue | inputTag suffix: suffixValue ].

	(aReadonlyFlag or: [ self isReadonlyForced ])
		ifTrue: [
			inputTag readonly: true; modelValue: inputValue ]
		ifFalse: [ | modelName |
			modelName := inputLabel asCamelCase uncapitalized.
			app vueRefsAdd: modelName -> inputValue.
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

{ #category : #rendering }
MDQTextInputComponent >> setExtraOf: inputTag [
	"Subclasses may enhance"
]
