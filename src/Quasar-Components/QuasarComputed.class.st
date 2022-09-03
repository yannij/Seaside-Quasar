"
I represent computed value code appearing in Quasar setup().
"
Class {
	#name : #QuasarComputed,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'codeBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarComputed >> codeBlock [

	^ codeBlock
]

{ #category : #accessing }
QuasarComputed >> codeBlock: anObject [

	codeBlock := anObject
]

{ #category : #'rendering - ajax' }
QuasarComputed >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	aJSStream nextPut: Character cr; nextPutAll: self refName.
	aJSStream nextPutAll: ': computed(() => '.
	self writeCodeOn: aJSStream with: anAjaxFactory.
	aJSStream nextPutAll: ')'
]

{ #category : #'rendering - ajax' }
QuasarComputed >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
