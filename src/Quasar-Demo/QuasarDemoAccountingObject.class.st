Class {
	#name : #QuasarDemoAccountingObject,
	#superclass : #Object,
	#classInstVars : [
		'instanceList'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #accessing }
QuasarDemoAccountingObject class >> instanceList [

	^ instanceList ifNil: [ instanceList := OrderedCollection new ]
]

{ #category : #accessing }
QuasarDemoAccountingObject class >> instanceList: anObject [

	instanceList := anObject
]

{ #category : #accessing }
QuasarDemoAccountingObject class >> instanceListAdd: anObject [

	self instanceList add: anObject
]

{ #category : #printing }
QuasarDemoAccountingObject >> summaryAttributes [

	^ #()
]

{ #category : #printing }
QuasarDemoAccountingObject >> summaryString [

	^ '/' join: (self summaryAttributes collect: [ :each | self perform: each ])
]
