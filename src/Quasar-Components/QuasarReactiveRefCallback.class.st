Class {
	#name : #QuasarReactiveRefCallback,
	#superclass : #QuasarReactiveObject,
	#category : #'Quasar-Components'
}

{ #category : #'rendering - ajax' }
QuasarReactiveRefCallback >> ajaxFunctionOn: aJSStream html: html [
	| ajax |

	ajax := (html jQuery ajax
			callback: [ :value | self runCallbackWith: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(arg1)');
			json: [ :json | json render: self refValue ];
			yourself).

	self emitRefresh ifTrue: [
		ajax onSuccess: html javascript refresh ].

	aJSStream
		nextPutAll: self functionName; nextPutAll: '(arg1) {';
		nextPutAll: refName; nextPutAll: '.value = arg1;';
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
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
