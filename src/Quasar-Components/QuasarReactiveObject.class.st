Class {
	#name : #QuasarReactiveObject,
	#superclass : #Object,
	#instVars : [
		'refName',
		'refValue',
		'callbackBlock',
		'emitRefresh',
		'traceLevel'
	],
	#category : #'Quasar-Components'
}

{ #category : #'instance creation' }
QuasarReactiveObject class >> name: aString value: anObject [

	^ self new
		refName: aString;
		refValue: anObject;
		yourself
]

{ #category : #accessing }
QuasarReactiveObject >> callbackBlock [

	^ callbackBlock
]

{ #category : #accessing }
QuasarReactiveObject >> callbackBlock: anObject [

	callbackBlock := anObject
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefresh [

	^ emitRefresh
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefresh: anObject [

	emitRefresh := anObject
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefreshOn [

	self emitRefresh: true
]

{ #category : #initialization }
QuasarReactiveObject >> initialize [

	super initialize.

	self emitRefresh: false
]

{ #category : #logging }
QuasarReactiveObject >> logString: aString [

	Transcript crShow: aString
]

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> quasarSetupOn: aJSStream [

	aJSStream
		nextPut: Character cr;
		nextPutAll: 'const ';
		nextPutAll: self refName;
		nextPutAll: ' = ref(';
		nextPutAll: self refValue asJson;
		nextPutAll: ');'
]

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> quasarSetupReturnOn: aJSStream html: html [

	aJSStream nextPut: Character cr; nextPutAll: refName
]

{ #category : #accessing }
QuasarReactiveObject >> refName [

	^ refName
]

{ #category : #accessing }
QuasarReactiveObject >> refName: anObject [

	refName := anObject
]

{ #category : #accessing }
QuasarReactiveObject >> refValue [

	^ refValue
]

{ #category : #accessing }
QuasarReactiveObject >> refValue: anObject [

	self traceIsOn ifTrue: [
		self logString: 'Reactive::', self refName, ': ', refValue greaseString, ' --> ', anObject greaseString ].

	refValue := anObject
]

{ #category : #actions }
QuasarReactiveObject >> refValueUpdate: anObject [

	self subclassResponsibility
]

{ #category : #actions }
QuasarReactiveObject >> runCallbackWith: anObject [

	self callbackBlock
		ifNil: [ self refValueUpdate: anObject ]
		ifNotNil: [ :block | block value: anObject ]
]

{ #category : #testing }
QuasarReactiveObject >> traceIsOn [

	^ self traceLevel notNil
]

{ #category : #accessing }
QuasarReactiveObject >> traceLevel [

	^ traceLevel
]

{ #category : #accessing }
QuasarReactiveObject >> traceLevel: anObject [

	traceLevel := anObject
]

{ #category : #accessing }
QuasarReactiveObject >> traceOn [

	self traceLevel: 1
]
