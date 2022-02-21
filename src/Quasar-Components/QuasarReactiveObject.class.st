Class {
	#name : #QuasarReactiveObject,
	#superclass : #Object,
	#instVars : [
		'refName',
		'refValue',
		'transformBlock'
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
	| ajax |

	ajax := (html jQuery ajax
			callback: [ :value | self refValueUpdate: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(', refName, '.value)');
			json: [ :json | json render: self refValue ];
			onSuccess: (html javascript
				<< (JSStream new nextPutAll: refName; nextPutAll: '.value = arguments[0]'; yourself));
			yourself).

	aJSStream
		nextPutAll: refName;
		nextPut: $,;
		nextPutAll: refName; nextPutAll: 'OnClick() {';
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
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
