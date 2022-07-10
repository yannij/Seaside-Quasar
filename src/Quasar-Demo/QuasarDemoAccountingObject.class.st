Class {
	#name : #QuasarDemoAccountingObject,
	#superclass : #Object,
	#classInstVars : [
		'instanceList'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #printing }
QuasarDemoAccountingObject class >> attributeData [

	^ #()
]

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
QuasarDemoAccountingObject class >> modelName [

	^ 'abstract'
]

{ #category : #accessing }
QuasarDemoAccountingObject class >> viewClass [

	self subclassResponsibility
]

{ #category : #converting }
QuasarDemoAccountingObject >> asMap [
	| map |

	map := Dictionary new.

	self class attributeData do: [ :each |
		map at: each put: (self perform: each asSymbol) ].

	^ map
]

{ #category : #printing }
QuasarDemoAccountingObject >> attributeData [

	^ self class attributeData
]

{ #category : #printing }
QuasarDemoAccountingObject >> modelName [

	^ self class modelName
]

{ #category : #printing }
QuasarDemoAccountingObject >> summaryString [

	^ self modelName, ': ', ('/' join: (self attributeData collect: [ :each | self perform: each ]))
]

{ #category : #printing }
QuasarDemoAccountingObject >> viewClass [

	^ self class viewClass
]
