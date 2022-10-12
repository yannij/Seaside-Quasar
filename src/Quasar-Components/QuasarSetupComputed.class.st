"
I represent computed value code appearing in Quasar setup().
"
Class {
	#name : #QuasarSetupComputed,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'codeBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarSetupComputed >> codeBlock [

	^ codeBlock
]

{ #category : #accessing }
QuasarSetupComputed >> codeBlock: anObject [

	codeBlock := anObject
]

{ #category : #'rendering - ajax' }
QuasarSetupComputed >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	aJSStream nextPut: Character cr; nextPutAll: self refName.
	aJSStream nextPutAll: ': computed(() => '.
	self writeCodeOn: aJSStream with: anAjaxFactory.
	aJSStream nextPutAll: ')'
]

{ #category : #'rendering - ajax' }
QuasarSetupComputed >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
