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

{ #category : #'rendering-table' }
MDQReport >> dropdownIconHtml [

	^ '
<span class="mdc-select__dropdown-icon">
	<svg class="mdc-select__dropdown-icon-graphic" viewBox="7 10 10 5">
		<polygon class="mdc-select__dropdown-icon-inactive"
			stroke="none"
			fill-rule="evenodd"
			points="7 10 12 15 17 10">
		</polygon>
		<polygon class="mdc-select__dropdown-icon-active"
			stroke="none"
			fill-rule="evenodd"
			points="7 15 12 10 17 15">
		</polygon>
	</svg>
</span>'
]

{ #category : #initialization }
MDQReport >> initialize [

	super initialize.
	self tableEmpty: '** NONE **'
]

{ #category : #rendering }
MDQReport >> javascriptColumnsOLD [
	"stream nextPutAll: '
  { name: ''calories'', label: ''Calories'', field: ''calories'', sortable: true, align: ''center'' },
  { name: ''fat'', label: ''Fat (g)'', field: ''fat'', sortable: true },
  { name: ''carbs'', label: ''Carbs (g)'', field: ''carbs'' },
  { name: ''protein'', label: ''Protein (g)'', field: ''protein'' },
  { name: ''sodium'', label: ''Sodium (mg)'', field: ''sodium'' },
  { name: ''calcium'', label: ''Calcium (%)'', field: ''calcium'', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: ''iron'', label: ''Iron (%)'', field: ''iron'', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) }'."
	| data lastIndex |

	data := #(
('name' 'Dessert (100g serving)')
('calories' 'Calories')
('fat' 'Fat (g)')
('carbs' 'Carbs (g)')
('protein' 'Protein (g)')
('sodium' 'Sodium (mg)')
('calcium' 'Calcium (%)')
('iron' 'Iron (%)')
).
	lastIndex := data size.
	
	^ String streamContents: [ :stream |
		stream nextPutAll: 'const columns = ['.
		data withIndexDo: [ :item :i |
			stream
				nextPut: ${;
				nextPutAll: 'name: '''; nextPutAll: item first; nextPut: $';
				nextPut: $,;
				nextPutAll: 'label: '''; nextPutAll: item second; nextPut: $';
				nextPut: $,;
				nextPutAll: 'field: '; nextPutAll: (i = 1 ifTrue: [ 'row => row.name' ] ifFalse: [ '''', item first, '''' ]);
				nextPutAll: (i = 1 ifTrue: [ ',sortable: true' ] ifFalse: [ '' ]);
				nextPutAll: (i = 1 ifTrue: [ ',align: ''left''' ] ifFalse: [ '' ]);
				nextPutAll: (i = 1 ifTrue: [ ',required: true' ] ifFalse: [ '' ]);
				nextPutAll: (i = 1 ifTrue: [ ',format: val => `${val}`' ] ifFalse: [ '' ]);
				nextPut: $}.
			i = lastIndex ifFalse: [ stream nextPut: $, ] ].
		stream nextPut: $] ]
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
MDQReport >> javascriptRowsOLD [

	^ String streamContents: [ :stream |
		stream nextPutAll: 'const rows = ['.
		(OrderedCollection new
			add: {'name'->'QQFrozen Yogurt'. 'calories'->159. 'fat'->6.0. 'carbs'->24. 'protein'->4.0. 'sodium'->87. 'calcium'->'14%'. 'iron'->'1%'};
			yourself)
		do: [ :eachRow |
			stream nextPut: ${.
			eachRow
				do: [ :eachCell | stream nextPutAll: eachCell key; nextPutAll: ': '''; nextPutAll: eachCell value asString; nextPut: $' ]
				separatedBy: [ stream nextPut: $, ].
			stream nextPut: $} ]
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

{ #category : #'rendering-batch' }
MDQReport >> renderBatchFirstOn: html [
	| button |

	button := html button.

	self isOnFirstPage
		ifTrue: [ button disabled ]
		ifFalse: [
			button
				onClick: ((html jQuery ajax)
					callback: [ self batchPage: self defaultBatchPage ];
					onComplete: html javascript refresh) ].

	button
		bePush;
		mdcIconButton;
		mdcMaterialIcons;
		mdcDataTable__paginationButton;
		attributeAt: 'data-first-page' put: 'true';
		with: [
			html div mdcButton__icon; with: 'first_page' ]
]

{ #category : #'rendering-batch' }
MDQReport >> renderBatchItemsOn: html [
	| size itemsStart itemsEnd |

	size := self cache size.
	itemsEnd := self batchPage * self batchSize min: size.
	itemsStart := (self batchPage - 1) * self batchSize + 1.
			
	html div mdcDataTable__paginationTotal;
		with: itemsStart printString, '-', itemsEnd printString, ' of ', size printString.
]

{ #category : #'rendering-batch' }
MDQReport >> renderBatchLastOn: html [
	| button |

	button := html button.

	self isOnLastPage
		ifTrue: [ button disabled ]
		ifFalse: [
			button
				onClick: ((html jQuery ajax)
					callback: [ self batchPage: self batchMaxPages ];
					onComplete: html javascript refresh) ].

	button
		bePush;
		mdcIconButton;
		mdcMaterialIcons;
		mdcDataTable__paginationButton;
		attributeAt: 'data-last-page' put: 'true';
		with: [
			html div mdcButton__icon; with: 'last_page' ]
]

{ #category : #'rendering-batch' }
MDQReport >> renderBatchNextOn: html [
	| button |

	button := html button.

	self isOnLastPage
		ifTrue: [ button disabled ]
		ifFalse: [
			button
				onClick: ((html jQuery ajax)
					callback: [ self nextPage ];
					onComplete: html javascript refresh) ].

	button
		bePush;
		mdcIconButton;
		mdcMaterialIcons;
		mdcDataTable__paginationButton;
		attributeAt: 'data-next-page' put: 'true';
		with: [
			html div mdcButton__icon; with: 'chevron_right' ]
]

{ #category : #'rendering-batch' }
MDQReport >> renderBatchPreviousOn: html [
	| button |

	button := html button.

	self isOnFirstPage
		ifTrue: [ button disabled ]
		ifFalse: [
			button
				onClick: ((html jQuery ajax)
					callback: [ self previousPage ];
					onComplete: html javascript refresh) ].

	button
		bePush;
		mdcIconButton;
		mdcMaterialIcons;
		mdcDataTable__paginationButton;
		attributeAt: 'data-prev-page' put: 'true';
		with: [
			html div mdcButton__icon; with: 'chevron_left' ]
]

{ #category : #rendering }
MDQReport >> renderContentOn: html [

	html qTable
		"title: 'TODO';"
		denseIf: self mdqApplicationGet viewStyleDense;
		columns: self refNameCols;
		rows: self refNameRows;
		rowKey: 'name'.
		"with: [ self renderTableOn: html ]"
	html document addLoadScript: (JSStream on: (self javascriptColumnsWith: self refNameCols)).
	html document addLoadScript: (JSStream on: (self javascriptRowsWith: self refNameRows)).

	"self showFooter ifTrue: [
		self renderTableBatchOn: html ]"
]

{ #category : #'rendering-table' }
MDQReport >> renderRowsPerPageOn: html [

	html div mdcDataTable__paginationRowsPerPage; with: [
		html div mdcDataTable__paginationRowsPerPageLabel with: 'Rows per page'.
		self renderRowsPerPageSelectOn: html ]
]

{ #category : #'rendering-table' }
MDQReport >> renderRowsPerPageSelectOn: html [
	| inputId |

	inputId := html nextId.
	html div mdcSelect; mdcSelect_outlined; mdcSelect_noLabel; mdcDataTable__paginationRowsPerPageSelect; mdcAutoInit: 'MDCSelect'; with: [
		html div mdcSelect__anchor; mdcRole: 'button'; with: [
			html span mdcSelect__selectedTextContainer; with: [
				html span mdcSelect__selectedText with: self batchSize ].
			html html: self dropdownIconHtml.
			html span mdcNotchedOutline; mdcNotchedOutline_notched; with: [
				html span mdcNotchedOutline__leading.
				html span mdcNotchedOutline__trailing ] ].
		html div mdcSelect__menu; mdcMenu; mdcMenuSurface; mdcMenuSurface_fullwidth; mdcRole: 'listbox'; with: [
			html unorderedList mdcDeprecatedList; with: [
				"#(10 25 100)" #(2 5 10 25 50) do: [ :each |
					| listItem |
					listItem := html listItem.
					listItem onClick: ((html jQuery ajax)
						callback: [ self batchSize: each ];
						onComplete: html javascript refresh).
					self batchSize = each ifTrue: [
						listItem mdcListItem_selected ].
					listItem mdcDeprecatedListItem; mdcRole: 'option'; attributeAt: 'data-value' put: each; with: [
						html span mdcDeprecatedListItem__text; with: each ] ] ] ] ]
]

{ #category : #'rendering-table' }
MDQReport >> renderTableBatchOn: html [

	"self hasMoreThanOnePage ifTrue: ["
		html div mdcDataTable__pagination with: [
			html div mdcDataTable__paginationTrailing; with: [
				self renderRowsPerPageOn: html.
				html div mdcDataTable__paginationNavigation; with: [
					self renderBatchItemsOn: html.
					self renderBatchFirstOn: html.
					self renderBatchPreviousOn: html.
					self renderBatchNextOn: html.
					self renderBatchLastOn: html ] ] ] "]"
]

{ #category : #'rendering-table' }
MDQReport >> renderTableBodyOn: html [ 

	self visible isEmpty 
		ifTrue: [ 
			html tableRow mdcDataTable__row; with: [ 
				html tableData
					mdcDataTable__cell;
					colSpan: self visibleColumns size;
					with: self tableEmpty ] ]
		ifFalse: [
			self visible keysAndValuesDo: [ :index :row |
				html tableRow mdcDataTable__row; with: [
					self visibleColumns do: [ :col | 
						col renderCell: row index: index on: html  ] ] ] ]
]

{ #category : #'rendering-table' }
MDQReport >> renderTableHeadOn: html [

	html tableRow "mdcDataTable__headerRow" class: 'mdc-data-table__header-row'; with: [
		self visibleColumns do: [ :each |
			html tableHeading mdcDataTable__headerCell; mdcRole: 'columnHeader'; scope: 'col'; with: each label ] ]
]

{ #category : #rendering }
MDQReport >> renderTableOn: html [

	"self showCaption
		ifTrue: [ self renderTableCaptionOn: html ]."
	"self showSummary
		ifTrue: [ self renderTableSummaryOn: html ]."
	html tableHead: [
		self showHeader
			ifTrue: [ self renderTableHeadOn: html ].
		"self showFilter
			ifTrue: [ self renderTableFilterOn: html ]" ].

	html tableBody mdcDataTable__content; with: [
		self showBody
			ifTrue: [ self renderTableBodyOn: html ] ]
]
