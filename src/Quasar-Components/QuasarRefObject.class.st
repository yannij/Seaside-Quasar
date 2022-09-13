Class {
	#name : #QuasarRefObject,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'refValue',
		'callbackBlock',
		'onBeforeSend'
	],
	#classVars : [
		'OnErrorSetting'
	],
	#category : #'Quasar-Components'
}

{ #category : #'instance creation' }
QuasarRefObject class >> name: aString value: anObject [

	^ self new
		refName: aString;
		refValue: anObject;
		yourself
]

{ #category : #accessing }
QuasarRefObject class >> onErrorSetting [

	^ OnErrorSetting
]

{ #category : #accessing }
QuasarRefObject class >> onErrorSetting: anObject [

	^ OnErrorSetting := anObject
]

{ #category : #accessing }
QuasarRefObject class >> onErrorSettingClear [

	self onErrorSetting: nil
]

{ #category : #accessing }
QuasarRefObject class >> onErrorSettingUseConsole [

	self onErrorSetting: [ :ref |
		'console.log(error.name);console.log(error.message);' asFunction: #('error') ]
]

{ #category : #accessing }
QuasarRefObject class >> onErrorSettingUseNofify [

	self onErrorSetting: [ :ref |
		'$q.notify({position: "top", message: error.toString(), closeBtn: true, timeout: 4000})' asFunction: #('error') ]
]

{ #category : #accessing }
QuasarRefObject >> callbackBlock [

	^ callbackBlock
]

{ #category : #accessing }
QuasarRefObject >> callbackBlock: anObject [

	callbackBlock := anObject
]

{ #category : #'rendering - ajax' }
QuasarRefObject >> newFetchUsing: anAjaxFactory [
	| newFetch |

	newFetch := anAjaxFactory fetch.

	self class onErrorSetting ifNotNil: [ :block |
		newFetch onError: (block value: self) ].

	^ newFetch
]

{ #category : #accessing }
QuasarRefObject >> onBeforeSend [

	^ onBeforeSend
]

{ #category : #accessing }
QuasarRefObject >> onBeforeSend: anObject [

	onBeforeSend := anObject
]

{ #category : #'rendering - ajax' }
QuasarRefObject >> quasarSetupOn: aJSStream [

	aJSStream
		nextPut: Character cr;
		nextPutAll: 'const ';
		nextPutAll: self refName;
		nextPutAll: ' = ref(';
		nextPutAll: self refValue asJson;
		nextPutAll: ');'
]

{ #category : #'rendering - ajax' }
QuasarRefObject >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	aJSStream nextPut: Character cr; nextPutAll: refName
]

{ #category : #accessing }
QuasarRefObject >> refValue [

	^ refValue
]

{ #category : #accessing }
QuasarRefObject >> refValue: anObject [

	traceLevel > 0 ifTrue: [
		self logString: 'Reactive::', self refName, ': ', refValue greaseString, ' --> ', anObject greaseString ].

	refValue := anObject
]

{ #category : #actions }
QuasarRefObject >> runCallbackWith: anObject [
	"If callback block is present, then invoke it.
	The callback block is responsible for the ref value update"

	[ self callbackBlock ifNotNil: [ :block | block value: self value: anObject ] ]
		on: Error
		do: [ :ex | ^ ex printString ]
]
