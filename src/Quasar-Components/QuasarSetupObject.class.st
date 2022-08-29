Class {
	#name : #QuasarSetupObject,
	#superclass : #Object,
	#instVars : [
		'traceLevel'
	],
	#category : #'Quasar-Components'
}

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
