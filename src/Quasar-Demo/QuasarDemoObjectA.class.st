Class {
	#name : 'QuasarDemoObjectA',
	#superclass : 'Object',
	#instVars : [
		'key',
		'string1',
		'integer1',
		'boolean1'
	],
	#category : 'Quasar-Demo-Basic',
	#package : 'Quasar-Demo',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
QuasarDemoObjectA class >> newRandom [

	^ self new
		boolean1: (10 atRandom odd);
		integer1: 100 atRandom;
		string1: 's', 99999 atRandom printString;
		yourself
]

{ #category : 'accessing' }
QuasarDemoObjectA >> boolean1 [

	^ boolean1
]

{ #category : 'accessing' }
QuasarDemoObjectA >> boolean1: anObject [

	boolean1 := anObject
]

{ #category : 'accessing' }
QuasarDemoObjectA >> integer1 [

	^ integer1
]

{ #category : 'accessing' }
QuasarDemoObjectA >> integer1: anObject [

	integer1 := anObject
]

{ #category : 'printing' }
QuasarDemoObjectA >> jsonOn: aRenderer [

	aRenderer object: [
		aRenderer key: 'boolean1' value: self boolean1.
		aRenderer key: 'integer1' value: self integer1.
		aRenderer key: 'string1' value: self string1 ]
]

{ #category : 'accessing' }
QuasarDemoObjectA >> key [

	^ key
]

{ #category : 'accessing' }
QuasarDemoObjectA >> key: anObject [

	key := anObject
]

{ #category : 'accessing' }
QuasarDemoObjectA >> string1 [

	^ string1
]

{ #category : 'accessing' }
QuasarDemoObjectA >> string1: anObject [

	string1 := anObject
]
