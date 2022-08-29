Class {
	#name : #QuasarOnMounted,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'refName',
		'codeBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #'instance creation' }
QuasarOnMounted class >> name: aName [

	^ self new
		refName: aName;
		yourself
]

{ #category : #accessing }
QuasarOnMounted >> codeBlock [

	^ codeBlock
]

{ #category : #accessing }
QuasarOnMounted >> codeBlock: anObject [

	codeBlock := anObject
]

{ #category : #accessing }
QuasarOnMounted >> refName [

	^ refName
]

{ #category : #accessing }
QuasarOnMounted >> refName: anObject [

	refName := anObject
]

{ #category : #'rendering - ajax' }
QuasarOnMounted >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
