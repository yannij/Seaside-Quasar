Class {
	#name : #QuasarRefWatch,
	#superclass : #QuasarRefObject,
	#instVars : [
		'condition'
	],
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarRefWatch >> condition [

	^ condition
]

{ #category : #accessing }
QuasarRefWatch >> condition: anObject [

	condition := anObject
]

{ #category : #'rendering - ajax' }
QuasarRefWatch >> functionName [

	^ self refName, 'RefWatch'
]

{ #category : #initialization }
QuasarRefWatch >> initialize [

	super initialize.

	self callbackBlock: [ :ref :value | ref refValue: value ].
]

{ #category : #testing }
QuasarRefWatch >> isWatch [

	^ true
]

{ #category : #'rendering - ajax' }
QuasarRefWatch >> quasarSetupReturnOn: aJSStream with: anAjaxFactory [

	super quasarSetupReturnOn: aJSStream with: anAjaxFactory.

	aJSStream nextPut: $,.
	aJSStream nextPutAll: self functionName
]

{ #category : #'rendering - ajax' }
QuasarRefWatch >> writeCodeOn: aJSStream with: anAjaxFactory [
	| ajax code |

	ajax := anAjaxFactory jsFetch
				callback: [ :value | self runCallbackWith: value ] json: refName, '.value';
				json: [ :json | json render: self refValue ];
				yourself.

	self onBeforeSend ifNotNil: [ :value |
		ajax onBeforeSend: value ].

	code := ''.
	self condition ifNotNil: [
		code := 'if(', condition, ')' ].

	aJSStream
		nextPutAll: 'async function '; nextPutAll: self functionName; nextPutAll: '() {';
		"nextPutAll: refName; nextPutAll: '.value = arg1;';"
		nextPutAll: code;
		nextPutAll: ajax asJavascript;
		nextPutAll: '}'.
]

{ #category : #'rendering - ajax' }
QuasarRefWatch >> writeWatchCodeOn: aJSStream [

	aJSStream
		"nextPutAll: 'console.log(""AAA"");';"
		nextPutAll: 'Vue.watchEffect(()=>';
		nextPutAll: self refName;
		nextPutAll: ',(newV,oldV)=>{';
		"nextPutAll: 'console.log(""QQQ"");';"
		nextPutAll: self functionName; nextPutAll: '();';
		"nextPutAll: 'console.log(""WWW"");';"
		nextPutAll: '});';
		"nextPutAll: 'console.log(""BBB"");'"
		yourself
]
