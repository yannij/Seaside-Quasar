Class {
	#name : #QTidbitViewUsers,
	#superclass : #QuasarComponent,
	#instVars : [
		'report'
	],
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #rendering }
QTidbitViewUsers >> buildReport [

	^ (MDQReport rows: self users description: TidbitUser magritteTemplate magritteDescription)
		refNameCols: self quasarDataColumnName;
		refNameRows: self quasarDataRowName;
		showHeader: true;
		showFooter: true;
		addColumn: (MDQActionColumn new
			commandBlock: (MessageSend receiver: self selector: #navTo:);
			yourself);
		yourself
]

{ #category : #rendering }
QTidbitViewUsers >> navTo: aModel [

	self mdqApplicationGet navTo: aModel
]

{ #category : #accessing }
QTidbitViewUsers >> quasarDataBasename [

	^ 'userView'
]

{ #category : #accessing }
QTidbitViewUsers >> quasarDataColumnName [

	^ self quasarDataBasename, 'Col'
]

{ #category : #accessing }
QTidbitViewUsers >> quasarDataRowName [

	^ self quasarDataBasename, 'Row'
]

{ #category : #rendering }
QTidbitViewUsers >> renderContentOn: html [

	self renderTableOn: html
]

{ #category : #rendering }
QTidbitViewUsers >> renderTableOn: html [

	html span class: 'text-subtitle1'; with: 'Users'.

	self mdqApplicationGet
		quasarDataAdd: self quasarDataColumnName;
		quasarDataAdd: self quasarDataRowName.
	self report ifNil: [ self report: self buildReport ].
	html render: self report
]

{ #category : #accessing }
QTidbitViewUsers >> report [
	^ report
]

{ #category : #accessing }
QTidbitViewUsers >> report: anObject [
	report := anObject
]

{ #category : #rendering }
QTidbitViewUsers >> users [

	^ self mdqApplicationGet repository selectAll: TidbitUser
]
