Class {
	#name : #MDQList,
	#superclass : #QuasarComponent,
	#instVars : [
		'items',
		'subheader'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
MDQList >> do: aBlock [

	self items do: aBlock
]

{ #category : #initialization }
MDQList >> initialize [

	super initialize.

	self items: OrderedCollection new
]

{ #category : #accessing }
MDQList >> items [

	^ items
]

{ #category : #accessing }
MDQList >> items: anObject [

	items := anObject
]

{ #category : #accessing }
MDQList >> itemsAdd: aTab [

	self items add: aTab
]

{ #category : #accessing }
MDQList >> itemsAddAll: aCollection [

	aCollection do: [ :eachItem | self itemsAdd: eachItem ]
]

{ #category : #rendering }
MDQList >> renderContentOn: html [

	self renderListOn: html
]

{ #category : #rendering }
MDQList >> renderListOn: html [

	self subheader notNil ifTrue: [
		html div class: 'text-subtitle1'; with: self subheader ].

	html qList with: [
		self items do: [ :eachItem | html render: eachItem ] ]
]

{ #category : #accessing }
MDQList >> subheader [

	^ subheader
]

{ #category : #accessing }
MDQList >> subheader: anObject [

	subheader := anObject
]
