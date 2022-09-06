Class {
	#name : #QuasarRefObject,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'refValue',
		'callbackBlock',
		'onErrorServerBlock'
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

{ #category : #'rendering - ajax' }
QuasarRefObject class >> onErrorSettingClear [

	self onErrorSetting: nil
]

{ #category : #'rendering - ajax' }
QuasarRefObject class >> onErrorSettingUseConsole [

	"self onErrorSetting: [ :ref | '(error) => {console.error(error);}' ]"
	self onErrorSetting: [ :ref | '(error) => {console.log(error.name);console.log(error.message);}']
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
QuasarRefObject >> onErrorServerBlock [

	^ onErrorServerBlock
]

{ #category : #accessing }
QuasarRefObject >> onErrorServerBlock: anObject [

	onErrorServerBlock := anObject
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
QuasarRefObject >> refValue1: anObject [

	refValue := anObject
]

{ #category : #accessing }
QuasarRefObject >> refValue: anObject [

	self traceIsOn ifTrue: [
		self logString: 'Reactive::', self refName, ': ', refValue greaseString, ' --> ', anObject greaseString ].

	refValue := anObject
]

{ #category : #actions }
QuasarRefObject >> runCallbackWith: anObject [
	"If callback block is present, then invoke it.
	The callback block is responsible for the ref value update"

	self callbackBlock ifNotNil: [ :block | block value: self value: anObject ]
]
