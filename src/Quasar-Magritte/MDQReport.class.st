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

{ #category : #rendering }
MDQReport >> dataColumns [
	
	^ self visibleColumns collect: [ :col |
		Dictionary new
			at: 'name' put: col label;
			at: 'label' put: col label;
			at: 'field' put: col label;
			at: 'sortable' put: (col magritteDescription isSortable ifTrue: [ true ] ifFalse: [ false ]);
			at: 'align' put: col magritteDescription mdqTableAlign;
			"nextPutAll: (i = 1 ifTrue: [ ',align: ''left''' ] ifFalse: [ '' ]);
			nextPutAll: (i = 1 ifTrue: [ ',required: true' ] ifFalse: [ '' ]);
			nextPutAll: (i = 1 ifTrue: [ ',format: val => `${val}`' ] ifFalse: [ '' ]);"
			yourself ]
]

{ #category : #rendering }
MDQReport >> dataRows [
	| reportColumns |

	reportColumns := self visibleColumns.
	^ self visible collect: [ :eachRow | | dict |
		dict := Dictionary new.
		reportColumns do: [ :col | | cellValue cellContent |
			cellValue := col valueFor: eachRow.
			cellContent := col formatter value: cellValue.
			dict at: col label put: cellContent ].
		dict ]
]

{ #category : #initialization }
MDQReport >> initialize [

	super initialize.
	self tableEmpty: '** NONE **'
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
		rowKey: 'name'
]
