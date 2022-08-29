Class {
	#name : #QuasarCallback,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'functionName',
		'codeBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #'instance creation' }
QuasarCallback class >> name: aFunctionName [

	^ self new
		functionName: aFunctionName;
		yourself
]

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

	^ functionName
]

{ #category : #accessing }
QuasarCallback >> functionName: anObject [

	functionName := anObject
]

{ #category : #'rendering - ajax' }
QuasarCallback >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	aJSStream nextPut: Character cr; nextPutAll: self functionName
]

{ #category : #accessing }
QuasarCallback >> refName [

	^ self functionName
]

{ #category : #'rendering - ajax' }
QuasarCallback >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
