"
I represent a server callback. A condition guard may be specified to avoid the callback. A full page refresh may be specified.
"
Class {
	#name : 'QuasarRefCallback',
	#superclass : 'QuasarRefObject',
	#instVars : [
		'condition',
		'emitRefresh'
	],
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'accessing' }
QuasarRefCallback >> condition [

	^ condition
]

{ #category : 'accessing' }
QuasarRefCallback >> condition: anObject [

	condition := anObject
]

{ #category : 'accessing' }
QuasarRefCallback >> emitRefresh [

	^ emitRefresh
]

{ #category : 'accessing' }
QuasarRefCallback >> emitRefresh: anObject [

	emitRefresh := anObject
]

{ #category : 'accessing' }
QuasarRefCallback >> emitRefreshOn [

	self emitRefresh: true
]

{ #category : 'rendering - ajax' }
QuasarRefCallback >> functionName [

	^ self refName, 'RefCallback'
]

{ #category : 'initialization' }
QuasarRefCallback >> initialize [

	super initialize.

	self callbackBlock: [ :ref :value | ref refValue: value ].
	self emitRefresh: false
]

{ #category : 'rendering - ajax' }
QuasarRefCallback >> quasarSetupReturnList: aList with: anAjaxFactory [

	super quasarSetupReturnList: aList with: anAjaxFactory.

	aList add: self functionName
]

{ #category : 'rendering - ajax' }
QuasarRefCallback >> writeCodeOn: aJSStream with: anAjaxFactory [
	| ajax code |

	ajax := anAjaxFactory jsFetch
				callback: [ :value | self runCallbackWith: value ] json: 'arg1';
				json: [ :json | json render: self refValue ];
				yourself.

	self onBeforeSend ifNotNil: [ :value |
		ajax onBeforeSend: value ].

	code := ''.
	self condition ifNotNil: [
		code := 'if(', condition, ')' ].

	self emitRefresh ifTrue: [
		ajax onSuccess: anAjaxFactory javascript refresh ].

	aJSStream
		nextPutAll: 'async function '; nextPutAll: self functionName; nextPutAll: '(arg1) {';
		nextPutAll: refName; nextPutAll: '.value = arg1;';
		nextPutAll: code;
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
]
