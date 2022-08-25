Class {
	#name : #QuasarReactiveSyncToServer,
	#superclass : #QuasarReactiveObject,
	#instVars : [
		'onSuccessScript',
		'emitOnSuccess'
	],
	#category : #'Quasar-Components'
}

{ #category : #'rendering - ajax' }
QuasarReactiveSyncToServer >> ajaxFunctionOn: aJSStream html: html [
	"Answer AJAX callback to pass parameters back to the server
	to recalculate a reactive value"
	| ajax script |

	script := JSStream new nextPutAll: refName; nextPutAll: '.value = arguments[0]'; yourself.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ].

	ajax := html jQuery ajax
			callback: [ :value | self runCallbackWith: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(arg1)');
			json: [ :json | json render: self refValue ];
			yourself.

	self emitOnSuccess ifTrue: [
		ajax onSuccess: (html javascript << script) ].

	aJSStream
		nextPutAll: 'async function '; nextPutAll: self functionName; nextPutAll: '(arg1) {';
		nextPutAll: ajax asJavascript; nextPut: $;;
		nextPutAll: 'return ', self refName, '.value';
		nextPutAll: '}'.
]

{ #category : #accessing }
QuasarReactiveSyncToServer >> emitOnSuccess [

	^ emitOnSuccess
]

{ #category : #accessing }
QuasarReactiveSyncToServer >> emitOnSuccess: anObject [

	emitOnSuccess := anObject
]

{ #category : #'rendering - ajax' }
QuasarReactiveSyncToServer >> functionName [

	^ self refName, 'RefGet'
]

{ #category : #initialization }
QuasarReactiveSyncToServer >> initialize [

	super initialize.

	self emitOnSuccess: true
]

{ #category : #accessing }
QuasarReactiveSyncToServer >> onSuccessScript [

	^ onSuccessScript
]

{ #category : #accessing }
QuasarReactiveSyncToServer >> onSuccessScript: anObject [

	onSuccessScript := anObject
]

{ #category : #'rendering - ajax' }
QuasarReactiveSyncToServer >> quasarSetupReturnOn: aJSStream html: html [

	super quasarSetupReturnOn: aJSStream html: html.

	aJSStream nextPut: $,.
	aJSStream nextPutAll: self functionName
]

{ #category : #actions }
QuasarReactiveSyncToServer >> refValueUpdate: anObject [

	"self refValue: anObject"
]
