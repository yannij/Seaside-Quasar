Class {
	#name : #QuasarReactiveObject,
	#superclass : #Object,
	#instVars : [
		'refName',
		'refValue',
		'transformBlock',
		'onSuccessScript'
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
QuasarReactiveObject >> onSuccessScript [

	^ onSuccessScript
]

{ #category : #accessing }
QuasarReactiveObject >> onSuccessScript: anObject [

	onSuccessScript := anObject
]

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> quasarAjaxOnClickOn: aJSStream html: html [
	| ajax script |

	script := JSStream new nextPutAll: refName; nextPutAll: '.value = arguments[0]'; yourself.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ].

	ajax := (html jQuery ajax
			callback: [ :value | self refValueUpdate: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(', refName, '.value)');
			json: [ :json | json render: self refValue ];
			onSuccess: (html javascript << script);
			yourself).

	aJSStream
		nextPutAll: refName; nextPutAll: 'OnClick(evt) {';
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
]

{ #category : #'rendering - ajax' }
QuasarReactiveObject >> quasarAjaxRefSetOn: aJSStream html: html [
	| ajax "script" |

	"script := JSStream new nextPutAll: refName; nextPutAll: '.value = arguments[0]'; yourself.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ]."

	ajax := (html jQuery ajax
			callback: [ :value | self refValueUpdate: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(arg1)');
			json: [ :json | json render: self refValue ];
			"onSuccess: (html javascript << script);"
			yourself).

	aJSStream
		nextPutAll: refName; nextPutAll: 'RefSet(arg1) {';
		nextPutAll: refName; nextPutAll: '.value = arg1;';
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
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
	aJSStream nextPut: $,.
	self quasarAjaxOnClickOn: aJSStream html: html.
	aJSStream nextPut: $,.
	self quasarAjaxRefSetOn: aJSStream html: html
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
QuasarReactiveObject >> transformBlock [

	^ transformBlock
]

{ #category : #accessing }
QuasarReactiveObject >> transformBlock: anObject [

	transformBlock := anObject
]
