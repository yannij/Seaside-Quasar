Class {
	#name : #QuasarRefCallback,
	#superclass : #QuasarRefObject,
	#instVars : [
		'condition'
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

{ #category : #'rendering - ajax' }
QuasarRefCallback >> functionName [

	^ self refName, 'RefCallback'
]

{ #category : #'rendering - ajax' }
QuasarRefCallback >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	super quasarSetupReturnOn: aJSStream with: anAjaxFactory.

	aJSStream nextPut: $,.
	aJSStream nextPutAll: self functionName
]

{ #category : #actions }
QuasarRefCallback >> refValueUpdate: anObject [

	self refValue: anObject
]

{ #category : #'rendering - ajax' }
QuasarRefCallback >> writeCodeOn: aJSStream with: anAjaxFactory [
	| ajax code |

	ajax := (anAjaxFactory fetch
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
