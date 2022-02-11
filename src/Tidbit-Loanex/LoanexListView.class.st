Class {
	#name : #LoanexListView,
	#superclass : #WAComponent,
	#instVars : [
		'filterView'
	],
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #accessing }
LoanexListView >> filterView [

	^ filterView
]

{ #category : #accessing }
LoanexListView >> filterView: anObject [

	filterView := anObject
]

{ #category : #rendering }
LoanexListView >> modelClass [

	self subclassResponsibility
]

{ #category : #rendering }
LoanexListView >> renderAsCard: aModel with: params on: html [

	html qCard with: [
		html qCardSection class: 'q-pt-none'; with: [
			params first ifNotNil: [ :value |
				html div class: 'text-h6'; with: value ].
			params size >= 3 ifTrue: [
				params third ifNotNil: [ :value |
					html div class: 'text-subtitle2'; with: value ] ].
			params second ifNotNil: [ :value |
				html div class: 'text-body2'; with: value ] ].
		html qSeparator.
		html qCardActions vertical; with: [
			html qBtn flat;
				type: 'a'; href: (html urlForAction: [ self mdqApplicationGet navTo: aModel ]);
				with: 'Open' ] ]
]

{ #category : #rendering }
LoanexListView >> renderAsCards: aList on: html [

	html div class: 'row q-col-gutter-md'; with: [
		aList do: [ :eachInstance |
			html div class: 'col-2'; with: [
				self renderAsCard: eachInstance with: eachInstance cardParameters on: html ] ] ]
]

{ #category : #rendering }
LoanexListView >> renderAsList: aList on: html [

	html qList with: [
		aList do: [ :eachInstance |
			self renderAsListItem: eachInstance on: html ] ]
]

{ #category : #rendering }
LoanexListView >> renderAsListItem: aModel on: html [

	self
		renderAsListItem: aModel
		with: aModel listItemParameters
		on: html
]

{ #category : #rendering }
LoanexListView >> renderAsListItem: aModel with: params on: html [

	html qItem
		qTag: 'a'; href: (html urlForAction: [ self mdqApplicationGet navTo: aModel ]);
		with: [
			html qItemSection noWrap with: [
				html qItemLabel with: params first .
				html qItemLabel caption; with: params second ].
			params size >= 3 ifTrue: [
				html qItemSection side; with: [
				html span "class: 'text-h4';" with: params third ] ].
			params size >= 4 ifTrue: [
				html qItemSection avatar; with: [
					html qIcon name: params fourth ] ] ]
]

{ #category : #rendering }
LoanexListView >> renderContentOn: html [

	self renderInstancesOn: html
]

{ #category : #rendering }
LoanexListView >> renderInstancesOn: html [

	self subclassResponsibility
]

{ #category : #rendering }
LoanexListView >> renderTitle: aString on: html [

	html span class: 'text-h6'; with: aString
]
