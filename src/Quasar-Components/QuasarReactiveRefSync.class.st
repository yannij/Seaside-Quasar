Class {
	#name : #QuasarReactiveRefSync,
	#superclass : #QuasarReactiveObject,
	#instVars : [
		'onSuccessScript',
		'emitOnSuccess'
	],
	#category : #'Quasar-Components'
}

{ #category : #'rendering - ajax' }
QuasarReactiveRefSync >> ajaxFunctionOn: aJSStream html: html [
	"Answer AJAX callback to pass the browser ref value back to the server,
	along with client code to set the browser ref value from the server response"
	| ajax script |

	script := JSStream new nextPutAll: refName; nextPutAll: '.value = arguments[0]'; yourself.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ].

	ajax := html jQuery ajax
			callback: [ :value | self runCallbackWith: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(', refName, '.value)');
			json: [ :json | json render: self refValue ];
			yourself.

	self emitOnSuccess ifTrue: [
		ajax onSuccess: (html javascript << script) ].

	aJSStream
		nextPutAll: self functionName; nextPutAll: '(evt) {';
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
]

{ #category : #accessing }
QuasarReactiveRefSync >> emitOnSuccess [

	^ emitOnSuccess
]

{ #category : #accessing }
QuasarReactiveRefSync >> emitOnSuccess: anObject [

	emitOnSuccess := anObject
]

{ #category : #'rendering - ajax' }
QuasarReactiveRefSync >> functionName [

	^ self refName, 'RefSync'
]

{ #category : #initialization }
QuasarReactiveRefSync >> initialize [

	super initialize.

	self emitOnSuccess: true
]

{ #category : #accessing }
QuasarReactiveRefSync >> onSuccessScript [

	^ onSuccessScript
]

{ #category : #accessing }
QuasarReactiveRefSync >> onSuccessScript: anObject [

	onSuccessScript := anObject
]

{ #category : #'rendering - ajax' }
QuasarReactiveRefSync >> quasarSetupReturnOn: aJSStream html: html [

	super quasarSetupReturnOn: aJSStream html: html.

	aJSStream nextPut: $,.
	self ajaxFunctionOn: aJSStream html: html
]
