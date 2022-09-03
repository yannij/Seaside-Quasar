"
I respresent code to be run during Quasar onMounted lifecycle hook.
"
Class {
	#name : #QuasarOnMounted,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'codeBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarOnMounted >> codeBlock [

	^ codeBlock
]

{ #category : #accessing }
QuasarOnMounted >> codeBlock: anObject [

	codeBlock := anObject
]

{ #category : #'rendering - ajax' }
QuasarOnMounted >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
