Class {
	#name : #QTidbitViewTaskSideSheet,
	#superclass : #QuasarComponent,
	#instVars : [
		'user',
		'filterDone',
		'itemsStyle',
		'tabImportance'
	],
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #accessing }
QTidbitViewTaskSideSheet >> filterDone [
	^ filterDone
]

{ #category : #accessing }
QTidbitViewTaskSideSheet >> filterDone: anObject [
	filterDone := anObject
]

{ #category : #accessing }
QTidbitViewTaskSideSheet >> filterDoneSet: anObject [

	self filterDone: anObject.
	self mdqApplicationGet viewTask report: nil
]

{ #category : #initialization }
QTidbitViewTaskSideSheet >> initialize [

	super initialize.

	self filterDone: #both.
	self tabImportance: TidbitToDoItem importanceValueHigh.
	self itemsStyle: #table
]

{ #category : #accessing }
QTidbitViewTaskSideSheet >> itemsStyle [
	^ itemsStyle
]

{ #category : #accessing }
QTidbitViewTaskSideSheet >> itemsStyle: anObject [
	itemsStyle := anObject
]

{ #category : #rendering }
QTidbitViewTaskSideSheet >> renderContentOn: html [

	self renderFieldLabel: 'Tasks Filter' on: html.
	self renderFilterRadioButtonsOn: html.
	self renderItemsStyleRadioButtonsOn: html
]

{ #category : #rendering }
QTidbitViewTaskSideSheet >> renderFieldLabel: aString on: html [

	html "span" heading level6;
		class: 'text-subtitle1';
		style: 'margin: 16px 0 8px';
		style: 'padding: 0 12px';
		with: aString
]

{ #category : #rendering }
QTidbitViewTaskSideSheet >> renderFilterRadioButtonsOn: html [
	| formId group |

	self renderFieldLabel: 'Done/Not-done' on: html.

	formId := html nextId.
	html form id: formId; with: [
	group := html radioGroup.
	{#both->'Both'. #doneOnly->'Done Only'. #notDoneOnly->'Not Done Only'}
		do: [ :each | | optionId |
			optionId := html nextId.
			html radioButton id: optionId; group: group;
				selected: self filterDone = each key;
				callback: [ self filterDoneSet: each key ];
				onChange: (html jQuery ajax script: [ :s | s << (s jQuery id: formId) call: 'submit' ]);
				yourself.
			html label for: optionId; with: each value ]
		separatedBy: [ html break ] ]
]

{ #category : #rendering }
QTidbitViewTaskSideSheet >> renderItemsStyleRadioButtonsOn: html [
	| formId group |

	self renderFieldLabel: 'Items style' on: html.

	formId := html nextId.
	group := html radioGroup.
	html form id: formId; with: [
	{#table->'Table'. #listSingleLine->'List single-line'. #listTwoLine->'List two-line'. #chips->'Chips'. #cards->'Cards'}
		do: [ :each | | optionId |
			optionId := html nextId.
			html radioButton id: optionId; group: group;
				selected: self itemsStyle = each key;
				callback: [ self itemsStyle: each key ];
				onChange: (html jQuery ajax script: [ :s | s << (s jQuery id: formId) call: 'submit' ]);
				yourself.
			html label for: optionId; with: each value ]
		separatedBy: [ html break ] ]
]

{ #category : #accessing }
QTidbitViewTaskSideSheet >> tabImportance [
	^ tabImportance
]

{ #category : #accessing }
QTidbitViewTaskSideSheet >> tabImportance: anObject [
	tabImportance := anObject
]

{ #category : #accessing }
QTidbitViewTaskSideSheet >> tabImportanceSelected [

	^ self tabImportance
		ifNil: [ TidbitToDoItem importanceValueHigh ]
		ifNotNil: [ :value | value ]
]
