Class {
	#name : #QuasarRefSyncClientToServer,
	#superclass : #QuasarRefObject,
	#instVars : [
		'onSuccessScript',
		'emitOnSuccess',
		'transformBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarRefSyncClientToServer >> emitOnSuccess [

	^ emitOnSuccess
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> emitOnSuccess: anObject [

	emitOnSuccess := anObject
]

{ #category : #'rendering - ajax' }
QuasarRefSyncClientToServer >> functionName [

	^ self refName, 'RefSync'
]

{ #category : #initialization }
QuasarRefSyncClientToServer >> initialize [

	super initialize.

	self emitOnSuccess: true
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> onSuccessScript [

	^ onSuccessScript
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> onSuccessScript: anObject [

	onSuccessScript := anObject
]

{ #category : #'rendering - ajax' }
QuasarRefSyncClientToServer >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	super quasarSetupReturnOn: aJSStream with: anAjaxFactory.

	aJSStream nextPut: $,.
	aJSStream nextPutAll: self functionName
]

{ #category : #actions }
QuasarRefSyncClientToServer >> refValueUpdate: anObject [
	| newValue |

	newValue := self transformBlock ifNil: [ anObject ] ifNotNil: [ :block | block value: anObject ].
	self refValue: newValue
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> transformBlock [

	^ transformBlock
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> transformBlock: anObject [

	transformBlock := anObject
]

{ #category : #'rendering - ajax' }
QuasarRefSyncClientToServer >> writeCodeOn: aJSStream with: anAjaxFactory [
	"Answer AJAX callback to pass the browser ref value back to the server,
	along with client code to set the browser ref value from the server response"
	| ajax script |

	script := JSStream new nextPutAll: refName; nextPutAll: '.value = data'; yourself.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ].

	ajax := anAjaxFactory fetch
			callback: [ :value | self runCallbackWith: (WAJsonParser parse: value) ]
				value: (JSStream on: 'JSON.stringify(', refName, '.value)');
			json: [ :json | json render: self refValue ];
			yourself.

	self emitOnSuccess ifTrue: [
		ajax onSuccess: anAjaxFactory javascript << script ].

	aJSStream
		nextPutAll: 'async function '; nextPutAll: self functionName; nextPutAll: '(evt) {';
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
]
