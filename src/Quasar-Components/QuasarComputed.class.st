Class {
	#name : #QuasarComputed,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'refName',
		'codeBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #'instance creation' }
QuasarComputed class >> name: aName [

	^ self new
		refName: aName;
		yourself
]

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

{ #category : #accessing }
QuasarComputed >> refName [

	^ refName
]

{ #category : #accessing }
QuasarComputed >> refName: anObject [

	refName := anObject
]

{ #category : #'rendering - ajax' }
QuasarComputed >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
