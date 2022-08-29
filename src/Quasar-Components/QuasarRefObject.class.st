Class {
	#name : #QuasarRefObject,
	#superclass : #QuasarSetupObject,
	#instVars : [
		'refName',
		'refValue',
		'callbackBlock',
		'emitRefresh'
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
QuasarRefObject >> callbackBlock [

	^ callbackBlock
]

{ #category : #accessing }
QuasarRefObject >> callbackBlock: anObject [

	callbackBlock := anObject
]

{ #category : #accessing }
QuasarRefObject >> emitRefresh [

	^ emitRefresh
]

{ #category : #accessing }
QuasarRefObject >> emitRefresh: anObject [

	emitRefresh := anObject
]

{ #category : #accessing }
QuasarRefObject >> emitRefreshOn [

	self emitRefresh: true
]

{ #category : #initialization }
QuasarRefObject >> initialize [

	super initialize.

	self emitRefresh: false
]

{ #category : #initialization }
QuasarRefObject >> makeJSSriptWith: anAjaxFactory [
	"Temporary solution to workaround not passing the html renderer in the API"

	^ (JSScript context: anAjaxFactory renderContext)
		rendererClass: anAjaxFactory rendererClass;
		yourself
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
QuasarRefObject >> refName [

	^ refName
]

{ #category : #accessing }
QuasarRefObject >> refName: anObject [

	refName := anObject
]

{ #category : #accessing }
QuasarRefObject >> refValue [

	^ refValue
]

{ #category : #accessing }
QuasarRefObject >> refValue: anObject [

	self traceIsOn ifTrue: [
		self logString: 'Reactive::', self refName, ': ', refValue greaseString, ' --> ', anObject greaseString ].

	refValue := anObject
]

{ #category : #actions }
QuasarRefObject >> refValueUpdate: anObject [

	self subclassResponsibility
]

{ #category : #actions }
QuasarRefObject >> runCallbackWith: anObject [

	self callbackBlock
		ifNil: [ self refValueUpdate: anObject ]
		ifNotNil: [ :block | block value: anObject ]
]
