"
I represent a utility function defined in the Quasar setup().
"
Class {
	#name : #QuasarSetupFunction,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'codeBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarSetupFunction >> codeBlock [

	^ codeBlock
]

{ #category : #accessing }
QuasarSetupFunction >> codeBlock: anObject [

	codeBlock := anObject
]

{ #category : #accessing }
QuasarSetupFunction >> functionName [

	^ refName
]

{ #category : #'rendering - ajax' }
QuasarSetupFunction >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	aJSStream nextPut: Character cr; nextPutAll: self functionName
]

{ #category : #'rendering - ajax' }
QuasarSetupFunction >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
