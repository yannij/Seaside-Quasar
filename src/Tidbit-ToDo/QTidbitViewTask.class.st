Class {
	#name : #QTidbitViewTask,
	#superclass : #QuasarComponent,
	#instVars : [
		'report'
	],
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #accessing }
QTidbitViewTask >> buildReport [

	^ (MDQReport rows: self tasksFiltered description: TidbitToDoItem magritteTemplate magritteDescription)
		refNameCols: self quasarDataColumnName;
		refNameRows: self quasarDataRowName;
		showHeader: true;
		showFooter: true;
		addColumn: (MDQActionColumn new
			commandBlock: (MessageSend receiver: self selector: #navToView:);
			yourself);
		yourself
]

{ #category : #accessing }
QTidbitViewTask >> dataRows [

	^ self tasksFiltered asOrderedCollection collect: [ :eachTask |
		| dataRow |
		dataRow := OrderedCollection new.
		dataRow add: (eachTask done ifTrue: [ [ :html | html span mdcMaterialIcons; with: 'check' ] ] ifFalse: [ '' ]).
		dataRow add: (eachTask summary ifNotNil: [ :value | value ] ifNil: [ '' ]).
		dataRow add: eachTask completeBy.
		dataRow add: eachTask estimatedDuration humanReadablePrintString.
		dataRow add: eachTask importance greaseString.
		dataRow add: eachTask priority greaseString.
		"dataRow add: eachTask colorCode shortPrintString."
		dataRow add: [ :html | html textInput type: 'color'; disabled; value: eachTask colorCode asHTMLColor ].
		dataRow add: (eachTask description ifNotNil: [ :value | value truncateWithElipsisTo: 25 ] ifNil: [ '' ]).
		dataRow ]
]

{ #category : #accessing }
QTidbitViewTask >> denseView [

	^ self mdqApplicationGet denseView
]

{ #category : #rendering }
QTidbitViewTask >> navTo: aModel [

	self mdqApplicationGet navTo: aModel
]

{ #category : #rendering }
QTidbitViewTask >> navToView: aModel [ 
	| view |

	view := (QTidbitViewToDoItem on: aModel).
	self mdqApplicationGet navToCustomView: view 
]

{ #category : #accessing }
QTidbitViewTask >> quasarDataBasename [

	^ 'taskView'
]

{ #category : #accessing }
QTidbitViewTask >> quasarDataColumnName [

	^ self quasarDataBasename, 'Col'
]

{ #category : #accessing }
QTidbitViewTask >> quasarDataRowName [

	^ self quasarDataBasename, 'Row'
]

{ #category : #'rendering - styles' }
QTidbitViewTask >> renderCards: aUser on: html [
	| list selected |

	selected := self sideSheet tabImportanceSelected.
	list := self tasksFiltered select: [ :each | each importance = selected ].

	self renderCardsTabsOn: html.
	html qSeparator.
	html qTabPanel class: 'q-px-none'; with: [
		html div class: 'row'; class: 'q-col-gutter-md'; with: [
			self renderCardsItems: list on: html ] ]
]

{ #category : #'rendering - styles' }
QTidbitViewTask >> renderCardsItems: anItemList on: html [

	anItemList do: [ :eachItem |
		html div class: 'col-3'; with: [
			html qCard with: [
				html qCardSection
					style: 'background: #', eachItem colorCode asHexString;
					with: [ html space ].
				html qCardSection class: 'q-pt-none'; with: [
					html div class: 'text-h6'; with: eachItem summary.
					html div class: 'text-subtitle2'; with: eachItem mdSecondaryString.
					html div class: 'text-body2'; with: eachItem description ].
				html qSeparator.
				html qCardActions vertical; with: [
					html qBtn flat;
						type: 'a'; href: (html urlForAction: [ self navToView: eachItem ]);
						with: 'Open' ] ] ] ]
]

{ #category : #'rendering - styles' }
QTidbitViewTask >> renderCardsTabsOn: html [

	html qTabs
		with: [
			TidbitToDoItem importanceValues withIndexDo: [ :eachValue :index |
				html qTab name: eachValue; label: eachValue;
					onClick: ((html jQuery ajax)
						callback: [ self sideSheet tabImportance: eachValue ];
						onComplete: html javascript refresh).
				"| tagTab |
				(tagTab := html anchor) mdcTab;
					id: html nextId;
					callback: [ self sideSheet tabImportance: eachValue ];
					with: [ html span with: eachValue ]" ] ]
]

{ #category : #'rendering - styles' }
QTidbitViewTask >> renderChips: aUser on: html [
	| iconMap |

	iconMap := Dictionary new
		at: TidbitToDoItem importanceValueHigh put: 'star';
		at: TidbitToDoItem importanceValueMedium put: 'star_half';
		at: TidbitToDoItem importanceValueLow put: 'star_outline';
		yourself.

	html div class: 'q-pa-none';
		with: [
			self tasksFiltered
				do: [ :eachItem |
					html qChip
						clickable;
						onClick: ((html jQuery ajax)
							callback: [ self navToView: eachItem ];
							onComplete: html javascript refresh);
						with: [
							html qAvatar
								fontSize: '1.2rem';
								color: '#', eachItem colorCode asHexString;
								icon: (iconMap at: eachItem importance ifAbsent: [ 'star' ]).
							html text: eachItem mdPrimaryString ] ]
				separatedBy: [ html space ] ]
]

{ #category : #rendering }
QTidbitViewTask >> renderContentOn: html [
	| user heading |

	user := self mdqApplicationGet currentUser.	
	user ifNil: [ ^ self ].

	heading := user mdPrimaryString.
	self sideSheet filterDone ifNotNil: [ :value |
		value = #both ifTrue: [ heading := heading, ' - All tasks' ].
		value = #doneOnly ifTrue: [ heading := heading, ' - Done tasks' ].
		value = #notDoneOnly ifTrue: [ heading := heading, ' - Not done tasks' ] ].

	html span class: 'text-subtitle1'; with: heading.
	"html div class: 'row'; with: [
		html div class: 'col-12'; with: ["
			self renderStyledItemsFor: user on: html "] ]"
]

{ #category : #'rendering - styles' }
QTidbitViewTask >> renderListSingleLine: aUser on: html [

	html qList with: [
		self tasksFiltered do: [ :eachItem |
			html qItem
				qTag: 'a'; href: (html urlForAction: [ self navToView: eachItem ]);
				with: [
					html qItemSection with:
						((eachItem mdPrimaryString , ' - ' , eachItem mdSecondaryString)
							truncateWithElipsisTo: 60) ] ] ]
]

{ #category : #'rendering - styles' }
QTidbitViewTask >> renderListTwoLine: aUser on: html [
	| filteredList listHigh listMedium listLow |

	filteredList := self tasksFiltered.

	listHigh := filteredList select: [ :each | each importanceIsHigh ].
	listMedium := filteredList select: [ :each | each importanceIsMedium ].
	listLow := filteredList select: [ :each | each importanceIsLow ].

	html div with: [
		html div class: 'text-subtitle1'; with: 'High'.
		html qList with: [
			self renderListTwoLineItems: listHigh on: html ] ].

	html div with: [
		html div class: 'text-subtitle1'; with: 'Medium'.
		html qList with: [
			self renderListTwoLineItems: listMedium on: html ] ].

	html div with: [
		html div class: 'text-subtitle1'; with: 'Low'.
		html qList with: [
			self renderListTwoLineItems: listLow on: html ] ]
]

{ #category : #'rendering - styles' }
QTidbitViewTask >> renderListTwoLineItems: anItemList on: html [

	anItemList isEmpty ifTrue: [
		html qItem with: [
			html qItemSection with: [
				html span with: '** NONE **' ] ].
		^ self ].

	anItemList do: [ :eachItem |
		html qItem
			qTag: 'a'; href: (html urlForAction: [ self navToView: eachItem ]);
			with: [
				html qItemSection with: [
					html qItemLabel with:
						eachItem mdPrimaryString.
					html qItemLabel caption; with:
						(eachItem mdSecondaryString truncateWithElipsisTo: 60) ] ] ]
]

{ #category : #rendering }
QTidbitViewTask >> renderStyledItemsFor: user on: html [
	| itemsStyle |

	self mdqApplicationGet
		quasarDataRemove: self quasarDataColumnName;
		quasarDataRemove: self quasarDataRowName.

	itemsStyle := self sideSheet itemsStyle.

	itemsStyle = #listSingleLine ifTrue: [
		^ self renderListSingleLine: user on: html ].

	itemsStyle = #listTwoLine ifTrue: [
		^ self renderListTwoLine: user on: html ].

	itemsStyle = #chips ifTrue: [
		^ self renderChips: user on: html ].

	itemsStyle = #cards ifTrue: [
		^ self renderCards: user on: html ].

	self renderTable: user on: html
]

{ #category : #'rendering - styles' }
QTidbitViewTask >> renderTable: aUser on: html [

	self mdqApplicationGet
		quasarDataAdd: self quasarDataColumnName;
		quasarDataAdd: self quasarDataRowName.
	self report ifNil: [ self report: self buildReport ].
	html render: self report
]

{ #category : #accessing }
QTidbitViewTask >> report [
	^ report
]

{ #category : #accessing }
QTidbitViewTask >> report: anObject [
	report := anObject
]

{ #category : #accessing }
QTidbitViewTask >> sideSheet [

	^ self mdqApplicationGet viewTaskFilter
]

{ #category : #accessing }
QTidbitViewTask >> tasksFiltered [
	| user tasksFilterDone tasksAll |

	user := self mdqApplicationGet currentUser.
	user ifNil: [ ^ #() ].

	tasksAll := user toDoItems.
	tasksFilterDone := self sideSheet filterDone.

	tasksFilterDone = #doneOnly
		ifTrue: [ ^ tasksAll select: [ :eachTask | eachTask done ] ].

	tasksFilterDone = #notDoneOnly
		ifTrue: [ ^ tasksAll reject: [ :eachTask | eachTask done ] ].

	^ tasksAll
]
