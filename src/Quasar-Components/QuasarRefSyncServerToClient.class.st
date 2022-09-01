Class {
	#name : #QuasarRefSyncServerToClient,
	#superclass : #QuasarRefObject,
	#instVars : [
		'onSuccessScript',
		'emitOnSuccess'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarRefSyncServerToClient >> emitOnSuccess [

	^ emitOnSuccess
]

{ #category : #accessing }
QuasarRefSyncServerToClient >> emitOnSuccess: anObject [

	emitOnSuccess := anObject
]

{ #category : #'rendering - ajax' }
QuasarRefSyncServerToClient >> functionName [

	^ self refName, 'RefGet'
]

{ #category : #initialization }
QuasarRefSyncServerToClient >> initialize [

	super initialize.

	self emitOnSuccess: true
]

{ #category : #accessing }
QuasarRefSyncServerToClient >> onSuccessScript [

	^ onSuccessScript
]

{ #category : #accessing }
QuasarRefSyncServerToClient >> onSuccessScript: anObject [

	onSuccessScript := anObject
]

{ #category : #'rendering - ajax' }
QuasarRefSyncServerToClient >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	super quasarSetupReturnOn: aJSStream with: anAjaxFactory.

	aJSStream nextPut: $,.
	aJSStream nextPutAll: self functionName
]

{ #category : #actions }
QuasarRefSyncServerToClient >> refValueUpdate: anObject [

	"self refValue: anObject"
]

{ #category : #'rendering - ajax' }
QuasarRefSyncServerToClient >> writeCodeOn: aJSStream with: anAjaxFactory [
	"Answer AJAX callback to pass parameters back to the server
	to recalculate a reactive value"
	| ajax script |

	script := JSStream new nextPutAll: refName; nextPutAll: '.value = data'; yourself.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ].

	ajax := anAjaxFactory fetch
			callback: [ :value | self runCallbackWith: (WAJsonParser parse: value) ]
				value: (JSStream on: 'JSON.stringify(arg1)');
			json: [ :json | json render: self refValue ];
			yourself.

	self emitOnSuccess ifTrue: [
		ajax onSuccess: anAjaxFactory javascript << script ].

	aJSStream
		nextPutAll: 'async function '; nextPutAll: self functionName; nextPutAll: '(arg1) {';
		nextPutAll: ajax asJavascript; nextPut: $;;
		nextPutAll: 'return ', self refName, '.value';
		nextPutAll: '}'.
]
