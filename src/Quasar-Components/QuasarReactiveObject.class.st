Class {
	#name : #QuasarReactiveObject,
	#superclass : #Object,
	#instVars : [
		'refName',
		'refValue',
		'transformBlock',
		'onSuccessScript',
		'emitRefSet',
		'emitRefSync',
		'emitOnSuccess',
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

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> ajaxRefSetOn: aJSStream html: html [
	| ajax "script" |

	"script := JSStream new nextPutAll: refName; nextPutAll: '.value = arguments[0]'; yourself.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ]."

	ajax := (html jQuery ajax
			callback: [ :value | self refValueUpdate: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(arg1)');
			json: [ :json | json render: self refValue ];
			"onSuccess: (html javascript << script);"
			yourself).

	self emitRefresh ifTrue: [
		ajax onSuccess: html javascript refresh ].

	aJSStream
		nextPutAll: refName; nextPutAll: 'RefSet(arg1) {';
		nextPutAll: refName; nextPutAll: '.value = arg1;';
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
]

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> ajaxRefSyncOn: aJSStream html: html [
	"Answer AJAX callback to pass the browser ref value back to the server,
	along with client code to set the browser ref value from the server response"
	| ajax script |

	script := JSStream new nextPutAll: refName; nextPutAll: '.value = arguments[0]'; yourself.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ].

	ajax := html jQuery ajax
			callback: [ :value | self refValueUpdate: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(', refName, '.value)');
			json: [ :json | json render: self refValue ];
			yourself.

	self emitOnSuccess ifTrue: [
		ajax onSuccess: (html javascript << script) ].

	aJSStream
		nextPutAll: self emitRefSyncFunctionName; nextPutAll: '(evt) {';
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
]

{ #category : #accessing }
QuasarReactiveObject >> emitOnSuccess [

	^ emitOnSuccess
]

{ #category : #accessing }
QuasarReactiveObject >> emitOnSuccess: anObject [

	emitOnSuccess := anObject
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefSet [

	^ emitRefSet
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefSet: anObject [

	emitRefSet := anObject
]

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> emitRefSetFunctionName [

	^ self refName, 'RefSet'
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefSetOff [

	self emitRefSet: false
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefSetOn [

	self emitRefSet: true
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefSync [

	^ emitRefSync
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefSync: anObject [

	emitRefSync := anObject
]

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> emitRefSyncFunctionName [

	^ self refName, 'RefSync'
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefSyncOff [

	self emitRefSync: false
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefSyncOn [

	self emitRefSync: true
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefresh [

	^ emitRefresh
]

{ #category : #accessing }
QuasarReactiveObject >> emitRefresh: anObject [

	emitRefresh := anObject
]

{ #category : #initialization }
QuasarReactiveObject >> initialize [

	super initialize.

	self emitRefSync: true.
	self emitRefSet: false.
	self emitOnSuccess: true.
	self emitRefresh: false
]

{ #category : #accessing }
QuasarReactiveObject >> onSuccessScript [

	^ onSuccessScript
]

{ #category : #accessing }
QuasarReactiveObject >> onSuccessScript: anObject [

	onSuccessScript := anObject
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

	aJSStream nextPutAll: refName.

	self emitRefSync ifTrue: [
		aJSStream nextPut: $,.
		self ajaxRefSyncOn: aJSStream html: html ].

	self emitRefSet ifTrue: [
		aJSStream nextPut: $,.
		self ajaxRefSetOn: aJSStream html: html ]
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

	"self traceOn"
	true ifTrue: [
		Transcript crShow: 'Reactive::', self refName, ': ', self refValue greaseString, '-->', anObject greaseString ].

	newValue := self transformBlock ifNil: [ anObject ] ifNotNil: [ :block | block value: anObject ].
	self refValue: newValue
]

{ #category : #accessing }
QuasarReactiveObject >> transformBlock [

	^ transformBlock
]

{ #category : #accessing }
QuasarReactiveObject >> transformBlock: anObject [

	transformBlock := anObject
]
