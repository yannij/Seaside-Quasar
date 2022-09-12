Class {
	#name : #QuasarRefSyncClientToServer,
	#superclass : #QuasarRefObject,
	#instVars : [
		'syncType',
		'onSuccessScript',
		'emitOnSuccess'
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

	self useClientArgument.
	self callbackBlock: [ :ref :value | ref refValue: value ].
	self emitOnSuccess: true
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> isSyncTypeClientArgument [

	^ self syncType = #arg
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> isSyncTypeClientRefValue [

	^ self syncType = #refValue
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

{ #category : #accessing }
QuasarRefSyncClientToServer >> syncType [

	^ syncType
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> syncType: anObject [

	syncType := anObject
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> useClientArgument [

	self syncType: #arg
]

{ #category : #accessing }
QuasarRefSyncClientToServer >> useClientRefValue [

	self syncType: #refValue
]

{ #category : #'rendering - ajax' }
QuasarRefSyncClientToServer >> writeCodeOn: aJSStream with: anAjaxFactory [
	| ajax script callbackValue |

	script := JSStream new.
	traceLevel > 1 ifTrue: [
		script
			nextPutAll: 'console.log("Response: '; nextPutAll: refName; nextPutAll: '.value = ...");';
			nextPutAll: 'console.log(data);' ].
	script nextPutAll: refName; nextPutAll: '.value = data;'.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ].
	script nextPutAll: 'return data;'.

	callbackValue := self isSyncTypeClientArgument ifTrue: [ 'arg1' ] ifFalse: [ refName, '.value' ].
	ajax := (self newFetchUsing: anAjaxFactory)
			callback: [ :value | self runCallbackWith: value ] json: callbackValue;
			json: [ :json | json render: self refValue ];
			yourself.

	self emitOnSuccess ifTrue: [
		ajax onSuccess: script contents ].

	aJSStream nextPutAll: 'async function '; nextPutAll: self functionName; nextPutAll: '(arg1) {'.
	traceLevel > 1 ifTrue: [
		aJSStream nextPutAll: 'console.log("Request: ', refName, '(arg1) ..."); console.log(arg1);' ].
	aJSStream nextPutAll: ajax asJavascript; nextPutAll: '}'.
]
