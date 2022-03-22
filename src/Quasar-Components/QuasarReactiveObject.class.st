Class {
	#name : #QuasarReactiveObject,
	#superclass : #Object,
	#instVars : [
		'refName',
		'refValue',
		'callbackBlock',
		'transformBlock',
		'emitRefresh'
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

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> quasarSetupOn: aJSStream [

	aJSStream
		nextPutAll: 'const ';
		nextPutAll: self refName;
		nextPutAll: ' = ref(';
		nextPutAll: self refValue asJson;
		nextPutAll: ');'
]

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> quasarSetupReturnOn: aJSStream html: html [

	aJSStream nextPutAll: refName
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

	refValue := anObject
]

{ #category : #accessing }
QuasarReactiveObject >> refValueUpdate: anObject [
	| newValue |

	newValue := self transformBlock ifNil: [ anObject ] ifNotNil: [ :block | block value: anObject ].
	self refValue: newValue
]

{ #category : #accessing }
QuasarReactiveObject >> runCallbackWith: anObject [

	"self traceOn"
	true ifTrue: [
		Transcript crShow: 'Reactive::', self refName, ': ', self refValue greaseString, ' --> runCallbackWith: ', anObject greaseString ].

	self callbackBlock
		ifNil: [ self refValueUpdate: anObject ]
		ifNotNil: [ :block | block value: anObject ]
]

{ #category : #accessing }
QuasarReactiveObject >> transformBlock [

	^ transformBlock
]

{ #category : #accessing }
QuasarReactiveObject >> transformBlock: anObject [

	transformBlock := anObject
]
