"
I represent a utility function defined in the Quasar setup().
"
Class {
	#name : #QuasarCallback,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'codeBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarCallback >> codeBlock [

	^ codeBlock
]

{ #category : #accessing }
QuasarCallback >> codeBlock: anObject [

	codeBlock := anObject
]

{ #category : #accessing }
QuasarCallback >> functionName [

	^ refName
]

{ #category : #'rendering - ajax' }
QuasarCallback >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	aJSStream nextPut: Character cr; nextPutAll: self functionName
]

{ #category : #'rendering - ajax' }
QuasarCallback >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
