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

	self tabImportance ifNil: [
		self tabImportance: ((QuasarRefSync name: 'tabImportance' value: TidbitToDoItem importanceValueHigh)
				callbackBlock: [ :ref :value | ref refValue: value. ref refValue ];
				onSuccessScript: 'window.location.reload();';
				yourself).
		self mdqApplicationGet reactiveObjectsAdd: self tabImportance ].

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
	| group app |

	self renderFieldLabel: 'Done/Not-done' on: html.

	app := self mdqApplicationGet.
	group := html radioGroup.
	{#both->'Both'. #doneOnly->'Done Only'. #notDoneOnly->'Not Done Only'}
		do: [ :each | | optionId callbackRef |
			(callbackRef := app reactiveObjectsNamed: 'filter', each key) ifNil: [
				callbackRef := (QuasarRefCallback name: 'filter', each key value: nil)
					callbackBlock: [ :ref :ajaxArg | self filterDoneSet: each key ];
					emitRefreshOn;
					yourself.
				app reactiveObjectsAdd: callbackRef ].
			optionId := html nextId.
			html radioButton id: optionId; group: group;
				selected: self filterDone = each key;
				vOnClick: callbackRef functionName, '($event)';
				yourself.
			html label for: optionId; with: each value ]
		separatedBy: [ html break ]
]

{ #category : #rendering }
QTidbitViewTaskSideSheet >> renderItemsStyleRadioButtonsOn: html [
	| group app |

	self renderFieldLabel: 'Items style' on: html.

	app := self mdqApplicationGet.
	group := html radioGroup.
	{#table->'Table'. #listSingleLine->'List single-line'. #listTwoLine->'List two-line'. #chips->'Chips'. #cards->'Cards'}
		do: [ :each | | optionId callbackRef |
			(callbackRef := app reactiveObjectsNamed: 'style', each key) ifNil: [
				callbackRef := (QuasarRefCallback name: 'style', each key value: nil)
					callbackBlock: [ :ref :ajaxArg | self itemsStyle: each key ];
					emitRefreshOn;
					yourself.
				app reactiveObjectsAdd: callbackRef ].
			optionId := html nextId.
			html radioButton id: optionId; group: group;
				selected: self itemsStyle = each key;
				vOnClick: callbackRef functionName, '($event)';
				yourself.
			html label for: optionId; with: each value ]
		separatedBy: [ html break ]
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

	^ self tabImportance refValue
		ifNil: [ TidbitToDoItem importanceValueHigh ]
		ifNotNil: [ :value | value ]
]
