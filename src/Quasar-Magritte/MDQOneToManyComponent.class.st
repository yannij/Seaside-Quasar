Class {
	#name : #MDQOneToManyComponent,
	#superclass : #MAOneToManyComponent,
	#instVars : [
		'quasarData',
		'expanded'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #'as yet unclassified' }
MDQOneToManyComponent >> associateToMany [
]

{ #category : #actions }
MDQOneToManyComponent >> beExpanded [

	self expanded: true
]

{ #category : #private }
MDQOneToManyComponent >> buildReport [

	^ (MDQReport rows: self value description: self reference)
		refNameCols: self quasarDataColumnName;
		refNameRows: self quasarDataRowName;
		yourself
]

{ #category : #accessing }
MDQOneToManyComponent >> expanded [
	^ expanded
]

{ #category : #accessing }
MDQOneToManyComponent >> expanded: anObject [
	expanded := anObject
]

{ #category : #initialization }
MDQOneToManyComponent >> initialize [

	super initialize.

	self quasarData: OrderedCollection new.
	self expanded: false
]

{ #category : #accessing }
MDQOneToManyComponent >> isExpanded [

	^ self expanded
]

{ #category : #accessing }
MDQOneToManyComponent >> quasarData [

	^ quasarData
]

{ #category : #accessing }
MDQOneToManyComponent >> quasarData: anObject [

	quasarData := anObject
]

{ #category : #accessing }
MDQOneToManyComponent >> quasarDataAdd: anObject [

	self quasarData addIfNotPresent: anObject
]

{ #category : #private }
MDQOneToManyComponent >> quasarDataBasename [

	^ 'foobar'
]

{ #category : #private }
MDQOneToManyComponent >> quasarDataColumnName [

	^ self quasarDataBasename, 'Col'
]

{ #category : #private }
MDQOneToManyComponent >> quasarDataRowName [

	^ self quasarDataBasename, 'Row'
]

{ #category : #rendering }
MDQOneToManyComponent >> renderAddButtonOn: html [

	html qBtn
		type: 'a'; href: (html urlForAction: [ self add ]);
		icon: 'add'
]

{ #category : #rendering }
MDQOneToManyComponent >> renderAssociateManyButtonOn: html [

	html qBtn
		type: 'a'; href: (html urlForAction: [ self associateToMany ]);
		icon: 'ballot'
]

{ #category : #rendering }
MDQOneToManyComponent >> renderExpandIconOnListId: listId on: html [

	html span
		onClick: ((html jQuery ajax)
			callback: [ self expanded: self expanded not ];
			onComplete: ((html jQuery id: listId) load html: [ :renderer | self renderListAjaxOn: renderer ]));
		with: [
			html div mdcButton__ripple;
				with: (self expanded ifTrue: [ 'expand_less' ] ifFalse: [ 'expand_more' ]) ]

]

{ #category : #rendering }
MDQOneToManyComponent >> renderLabelOn: html [

	html text: self magritteDescription label
	"self magritteDescription mcwNavPriority ifNil: [
		^ html text: self magritteDescription label ].

	html div mdcChip; mdcRippleUpgraded; tabIndex: 0;
		onClick: ((html jQuery ajax)
			callback: [ self mdqApplicationGet navTo: self memento model aspect: self magritteDescription label ];
			onComplete: html javascript refresh);
		with: self magritteDescription label"
]

{ #category : #rendering }
MDQOneToManyComponent >> renderListAjaxOn: html [

	self value
		ifEmpty: [
			html qItem with: [
				html qItemSection with: [
					html span with: '** NONE **' ].
			^ self ] ]
		ifNotEmpty: [ : anItemList |
			anItemList do: [ :eachItem |
				html qItem
					qTag: 'a'; href: (html urlForAction: [ :value | self mdqApplicationGet navTo: eachItem aspect: nil ]);
					with: [
						html qItemSection with: [
							html qItemLabel with: eachItem mdPrimaryString.
							html qItemLabel caption; with: eachItem mdSecondaryString ] ] ] ]
]

{ #category : #'rendering-buttons' }
MDQOneToManyComponent >> renderSelectButtonOn: html [

	"Place the add button elsewhere"
	"html submitButton on: #add of: self"
]

{ #category : #rendering }
MDQOneToManyComponent >> renderViewerOn: html [

	html qCard "class: 'bg-secondary text-white';" with: [
		html qCardSection
			with: [ self renderLabelOn: html ].
		self isReadonly ifFalse: [
			html qSeparator dark.
			html qCardActions "vertical" with: [
				self renderAddButtonOn: html.
				self renderAssociateManyButtonOn: html ] ].
		html qScrollArea style: 'height: 200px'; visible; with: [
			self renderListAjaxOn: html ] ]
]
