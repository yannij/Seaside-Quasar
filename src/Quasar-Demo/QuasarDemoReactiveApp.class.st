Class {
	#name : #QuasarDemoReactiveApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'demoName',
		'demoObjectA',
		'experiment4',
		'reactiveList'
	],
	#category : #'Quasar-Demo-Basic'
}

{ #category : #initialization }
QuasarDemoReactiveApp class >> applicationPath [

	^ 'quasar/reactive-demo'
]

{ #category : #initialization }
QuasarDemoReactiveApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> ajax2: json html: html [

	json render: (OrderedCollection new
		add: {'key' -> 1. 'value' -> Date today printString} asDictionary;
		add: {'key' -> 2. 'value' -> Time now printString} asDictionary;
		yourself)
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> ajax3: json html: html [
	| objectDictionary |

	self demoObjectA string1: DateAndTime now printString.
	self demoObjectA integer1: Time now asSeconds.
	self demoObjectA boolean1: false.
	objectDictionary := Dictionary new
		at: 'string1' put: self demoObjectA string1;
		at: 'integer1' put: self demoObjectA integer1;
		at: 'boolean1' put: self demoObjectA boolean1;
		yourself.
	json render: objectDictionary
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> ajax4: json html: html [

	json render: self experiment4
]

{ #category : #accessing }
QuasarDemoReactiveApp >> applicationTitle [

	^ 'Reactive Demo'
]

{ #category : #accessing }
QuasarDemoReactiveApp >> demoName [

	^ demoName
]

{ #category : #accessing }
QuasarDemoReactiveApp >> demoName: anObject [

	demoName := anObject
]

{ #category : #accessing }
QuasarDemoReactiveApp >> demoNames [

	^ #(
	Ajax
	Reactive
	)
]

{ #category : #accessing }
QuasarDemoReactiveApp >> demoObjectA [

	^ demoObjectA ifNil: [ demoObjectA := QuasarDemoObjectA new ]
]

{ #category : #accessing }
QuasarDemoReactiveApp >> demoObjectA: anObject [

	demoObjectA := anObject
]

{ #category : #accessing }
QuasarDemoReactiveApp >> experiment4 [

	^ experiment4
]

{ #category : #accessing }
QuasarDemoReactiveApp >> experiment4: anObject [

	experiment4 := anObject
]

{ #category : #initialize }
QuasarDemoReactiveApp >> initialize [

	super initialize.

	self reactiveList: (OrderedCollection new
		add: ((QuasarReactiveObject name: 'reactive1' value: true) transformBlock: [ :value | value not ]; yourself);
		add: ((QuasarReactiveObject name: 'reactive2' value: 0) transformBlock: [ :value | value + 1 ]; yourself);
		add: ((QuasarReactiveObject name: 'reactive3' value: 1.2) transformBlock: [ :value | value + 1 ]; yourself);
		add: ((QuasarReactiveObject name: 'reactive4' value: 'abc') transformBlock: [ :value | value, value ]; yourself);
		add: ((QuasarReactiveObject name: 'reactive5' value: DateAndTime now) transformBlock: [ :value | DateAndTime now ]; yourself);
		add: ((QuasarReactiveObject name: 'reactive6' value: {true. 123. 3.456. 'abc'. DateAndTime now})
			transformBlock: [ :value | value, value ]; yourself);
		add: ((QuasarReactiveObject name: 'reactive7' value: {'k1'->'v1'. 'k2'->'v2'. 'k3'->'v3'} asDictionary)
			transformBlock: [ :value | value at: 100 atRandom printString put: 1000 atRandom; yourself ]; yourself);
		yourself).
]

{ #category : #rendering }
QuasarDemoReactiveApp >> quasarSetupContentOn: aJSStream with: html [

	self vueSetupReactiveObjectsOn: aJSStream.
	self vueSetupDemoExperimentOn: aJSStream
]

{ #category : #rendering }
QuasarDemoReactiveApp >> quasarSetupReturnContentOn: aJSStream with: html [

	self reactiveObjects ifNotEmpty: [
		self vueSetupReturnReactiveObjectsOn: aJSStream html: html.
		aJSStream nextPut: $, ].

	self vueSetupReturnDemoExperimentOn: aJSStream html: html
]

{ #category : #accessing }
QuasarDemoReactiveApp >> reactiveList [

	^ reactiveList
]

{ #category : #accessing }
QuasarDemoReactiveApp >> reactiveList: anObject [

	reactiveList := anObject
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> renderDemoAjaxOn: html [

	html div with: [
		html qBtn label: 'experiment-1'; vOnClick: 'onClickExperiment1($event)' ].

	html qSeparator spaced.
	html div class: 'q-pa-sm'; with: [
		html div with: 'experiment2: {{ experiment2 }}'.
		html qChip vFor: 'ex in experiment2'; vBind: 'key' with: 'ex.key'; with: '{{ ex.value }}' ].

	html div with: [
		html qBtn label: 'experiment-2'; vOnClick: 'onClickExperiment2()' ].

	html qSeparator spaced.
	html div class: 'q-pa-sm'; with: [
		html div with: 'experiment3: {{ experiment3 }}' ].
	html div with: [
		html qBtn label: 'experiment-3'; vOnClick: 'onClickExperiment3()' ].

	html qSeparator spaced.
	html div class: 'q-pa-sm'; with: [
		html div with: 'experiment4: {{ experiment4 }}'.
		html qInput outlined; style: 'width: 300px'; label: 'experiment4'; vModel: 'experiment4'.
		html qInput outlined; style: 'width: 300px'; label: 'experiment4a'; vModel: 'experiment4a'; readonly ].
	html div with: [
		html qBtn label: 'experiment-4'; vOnClick: 'onClickExperiment4()' ].
]

{ #category : #'demo - reactive' }
QuasarDemoReactiveApp >> renderDemoReactiveOn: html [

	self reactiveList do: [ :eachObject | self mdqApplicationGet reactiveObjectsAdd: eachObject ].

	self reactiveList
		do: [ :eachObject | | refName |
			refName := eachObject refName.
			html div class: 'q-pa-sm'; with: [
				html div with: refName, ': {{ ', refName, ' }}' ].
			html div with: [
				html qBtn label: refName; vOnClick: refName, 'OnClick()' ] ]
		separatedBy: [ html qSeparator spaced ]
]

{ #category : #rendering }
QuasarDemoReactiveApp >> renderLayoutOn: html [

	html html: '<style>
.my-card {
	width: 100%;
	max-width: 250px;
}
</style>'.

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; with: [
			html qHeader with: [
				html qToolbar with: [
					html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'.
					html qToolbarTitle with: [ html text: self applicationTitle ] ] ].
			self renderLeftDrawerOn: html.
			self renderLayoutPageOn: html ] ]
]

{ #category : #rendering }
QuasarDemoReactiveApp >> renderLayoutPageOn: html [
	| demoSelector |

	self demoName ifNil: [ ^ self ].

	demoSelector := ('renderDemo', self demoName asString, 'On:') asSymbol.
	html qPageContainer with: [
		html qPage with: [
			html div class: 'q-pa-md'; with: [
				(self respondsTo: demoSelector)
					ifTrue: [ self perform: demoSelector with: html ]
					ifFalse: [ html text: 'Missing demo: ', demoSelector asString ] ] ] ]
]

{ #category : #rendering }
QuasarDemoReactiveApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; persistent; side: 'left';
		class: 'bg-primary'; style: 'color: white';
		with: [
			html qScrollArea class: 'fit'; with: [
				"self renderNavBrandingOn: html."
				self renderNavOn: html ] ]
]

{ #category : #rendering }
QuasarDemoReactiveApp >> renderNavOn: html [

	html qList with: [
		self demoNames do: [ :eachItem |
			html qItem
				qTag: 'a'; href: (html urlForAction: [ self demoName: eachItem ]);
				with: [
					html qItemSection with: eachItem ] ] ]
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupDemoExperimentOn: aJSStream [

	aJSStream
		nextPutAll: 'const experiment2 = ref([{key: 1, value: ''original value''}]);';
		nextPutAll: 'const experiment3 = ref(null);';
		nextPutAll: 'const experiment4 = ref(null); const experiment4a = ref(null);'
]

{ #category : #'demo - reactive' }
QuasarDemoReactiveApp >> vueSetupReactiveObjectsOn: aJSStream [

	self reactiveObjects do: [ :eachReactiveObject |
		aJSStream
			nextPutAll: 'const ';
			nextPutAll: eachReactiveObject refName;
			nextPutAll: ' = ref(';
			nextPutAll: eachReactiveObject refValue asJson;
			nextPutAll: ');';
			yourself ]
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperiment1On: aJSStream html: html [

	aJSStream
		nextPutAll: 'onClickExperiment1(evt) {alert("hello");}'
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperiment2On: aJSStream html: html [
	| ajax |

	ajax := (html jQuery getJson
			json: [ :json | self ajax2: json html: html ];
			onSuccess: (html javascript << (JSStream new nextPutAll: 'experiment2.value = arguments[0]'; yourself));
			yourself).

	aJSStream
		nextPutAll: 'experiment2';
		nextPutAll: ',onClickExperiment2() {'; nextPutAll: ajax asJavascript; nextPutAll: '}'.
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperiment3On: aJSStream html: html [
	| ajax |

	ajax := (html jQuery getJson
			json: [ :json | self ajax3: json html: html ];
			onSuccess: (html javascript
				<< (JSStream new nextPutAll: 'experiment3.value = arguments[0]'; yourself));
			yourself).

	aJSStream
		nextPutAll: 'experiment3';
		nextPutAll: ',onClickExperiment3() {'; nextPutAll: ajax asJavascript; nextPutAll: '}'
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperiment4On: aJSStream html: html [
	| ajax |

	ajax := (html jQuery ajax
			callback: [ :value | self experiment4: value ] value: (JSStream on: 'experiment4.value');
			json: [ :json | self ajax4: json html: html ];
			onSuccess: (html javascript
				<< (JSStream new nextPutAll: 'experiment4a.value = arguments[0]'; yourself));
			yourself).

	aJSStream
		nextPutAll: 'experiment4,experiment4a';
		nextPutAll: ',onClickExperiment4() {'; nextPutAll: ajax asJavascript; nextPutAll: '}'.
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperimentOn: aJSStream html: html [

	self vueSetupReturnDemoExperiment1On: aJSStream html: html.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoExperiment2On: aJSStream html: html.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoExperiment3On: aJSStream html: html.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoExperiment4On: aJSStream html: html
]

{ #category : #'demo - reactive' }
QuasarDemoReactiveApp >> vueSetupReturnReactiveObject: aReactiveObject on: aJSStream html: html [
	| ajax refName |

	refName := aReactiveObject refName.

	ajax := (html jQuery ajax
			callback: [ :value | aReactiveObject refValueUpdate: (STONJSON fromString: value) ]
				value: (JSStream on: 'JSON.stringify(', refName, '.value)');
			json: [ :json | json render: aReactiveObject refValue ];
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

{ #category : #'demo - reactive' }
QuasarDemoReactiveApp >> vueSetupReturnReactiveObjectsOn: aJSStream html: html [

	self reactiveObjects
		do: [ :eachReactiveObject |
			self vueSetupReturnReactiveObject: eachReactiveObject on: aJSStream html: html ]
		separatedBy: [ aJSStream nextPut: $, ]
]
