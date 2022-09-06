Class {
	#name : #QuasarDemoReactiveApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'demoName',
		'demoObjectA',
		'experiment4',
		'reactiveList',
		'testCollection'
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
QuasarDemoReactiveApp >> ajax2: json with: anAjaxFactory [

	json render: (OrderedCollection new
		add: {'key' -> 1. 'value' -> Date today printString} asDictionary;
		add: {'key' -> 2. 'value' -> Time now printString} asDictionary;
		yourself)
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> ajax3: json with: anAjaxFactory [
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
QuasarDemoReactiveApp >> ajax4: json with: anAjaxFactory [

	json render: self experiment4
]

{ #category : #accessing }
QuasarDemoReactiveApp >> applicationTitle [

	^ 'Reactive Demo'
]

{ #category : #initialize }
QuasarDemoReactiveApp >> buildTestCollection [
	| newList |

	newList := OrderedCollection new
		add: QuasarDemoObjectA newRandom;
		add: QuasarDemoObjectA newRandom;
		add: QuasarDemoObjectA newRandom;
		yourself.

	^ (QuasarRefSyncClientToServer name: 'testCollection' value: newList)
		callbackBlock: [ :ref :value | ref refValue: (value asOrderedCollection add: QuasarDemoObjectA newRandom; yourself) ]; yourself
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
	Collection
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
		add: ((QuasarRefSyncClientToServer name: 'reactive1' value: true) callbackBlock: [ :ref :value | ref refValue: value not ]; yourself);
		add: ((QuasarRefSyncClientToServer name: 'reactive2' value: 0) callbackBlock: [ :ref :value | ref refValue: value + 1 ]; yourself);
		add: ((QuasarRefSyncClientToServer name: 'reactive3' value: 1.2) callbackBlock: [ :ref :value | ref refValue: value + 1 ]; yourself);
		add: ((QuasarRefSyncClientToServer name: 'reactive4' value: 'abc') callbackBlock: [ :ref :value | ref refValue: value, value ]; yourself);
		add: ((QuasarRefSyncClientToServer name: 'reactive5' value: DateAndTime now) callbackBlock: [ :ref :value | ref refValue: DateAndTime now ]; yourself);
		add: ((QuasarRefSyncClientToServer name: 'reactive6' value: {true. 123. 3.456. 'abc'. DateAndTime now})
			callbackBlock: [ :ref :value | ref refValue: value, value ]; yourself);
		add: ((QuasarRefSyncClientToServer name: 'reactive7' value: {'k1'->'v1'. 'k2'->'v2'. 'k3'->'v3'} asDictionary)
			callbackBlock: [ :ref :value | ref refValue: (value at: 100 atRandom printString put: 1000 atRandom; yourself) ]; yourself);
		add: ((QuasarRefSyncClientToServer name: 'reactive8'
			value: {
				{'k1'->'v1'. 'k2'->'v2'. 'k3'->'v3'} asDictionary.
				{'k21'->'v21'. 'k22'->'v22'. 'k23'->'v23'} asDictionary.
				{'k31'->'v31'. 'k32'->'v32'. 'k33'->'v33'} asDictionary })
			callbackBlock: [ :ref :value | ref refValue: value ]; yourself);
		yourself).

	self testCollection: self buildTestCollection
]

{ #category : #rendering }
QuasarDemoReactiveApp >> quasarSetupContentOn: aJSStream with: html [

	self vueSetupDemoExperimentOn: aJSStream
]

{ #category : #'rendering - quasar hooks' }
QuasarDemoReactiveApp >> quasarSetupReturnContentOn: aJSStream with: anAjaxFactory [

	self vueSetupReturnDemoExperimentOn: aJSStream with: anAjaxFactory
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

{ #category : #'demo - collection' }
QuasarDemoReactiveApp >> renderDemoCollectionOn: html [
	| refName |

	self mdqApplicationGet reactiveObjectsAdd: self testCollection.

	refName := self testCollection refName.
	html div class: 'q-pa-sm'; with: [
		html div with: refName, ': {{ ', refName, ' }}' ].
	html div with: [
		html qBtn label: refName; vOnClick: refName, 'RefSync()' ].

	html break.
	html qCard with: [
		html qScrollArea style: 'height: 220px'; visible; with: [
			html qList separator; bordered; with: [
				html qItem vFor: 'v in ', refName; with: [
					html qItemSection with: '{{ v.string1 }} - {{ v.integer1 }} - {{ v.boolean1 }}' ] ] ] ].

	html break.
	html qCard with: [
		html qScrollArea style: 'height: 90px'; visible; with: [
			html qChip vFor: 'v in ', refName; with: '{{ v.string1 }} - {{ v.integer1 }} - {{ v.boolean1 }}' ] ].

	html div class: 'q-py-md'; with: [
		html qTable title: 'Test Collection'; "columns: self refNameCols;" rows: refName ]
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
				html qBtn label: refName; vOnClick: refName, 'RefSync()' ] ]
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

{ #category : #accessing }
QuasarDemoReactiveApp >> testCollection [

	^ testCollection
]

{ #category : #accessing }
QuasarDemoReactiveApp >> testCollection: anObject [

	testCollection := anObject
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupDemoExperimentOn: aJSStream [

	aJSStream
		nextPutAll: 'const experiment2 = ref([{key: 1, value: ''original value''}]);';
		nextPutAll: 'const experiment3 = ref(null);';
		nextPutAll: 'const experiment4 = ref(null); const experiment4a = ref(null);'
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperiment1On: aJSStream with: anAjaxFactory [

	aJSStream
		nextPutAll: 'onClickExperiment1(evt) {alert("hello");}'
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperiment2On: aJSStream with: anAjaxFactory [
	| ajax |

	ajax := (anAjaxFactory fetch
			json: [ :json | self ajax2: json with: anAjaxFactory ];
			onSuccess: (anAjaxFactory javascript << (JSStream new nextPutAll: 'experiment2.value = arguments[0]'; yourself));
			yourself).

	aJSStream
		nextPutAll: 'experiment2';
		nextPutAll: ',async onClickExperiment2() {'; nextPutAll: ajax asJavascript; nextPutAll: '}'.
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperiment3On: aJSStream with: anAjaxFactory [
	| ajax |

	ajax := (anAjaxFactory fetch
			json: [ :json | self ajax3: json with: anAjaxFactory ];
			onSuccess: (anAjaxFactory javascript
				<< (JSStream new nextPutAll: 'experiment3.value = arguments[0]'; yourself));
			yourself).

	aJSStream
		nextPutAll: 'experiment3';
		nextPutAll: ',async onClickExperiment3() {'; nextPutAll: ajax asJavascript; nextPutAll: '}'
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperiment4On: aJSStream with: anAjaxFactory [
	| ajax |

	ajax := (anAjaxFactory fetch
			callback: [ :value | self experiment4: value ] value: (JSStream on: 'experiment4.value');
			json: [ :json | self ajax4: json with: anAjaxFactory ];
			onSuccess: (anAjaxFactory javascript
				<< (JSStream new nextPutAll: 'experiment4a.value = arguments[0]'; yourself));
			yourself).

	aJSStream
		nextPutAll: 'experiment4,experiment4a';
		nextPutAll: ',async onClickExperiment4() {'; nextPutAll: ajax asJavascript; nextPutAll: '}'.
]

{ #category : #'demo - ajax' }
QuasarDemoReactiveApp >> vueSetupReturnDemoExperimentOn: aJSStream with: anAjaxFactory [

	self vueSetupReturnDemoExperiment1On: aJSStream with: anAjaxFactory.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoExperiment2On: aJSStream with: anAjaxFactory.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoExperiment3On: aJSStream with: anAjaxFactory.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoExperiment4On: aJSStream with: anAjaxFactory
]
