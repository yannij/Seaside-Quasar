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
QuasarDemoAccountingObject >> attributeData [

	^ #()
]

{ #category : #printing }
QuasarDemoAccountingObject >> summaryString [

	^ '/' join: (self attributeData collect: [ :each | self perform: each ])
]

{ #category : #accessing }
QuasarDemoAccountingObject >> viewClass [

	self subclassResponsibility
]
