Class {
	#name : #QuasarReactiveRefSet,
	#superclass : #QuasarReactiveObject,
	#category : #'Quasar-Components'
}

{ #category : #'rendering - ajax' }
QuasarReactiveRefSet >> ajaxRefSetOn: aJSStream html: html [
	| ajax "script" |

	"script := JSStream new nextPutAll: refName; nextPutAll: '.value = arguments[0]'; yourself.
	self onSuccessScript ifNotNil: [ :value | script nextPut: $;; nextPutAll: value ]."

	ajax := (html jQuery ajax
			callback: [ :value | self runCallbackWith: (STONJSON fromString: value) ]
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
QuasarReactiveRefSet >> emitRefSetFunctionName [

	^ self refName, 'RefSet'
]

{ #category : #'rendering - ajax' }
QuasarReactiveRefSet >> quasarSetupReturnOn: aJSStream html: html [

	super quasarSetupReturnOn: aJSStream html: html.

	aJSStream nextPut: $,.
	self ajaxRefSetOn: aJSStream html: html
]
