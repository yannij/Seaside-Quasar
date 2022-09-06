"
I represent a server callback. A condition guard may be specified to avoid the callback. A full page refresh may be specified.
"
Class {
	#name : #QuasarRefCallback,
	#superclass : #QuasarRefObject,
	#instVars : [
		'condition',
		'emitRefresh'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarRefCallback >> condition [

	^ condition
]

{ #category : #accessing }
QuasarRefCallback >> condition: anObject [

	condition := anObject
]

{ #category : #accessing }
QuasarRefCallback >> emitRefresh [

	^ emitRefresh
]

{ #category : #accessing }
QuasarRefCallback >> emitRefresh: anObject [

	emitRefresh := anObject
]

{ #category : #accessing }
QuasarRefCallback >> emitRefreshOn [

	self emitRefresh: true
]

{ #category : #'rendering - ajax' }
QuasarRefCallback >> functionName [

	^ self refName, 'RefCallback'
]

{ #category : #initialization }
QuasarRefCallback >> initialize [

	super initialize.

	self callbackBlock: [ :ref :value | ref refValue: value ].
	self emitRefresh: false
]

{ #category : #'rendering - ajax' }
QuasarRefCallback >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	super quasarSetupReturnOn: aJSStream with: anAjaxFactory.

	aJSStream nextPut: $,.
	aJSStream nextPutAll: self functionName
]

{ #category : #'rendering - ajax' }
QuasarRefCallback >> writeCodeOn: aJSStream with: anAjaxFactory [
	| ajax code |

	ajax := ((self newFetchUsing: anAjaxFactory)
			callback: [ :value | self runCallbackWith: (WAJsonParser parse: value) ]
				value: (JSStream on: 'JSON.stringify(arg1)');
			json: [ :json | json render: self refValue ];
			yourself).

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
