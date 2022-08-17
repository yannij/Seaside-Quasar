Class {
	#name : #MDQTextAreaComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQTextAreaComponent >> inputType [

	^ 'textarea'
]

{ #category : #rendering }
MDQTextAreaComponent >> renderFieldOn: html readonly: aReadonlyFlag [
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
			modelName := self magritteDescription mdqLabelAsSafeIdentifier.
			app vueRefsAdd: modelName -> inputValue.
			inputTag
				"name: modelName;" vModel: modelName;
				on: self inputAspect of: self;
				with: [ self renderTemplateOn: html vModel: modelName ]
		]
]

{ #category : #rendering }
MDQTextAreaComponent >> setExtraOf: inputTag [

	inputTag type: self inputType.
	inputTag attributeAt: 'rows' put: 5.
	"inputTag attributeAt: 'autogrow' put: true."
]
