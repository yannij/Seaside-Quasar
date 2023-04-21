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
QuasarSetupComputed >> quasarSetupReturnList: aList with: anAjaxFactory [
	| stream |

	stream := WriteStream on: String new.
	stream nextPutAll: self refName; nextPutAll: ': computed(() => '.
	self writeCodeOn: stream with: anAjaxFactory.
	stream nextPut: $).

	aList add: stream contents
]

{ #category : #'rendering - ajax' }
QuasarSetupComputed >> writeCodeOn: aJSStream with: anAjaxFactory [

	self codeBlock ifNotNil: [ :block |
		block value: aJSStream value: anAjaxFactory ]
]
