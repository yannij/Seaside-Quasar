"
I am an abstract class for objects (i.e. ref's and functions) used to construct content for the Quasar setup() definition.
"
Class {
	#name : #QuasarSetupObject,
	#superclass : #Object,
	#instVars : [
		'traceLevel',
		'refName'
	],
	#category : #'Quasar-Components'
}

{ #category : #'instance creation' }
QuasarSetupObject class >> name: aName [

	^ self new
		refName: aName;
		yourself
]

{ #category : #accessing }
QuasarSetupObject >> beTrace0 [

	self traceLevel: 0
]

{ #category : #accessing }
QuasarSetupObject >> beTrace1 [

	self traceLevel: 2
]

{ #category : #accessing }
QuasarSetupObject >> beTrace2 [

	self traceLevel: 2
]

{ #category : #accessing }
QuasarSetupObject >> beTrace3 [

	self traceLevel: 3
]

{ #category : #accessing }
QuasarSetupObject >> beTrace4 [

	self traceLevel: 4
]

{ #category : #initialization }
QuasarSetupObject >> initialize [

	super initialize.

	traceLevel := 0
]

{ #category : #testing }
QuasarSetupObject >> isWatch [

	^ false
]

{ #category : #logging }
QuasarSetupObject >> logString: aString [

	self crTrace: aString
]

{ #category : #'rendering - ajax' }
QuasarSetupObject >> quasarSetupOn: aJSStream [
	"Add code to Quasar setup().
	Typically const ref definitions.

	Subclasses may override"
]

{ #category : #'rendering - ajax' }
QuasarSetupObject >> quasarSetupReturnList: aList with: anAjaxFactory [
	"Add code to Quasar setup(return()).
	Typically refs and functions that need to be visible.

	Subclasses may override"
]

{ #category : #accessing }
QuasarSetupObject >> refName [

	^ refName
]

{ #category : #accessing }
QuasarSetupObject >> refName: anObject [

	refName := anObject
]

{ #category : #accessing }
QuasarSetupObject >> traceLevel [

	^ traceLevel
]

{ #category : #accessing }
QuasarSetupObject >> traceLevel: anObject [

	traceLevel := anObject
]

{ #category : #accessing }
QuasarSetupObject >> traceOff [

	self beTrace0
]

{ #category : #accessing }
QuasarSetupObject >> traceOn [

	self beTrace2
]

{ #category : #'rendering - ajax' }
QuasarSetupObject >> writeCodeOn: aJSStream with: anAjaxFactory [
	"Add code to Quasar setup().
	Typically function definitions.

	Subclasses may override"
]
