Class {
	#name : 'QuasarDemoMoviesView',
	#superclass : 'WAComponent',
	#instVars : [
		'model',
		'isEdit'
	],
	#category : 'Quasar-Demo-Movies',
	#package : 'Quasar-Demo',
	#tag : 'Movies'
}

{ #category : 'instance creation' }
QuasarDemoMoviesView class >> on: aModel [

	^ self new
		model: aModel;
		yourself
]

{ #category : 'initialization' }
QuasarDemoMoviesView >> initialize [

	super initialize.

	self isEdit: false
]

{ #category : 'accessing' }
QuasarDemoMoviesView >> isEdit [

	^ isEdit
]

{ #category : 'accessing' }
QuasarDemoMoviesView >> isEdit: anObject [

	isEdit := anObject
]

{ #category : 'accessing' }
QuasarDemoMoviesView >> model [

	^ model
]

{ #category : 'accessing' }
QuasarDemoMoviesView >> model: anObject [

	model := anObject
]

{ #category : 'actions' }
QuasarDemoMoviesView >> modelSave: data class: aClass [

	self repositoryToUse updateData: data class: aClass.
	self isEdit: false
]

{ #category : 'rendering - unused' }
QuasarDemoMoviesView >> renderButtonsOn: html [

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

{ #category : 'rendering' }
QuasarDemoMoviesView >> renderContentOn: html [

	html div class: 'q-pa-sm'; with: [
		self isEdit
			ifTrue: [
				self renderEditorOn: html ]
			ifFalse: [
				self renderViewerOn: html.
				self renderDetailsOn: html ] ]
]

{ #category : 'rendering - utility' }
QuasarDemoMoviesView >> renderDetail: aList modelClass: aClass label: aLabel on: html [

	self qdemoApp renderModelTable: aList modelClass: aClass title: aLabel on: html
]

{ #category : 'rendering' }
QuasarDemoMoviesView >> renderDetailsOn: html [
	"Subclasses may override"
]

{ #category : 'rendering' }
QuasarDemoMoviesView >> renderEditorButtonsOn: html [

	html qBtn label: 'Save'; type: 'submit'.
	html qBtn label: 'Cancel'; type: 'a'; href: (html urlForAction: [ self isEdit: false ])
]

{ #category : 'rendering' }
QuasarDemoMoviesView >> renderEditorOn: html [
	| realObject modelClass |

	realObject := self model isSoilProxy ifTrue: [ self model soilRealObject ] ifFalse: [ self model ].
	modelClass := realObject class.

	html qForm
		vOnSubmit: '$event.target.submit()';
		method: 'post';
		action: (html urlForAction: [ self modelSave: self model asMap class: modelClass ]);
		with: [
			html div class: 'row'; with: [
				html span with: [ html text: self model summaryString ].
				html qSpace.
				html span with: [ self renderEditorButtonsOn: html ] ].
			html div class: 'row q-gutter-sm'; with: [
				self renderModelNativeWith: false on: html ] ]
]

{ #category : 'rendering - utility' }
QuasarDemoMoviesView >> renderField: aLabel type: anInputType for: anAspect readonly: readonlyFlag on: html [

	html qField
		filled; stackLabel;
		label: aLabel;
		readonly: readonlyFlag;
		with: [
			| tag |
			tag := html textInput
				readonly: readonlyFlag;
				style: 'width: 100%; outline: none; border: none; border-color: transparent; background: inherit';
				type: anInputType;
				yourself.
			anAspect = #id
				ifTrue: [ tag value: self model id; readonly: true ]
				ifFalse: [ tag on: anAspect of: self model ] ]
]

{ #category : 'rendering - unused' }
QuasarDemoMoviesView >> renderFieldsOf: aModel name: aName on: html [
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

{ #category : 'rendering - utility' }
QuasarDemoMoviesView >> renderModelLink: aModel name: aName on: html [

	aModel ifNil: [
		^ html text: aName, ' is null' ].

	html qBtn outline; round; icon: 'arrow_forward';
		type: 'a'; href: (html urlForAction: [ self qdemoApp modelSet: aModel ]).

	html space; text: aModel summaryString
]

{ #category : 'rendering' }
QuasarDemoMoviesView >> renderModelNativeWith: readonlyFlag on: html [

	self model attributeData do: [ :eachAttr |
		| fieldName |
		fieldName := eachAttr asString.
		html div class: 'col-4'; with: [
			self renderField: eachAttr type: nil for: eachAttr readonly: readonlyFlag on: html ] ]
]

{ #category : 'rendering' }
QuasarDemoMoviesView >> renderModelRefOn: html [
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

{ #category : 'rendering' }
QuasarDemoMoviesView >> renderViewerButtonsOn: html [

	html qBtn label: 'Edit'; type: 'a'; href: (html urlForAction: [ self isEdit: true ])
]

{ #category : 'rendering' }
QuasarDemoMoviesView >> renderViewerOn: html [

	html qForm
		with: [
			html div class: 'row'; with: [
				html span with: [ html text: self model summaryString ].
				html qSpace.
				html span with: [ self renderViewerButtonsOn: html ] ].
			html div class: 'row q-gutter-sm'; with: [
				self renderModelNativeWith: true on: html ] ]
]

{ #category : 'accessing' }
QuasarDemoMoviesView >> repositoryToUse [

	^ self qdemoApp repository
]
