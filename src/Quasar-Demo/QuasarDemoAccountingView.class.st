Class {
	#name : #QuasarDemoAccountingView,
	#superclass : #WAComponent,
	#instVars : [
		'model',
		'isEdit'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #'instance creation' }
QuasarDemoAccountingView class >> on: aModel [

	^ self new
		model: aModel;
		yourself
]

{ #category : #initialization }
QuasarDemoAccountingView >> initialize [

	super initialize.

	self isEdit: false
]

{ #category : #accessing }
QuasarDemoAccountingView >> isEdit [

	^ isEdit
]

{ #category : #accessing }
QuasarDemoAccountingView >> isEdit: anObject [

	isEdit := anObject
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

	self isEdit: false
]

{ #category : #'rendering - unused' }
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

	html div class: 'q-pa-sm'; with: [
		self isEdit
			ifTrue: [
				self renderEditorOn: html ]
			ifFalse: [
				self renderViewerOn: html.
				self renderDetailsOn: html ] ]
]

{ #category : #'rendering - utility' }
QuasarDemoAccountingView >> renderDetail: aList modelClass: aClass label: aLabel on: html [

	self qdemoApp renderModelTable: aList modelClass: aClass title: aLabel on: html
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderDetailsOn: html [
	"Subclasses may override"
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderEditorButtonsOn: html [

	html qBtn label: 'Save'; type: 'submit'.
	html qBtn label: 'Cancel'; type: 'a'; href: (html urlForAction: [ self isEdit: false ])
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderEditorOn: html [

	html qForm
		vOnSubmit: '$event.target.submit()';
		method: 'post';
		action: (html urlForAction: [ self modelSave ]);
		with: [
			html div class: 'row'; with: [
				html span with: [ html text: self model summaryString ].
				html qSpace.
				html span with: [ self renderEditorButtonsOn: html ] ].
			html div class: 'row q-gutter-sm'; with: [
				self renderModelNativeWith: false on: html ] ]
]

{ #category : #'rendering - utility' }
QuasarDemoAccountingView >> renderField: aLabel type: anInputType for: anAspect readonly: readonlyFlag on: html [

	html qField
		filled; stackLabel;
		label: aLabel;
		readonly: readonlyFlag;
		with: [
			html textInput
				readonly: readonlyFlag;
				style: 'width: 100%; outline: none; border: none; border-color: transparent; background: inherit';
				type: anInputType;
				on: anAspect of: self model ]
]

{ #category : #'rendering - unused' }
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

{ #category : #'rendering - utility' }
QuasarDemoAccountingView >> renderModelLink: aModel name: aName on: html [

	aModel ifNil: [
		^ html text: aName, ' is null' ].

	html qBtn outline; round; icon: 'arrow_forward';
		type: 'a'; href: (html urlForAction: [ self qdemoApp modelSet: aModel ]).

	html space; text: aModel summaryString
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderModelNativeWith: readonlyFlag on: html [

	self model attributeData do: [ :eachAttr |
		| fieldName |
		fieldName := eachAttr asString.
		html div class: 'col-4'; with: [
			self renderField: eachAttr type: nil for: eachAttr readonly: readonlyFlag on: html ] ]
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderModelRefOn: html [
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
QuasarDemoAccountingView >> renderViewerButtonsOn: html [

	html qBtn label: 'Edit'; type: 'a'; href: (html urlForAction: [ self isEdit: true ])
]

{ #category : #rendering }
QuasarDemoAccountingView >> renderViewerOn: html [

	html qForm
		with: [
			html div class: 'row'; with: [
				html span with: [ html text: self model summaryString ].
				html qSpace.
				html span with: [ self renderViewerButtonsOn: html ] ].
			html div class: 'row q-gutter-sm'; with: [
				self renderModelNativeWith: true on: html ] ]
]

{ #category : #accessing }
QuasarDemoAccountingView >> repositoryToUse [

	^ self qdemoApp repository
]
