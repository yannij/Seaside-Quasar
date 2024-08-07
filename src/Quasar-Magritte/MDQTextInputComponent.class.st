Class {
	#name : 'MDQTextInputComponent',
	#superclass : 'MATextInputComponent',
	#instVars : [
		'isReadOnlyForced',
		'errorMessage'
	],
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'accessing' }
MDQTextInputComponent >> errorMessage [

	^ errorMessage
]

{ #category : 'accessing' }
MDQTextInputComponent >> errorMessage: anObject [

	errorMessage := anObject
]

{ #category : 'rendering' }
MDQTextInputComponent >> fieldPrefix [

	^ nil
]

{ #category : 'rendering' }
MDQTextInputComponent >> fieldSuffix [

	^ nil
]

{ #category : 'rendering' }
MDQTextInputComponent >> inputAspect [

	^ #string
]

{ #category : 'rendering' }
MDQTextInputComponent >> inputType [

	^ nil
]

{ #category : 'testing' }
MDQTextInputComponent >> isReadOnlyForced [

	^ isReadOnlyForced = true
]

{ #category : 'accessing' }
MDQTextInputComponent >> isReadOnlyForced: anObject [

	isReadOnlyForced := anObject
]

{ #category : 'rendering' }
MDQTextInputComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false
]

{ #category : 'rendering' }
MDQTextInputComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qInput.
	self setFieldStyleOf: inputTag.
	self setExtraOf: inputTag.
	inputTag label: inputLabel withAsteriskIfRequired: self magritteDescription isRequired.
	self fieldPrefix ifNotNil: [ :prefixValue | inputTag prefix: prefixValue ].
	self fieldSuffix ifNotNil: [ :suffixValue | inputTag suffix: suffixValue ].

	(aReadonlyFlag or: [ self isReadOnlyForced ])
		ifTrue: [
			inputTag readonly: true; modelValue: inputValue ]
		ifFalse: [ | modelName |
			modelName := self magritteDescription mdqLabelAsSafeIdentifier.
			app vueRefsSet: modelName -> inputValue.
			inputTag
				"name: modelName;" vModel: modelName;
				on: self inputAspect of: self;
				with: [ self renderTemplateOn: html vModel: modelName ]
		]
]

{ #category : 'rendering' }
MDQTextInputComponent >> renderTemplateOn: html vModel: aName [
	"Subclasses may enhance"
]

{ #category : 'rendering' }
MDQTextInputComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]

{ #category : 'rendering' }
MDQTextInputComponent >> setExtraOf: inputTag [
	"Subclasses may enhance"

	self magritteDescription comment ifNotNil: [ :value |
		inputTag hint: value ]
]
