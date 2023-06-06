Class {
	#name : #QuasarDemoAccountingView,
	#superclass : #WAComponent,
	#instVars : [
		'model'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #'instance creation' }
QuasarDemoAccountingView class >> on: aModel [

	^ self new
		model: aModel;
		yourself
]

{ #category : #accessing }
QuasarDemoAccountingView >> model [

	^ model
]

{ #category : #accessing }
QuasarDemoAccountingView >> model: anObject [

	model := anObject
]

{ #category : #actions }
QuasarDemoAccountingView >> modelSave [
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderButtonsOn: html [

	html qBtn
		flat; round; type: 'submit';
		"type: 'a'; href: (html urlForAction: [ self modelSave ]);"
		"onClick: ((html jQuery ajax) callback: [ self execute: #save ]; onComplete: html javascript refresh);"
		icon: 'done'.

	html qBtn
		flat; round; type: 'reset';
		disable; "Does not cancel."
		icon: 'cancel'
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderContentOn: html [

	self renderFormOn: html.
	self renderDetailsOn: html
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderDetail: aList modelClass: aClass label: aLabel on: html [

	self renderHeading: aLabel on: html.
	self qdemoApp renderModelTable: aList modelClass: aClass on: html
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderDetailsOn: html [
	"Subclasses may override"
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderFieldsOf: aModel name: aName on: html [
	| formObjectName formObject |

	"self renderHeading: aName on: html."
	aModel isNil ifTrue: [ ^ html text: aName, ' is null' ].
	html text: aName; space.
	html qBtn outline; round; icon: 'arrow_forward';
		type: 'a'; href: (html urlForAction: [ self qdemoApp modelSet: aModel ]).

	formObjectName := 'tmp'.
	formObject := Dictionary new.
	aModel attributeData do: [ :eachAttr | formObject at: eachAttr put: (aModel perform: eachAttr asSymbol) ].
	self qdemoApp vueRefsSet: formObjectName -> formObject.

	html div with: [ html text: aModel summaryString ].
	html div class: 'row q-pa-sm'; with: [
		aModel attributeData do: [ :eachAttr |
			| fieldName |
			fieldName := eachAttr asString.
			html div class: 'col-4 q-pa-sm'; with: [
				html qInput label: fieldName; vModel: (formObjectName, '.', fieldName); on: fieldName asSymbol of: aModel ] ] ]
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderFormContentOn: html [
	| formObjectName formObject |

	formObjectName := 'fo'.
	formObject := Dictionary new.
	self model attributeData do: [ :eachAttr | formObject at: eachAttr put: (self model perform: eachAttr asSymbol) ].
	self qdemoApp vueRefsSet: formObjectName -> formObject.

	html div with: [ html text: self model summaryString ].
	html div class: 'row q-pa-sm'; with: [
		self model attributeData do: [ :eachAttr |
			| fieldName |
			fieldName := eachAttr asString.
			html div class: 'col-4 q-pa-sm'; with: [
				html qInput label: fieldName; vModel: (formObjectName, '.', fieldName); on: fieldName asSymbol of: self model ] ] ]
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderFormOn: html [

	html qForm
		vOnSubmit: '$event.target.submit()';
		method: 'post';
		action: (html urlForAction: [ self modelSave ]);
		with: [
			self renderButtonsOn: html.
			self renderFormContentOn: html ]
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderHeading: aLabel on: html [

	html heading level5; with: aLabel
]
