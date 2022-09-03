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

{ #category : #logging }
QuasarSetupObject >> logString: aString [

	Transcript crShow: aString
]

{ #category : #'rendering - ajax' }
QuasarSetupObject >> quasarSetupOn: aJSStream [
	"Add code to Quasar setup().
	Typically const ref definitions.

	Subclasses may override"
]

{ #category : #'rendering - ajax' }
QuasarSetupObject >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [
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

{ #category : #testing }
QuasarSetupObject >> traceIsOn [

	^ self traceLevel notNil
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
QuasarSetupObject >> traceOn [

	self traceLevel: 1
]

{ #category : #'rendering - ajax' }
QuasarSetupObject >> writeCodeOn: aJSStream with: anAjaxFactory [
	"Add code to Quasar setup().
	Typically function definitions.

	Subclasses may override"
]
