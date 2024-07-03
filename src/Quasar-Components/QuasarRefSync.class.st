Class {
	#name : 'QuasarRefSync',
	#superclass : 'QuasarRefObject',
	#instVars : [
		'syncType',
		'onSuccessScript',
		'emitOnSuccess'
	],
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'accessing' }
QuasarRefSync >> emitOnSuccess [

	^ emitOnSuccess
]

{ #category : 'accessing' }
QuasarRefSync >> emitOnSuccess: anObject [

	emitOnSuccess := anObject
]

{ #category : 'rendering - ajax' }
QuasarRefSync >> functionName [

	^ self refName, 'RefSync'
]

{ #category : 'initialization' }
QuasarRefSync >> initialize [

	super initialize.

	self useClientArgument.
	self callbackBlock: [ :ref :value | ref refValue: value ].
	self emitOnSuccess: true
]

{ #category : 'accessing' }
QuasarRefSync >> isSyncTypeClientArgument [

	^ self syncType = #arg
]

{ #category : 'accessing' }
QuasarRefSync >> isSyncTypeClientRefValue [

	^ self syncType = #refValue
]

{ #category : 'accessing' }
QuasarRefSync >> onSuccessScript [

	^ onSuccessScript
]

{ #category : 'accessing' }
QuasarRefSync >> onSuccessScript: anObject [

	onSuccessScript := anObject
]

{ #category : 'rendering - ajax' }
QuasarRefSync >> quasarSetupReturnList: aList with: anAjaxFactory [

	super quasarSetupReturnList: aList with: anAjaxFactory.

	aList add: self functionName
]

{ #category : 'accessing' }
QuasarRefSync >> syncType [

	^ syncType
]

{ #category : 'accessing' }
QuasarRefSync >> syncType: anObject [

	syncType := anObject
]

{ #category : 'accessing' }
QuasarRefSync >> useClientArgument [

	self syncType: #arg
]

{ #category : 'accessing' }
QuasarRefSync >> useClientRefValue [

	self syncType: #refValue
]

{ #category : 'rendering - ajax' }
QuasarRefSync >> writeCodeOn: aJSStream with: anAjaxFactory [
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
	ajax := anAjaxFactory jsFetch
			callback: [ :value | self runCallbackWith: value ] json: callbackValue;
			json: [ :json | json render: self refValue ];
			yourself.

	self onBeforeSend ifNotNil: [ :value |
		ajax onBeforeSend: value ].

	self emitOnSuccess ifTrue: [
		ajax onSuccess: script contents ].

	aJSStream nextPutAll: 'async function '; nextPutAll: self functionName; nextPutAll: '(arg1) {'.
	traceLevel > 1 ifTrue: [
		aJSStream nextPutAll: 'console.log("Request: ', refName, '(arg1) ..."); console.log(arg1);' ].
	aJSStream nextPutAll: ajax asJavascript; nextPutAll: '}'.
]
