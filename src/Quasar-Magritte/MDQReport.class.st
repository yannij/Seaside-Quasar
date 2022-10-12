Class {
	#name : #MDQReport,
	#superclass : #MAReport,
	#category : #'Quasar-Magritte'
}

{ #category : #columns }
MDQReport >> addColumnDescription: aDescription [

	^ self addColumn: (aDescription mdqReportColumnClass new
		magritteDescription: aDescription;
		yourself)
]

{ #category : #initialization }
MDQReport >> initialize [

	super initialize.
	self tableEmpty: '** NONE **'
]

{ #category : #rendering }
MDQReport >> javascriptColumnsWith: aVariableName [
	
	^ String streamContents: [ :stream |
		stream nextPutAll: 'const '; nextPutAll: aVariableName; nextPutAll: ' = ['.
		self visibleColumns do: [ :col |
			stream
				nextPut: ${;
				nextPutAll: 'name: '''; nextPutAll: col label; nextPut: $';
				nextPutAll: ',label: '''; nextPutAll: col label; nextPut: $';
				nextPutAll: ',field: '''; nextPutAll: col label; nextPut: $';
				nextPutAll: (col magritteDescription isSortable ifTrue: [ ',sortable: true' ] ifFalse: [ '' ]);
				nextPutAll: ',align: '''; nextPutAll: col magritteDescription mdqTableAlign; nextPut: $';
				"nextPutAll: (i = 1 ifTrue: [ ',align: ''left''' ] ifFalse: [ '' ]);
				nextPutAll: (i = 1 ifTrue: [ ',required: true' ] ifFalse: [ '' ]);
				nextPutAll: (i = 1 ifTrue: [ ',format: val => `${val}`' ] ifFalse: [ '' ]);"
				nextPut: $} ]
			separatedBy: [ stream nextPut: $, ].
		stream nextPut: $] ]
]

{ #category : #rendering }
MDQReport >> javascriptRowsWith: aVariableName [

	^ String streamContents: [ :stream | | reportColumns |
		stream nextPutAll: 'const '; nextPutAll: aVariableName; nextPutAll: ' = ['.

		reportColumns := self visibleColumns.
		self visible
			do: [ :eachRow |
				stream nextPut: ${.
				reportColumns
					do: [ :col | | cellValue cellContent |
						cellValue := col valueFor: eachRow.
						cellContent := col formatter value: cellValue.
						cellContent := cellContent copyReplaceAll: '''' with: '\'''.
						"cellContent := cellContent copyWithout: $'."
						cellValue isNumber ifFalse: [
							cellContent := cellContent surroundedBySingleQuotes ].
						stream
							nextPut: $'; nextPutAll: col label; nextPut: $';
							nextPut: $:;
							nextPutAll: cellContent ]
					separatedBy: [ stream nextPut: $, ].
				stream nextPut: $} ]
			separatedBy: [ stream nextPut: $, ].

		stream nextPut: $] ]
]

{ #category : #'accessing-settings' }
MDQReport >> refNameCols [

	^ properties at: #refNameCols ifAbsent: [ '' ]
]

{ #category : #'accessing-settings' }
MDQReport >> refNameCols: anObject [

	properties at: #refNameCols put: anObject
]

{ #category : #'accessing-settings' }
MDQReport >> refNameRows [

	^ properties at: #refNameRows ifAbsent: [ '' ]
]

{ #category : #'accessing-settings' }
MDQReport >> refNameRows: anObject [

	properties at: #refNameRows put: anObject
]

{ #category : #rendering }
MDQReport >> renderContentOn: html [

	html qTable
		"title: 'TODO';"
		denseIf: self mdqApplicationGet viewStyleDense;
		columns: self refNameCols;
		rows: self refNameRows;
		vBind: 'pagination' with: '{rowsPerPage: 10}';
		rowKey: 'name'.
		"with: [ self renderTableOn: html ]"

	"MDQReport is broken until usage of addLoadScript: below is fixed.
	The content needs to be added to Quasar setup(), which is no longer part of onLoad()"
	html document addLoadScript: (JSStream on: (self javascriptColumnsWith: self refNameCols)).
	html document addLoadScript: (JSStream on: (self javascriptRowsWith: self refNameRows)).

	"self showFooter ifTrue: [
		self renderTableBatchOn: html ]"
]
