"
I am an abstract class holding common code for ""ref"" objects as utilized in the Quasar/Vue Framework.
"
Class {
	#name : #QuasarRefObject,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'refValue',
		'callbackBlock',
		'onBeforeSend'
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
QuasarRefObject class >> onErrorNotifyJs [

	^ 'jsFetchOnError=(error)=>{$q.notify({position: "top", message: error.name, caption: error.message, closeBtn: true, color: "warning", textColor: "grey-10"})}'
]

{ #category : #accessing }
QuasarRefObject >> callbackBlock [

	^ callbackBlock
]

{ #category : #accessing }
QuasarRefObject >> callbackBlock: anObject [

	callbackBlock := anObject
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

	self callbackBlock ifNotNil: [ :block | block value: self value: anObject ]
]
