Class {
	#name : #MDQListGroup,
	#superclass : #QuasarComponent,
	#instVars : [
		'groupedLists'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
MDQListGroup >> addGroupedList: aList [

	self groupedLists add: aList

]

{ #category : #accessing }
MDQListGroup >> groupedLists [
	^ groupedLists
]

{ #category : #accessing }
MDQListGroup >> groupedLists: anObject [
	groupedLists := anObject
]

{ #category : #initialization }
MDQListGroup >> initialize [

	super initialize.

	self groupedLists: OrderedCollection new.

]

{ #category : #rendering }
MDQListGroup >> renderContentOn: html [

	html div with: [
		self groupedLists do: [ :eachList | html render: eachList ] ]
]
