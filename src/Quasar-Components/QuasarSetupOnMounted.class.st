"
I respresent code to be run during Quasar onMounted lifecycle hook.
"
Class {
	#name : 'QuasarSetupOnMounted',
	#superclass : 'QuasarSetupObject',
	#instVars : [
		'codeBlock'
	],
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'accessing' }
QuasarSetupOnMounted >> codeBlock [

	^ codeBlock
]

{ #category : 'accessing' }
QuasarSetupOnMounted >> codeBlock: anObject [

	codeBlock := anObject
]

{ #category : 'rendering - ajax' }
QuasarSetupOnMounted >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
