Class {
	#name : #QuasarReactiveRefCallback,
	#superclass : #QuasarReactiveObject,
	#instVars : [
		'condition'
	],
	#category : #'Quasar-Components'
}

{ #category : #'rendering - ajax' }
QuasarReactiveRefCallback >> ajaxFunctionOn: aJSStream html: html [
	| ajax code |

	ajax := (html jQuery ajax
			callback: [ :value | self runCallbackWith: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(arg1)');
			json: [ :json | json render: self refValue ];
			yourself).

	code := ''.
	self condition ifNotNil: [
		code := 'if(', condition, ')' ].

	self emitRefresh ifTrue: [
		ajax onSuccess: html javascript refresh ].

	aJSStream
		nextPutAll: self functionName; nextPutAll: '(arg1) {';
		nextPutAll: refName; nextPutAll: '.value = arg1;';
		nextPutAll: code;
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
]

{ #category : #accessing }
QuasarReactiveRefCallback >> condition [

	^ condition
]

{ #category : #accessing }
QuasarReactiveRefCallback >> condition: anObject [

	condition := anObject
]

{ #category : #'rendering - ajax' }
QuasarReactiveRefCallback >> functionName [

	^ self refName, 'RefCallback'
]

{ #category : #'rendering - ajax' }
QuasarReactiveRefCallback >> quasarSetupReturnOn: aJSStream html: html [

	super quasarSetupReturnOn: aJSStream html: html.

	aJSStream nextPut: $,.
	self ajaxFunctionOn: aJSStream html: html
]

{ #category : #actions }
QuasarReactiveRefCallback >> refValueUpdate: anObject [

	self refValue: anObject
]
