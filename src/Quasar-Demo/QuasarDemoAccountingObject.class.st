Class {
	#name : 'QuasarDemoAccountingObject',
	#superclass : 'Object',
	#category : 'Quasar-Demo-Accounting',
	#package : 'Quasar-Demo',
	#tag : 'Accounting'
}

{ #category : 'printing' }
QuasarDemoAccountingObject class >> attributeData [

	^ #()
]

{ #category : 'printing' }
QuasarDemoAccountingObject class >> modelName [

	^ 'abstract'
]

{ #category : 'accessing' }
QuasarDemoAccountingObject class >> viewClass [

	self subclassResponsibility
]

{ #category : 'converting' }
QuasarDemoAccountingObject >> asMap [
	| map |

	map := Dictionary new.

	self class attributeData do: [ :each |
		map at: each put: (self perform: each asSymbol) ].

	^ map
]

{ #category : 'printing' }
QuasarDemoAccountingObject >> attributeData [

	^ self class attributeData
]

{ #category : 'printing' }
QuasarDemoAccountingObject >> modelName [

	^ self class modelName
]

{ #category : 'printing' }
QuasarDemoAccountingObject >> summaryString [

	^ self modelName, ': ', ('/' join: (self attributeData collect: [ :each | self perform: each ]))
]

{ #category : 'printing' }
QuasarDemoAccountingObject >> viewClass [

	^ self class viewClass
]
