Class {
	#name : #QuasarRefSyncClientToServer,
	#superclass : #QuasarRefObject,
	#instVars : [
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

	self callbackBlock: [ :ref :value | ref refValue: value ].
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

{ #category : #'rendering - ajax' }
QuasarRefSyncClientToServer >> writeCodeOn: aJSStream with: anAjaxFactory [
	| ajax script |

	script := JSStream new nextPutAll: refName; nextPutAll: '.value = data;'; yourself.
	false ifTrue: [
		script
			nextPutAll: 'console.log('''; nextPutAll: refName; nextPutAll: ' is: '');';
			nextPutAll: 'console.log(data);' ].
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ].
	script nextPutAll: 'return data;'.

	ajax := (self newFetchUsing: anAjaxFactory)
			callback: [ :value | self runCallbackWith: (WAJsonParser parse: value) ]
				"**** diff is below ***"
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
