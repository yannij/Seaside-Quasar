"
I hold various code examples for utilizing Vue features from Seaside
"
Class {
	#name : #QuasarDemoVueUsageApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'demoName',
		'demoObjectA',
		'experiment4',
		'reactive1'
	],
	#category : #'Quasar-Demo-Basic'
}

{ #category : #initialization }
QuasarDemoVueUsageApp class >> applicationPath [

	^ 'quasar/vue-usage'
]

{ #category : #initialization }
QuasarDemoVueUsageApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QuasarDemoVueUsageApp >> applicationTitle [

	^ 'Vue Usage'
]

{ #category : #accessing }
QuasarDemoVueUsageApp >> demoName [

	^ demoName
]

{ #category : #accessing }
QuasarDemoVueUsageApp >> demoName: anObject [

	demoName := anObject
]

{ #category : #accessing }
QuasarDemoVueUsageApp >> demoNames [

	^ #(
	Scroll
	)
]

{ #category : #'rendering - quasar' }
QuasarDemoVueUsageApp >> quasarOnLoadOn: aJSStream with: anAjaxFactory [

	aJSStream nextPutAll: 'const { QBtn } = Quasar;'.
	super quasarOnLoadOn: aJSStream with: anAjaxFactory
]

{ #category : #'rendering - quasar hooks' }
QuasarDemoVueUsageApp >> quasarSetupContentOn: aJSStream with: html [

	aJSStream nextPutAll: '
const mybutton = ref(QBtn);
'
]

{ #category : #'rendering - quasar hooks' }
QuasarDemoVueUsageApp >> quasarSetupReturnContentOn: aJSStream with: anAjaxFactory [

	aJSStream
		nextPutAll: 'mybutton'
]

{ #category : #'demo - scroll' }
QuasarDemoVueUsageApp >> renderDemoScrollOn: html [

	self onMountedObjectsAdd: ((QuasarSetupOnMounted name: 'demoScrollOnMounted')
			codeBlock: [ :stream :ajaxFactory | stream nextPutAll: 'mybutton.value.$el.scrollIntoView({ behavior: ''smooth'' })' ];
			yourself).

	html div class: 'q-qa-sm'; with: [
		html qBtn
			label: 'Scroll to target';
			vOnClick: 'this.$refs.mybutton.$el.scrollIntoView({ behavior: ''smooth'' })'.
		html div
			vFor: 'n in 100';
			vBind: 'key' with: 'n';
			with: 'Item {{ n }} / 100' ].

	html div "style: 'padding-top: 1000px';" with: [
		html qBtn ref: 'mybutton'; label: 'Scroll To Me!' ].
]

{ #category : #rendering }
QuasarDemoVueUsageApp >> renderLayoutOn: html [

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
QuasarDemoVueUsageApp >> renderLayoutPageOn: html [
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
QuasarDemoVueUsageApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; persistent; side: 'left';
		class: 'bg-primary'; style: 'color: white';
		with: [
			html qScrollArea class: 'fit'; with: [
				"self renderNavBrandingOn: html."
				self renderNavOn: html ] ]
]

{ #category : #rendering }
QuasarDemoVueUsageApp >> renderNavOn: html [

	html qList with: [
		self demoNames do: [ :eachItem |
			html qItem
				qTag: 'a'; href: (html urlForAction: [ self demoName: eachItem ]);
				with: [
					html qItemSection with: eachItem ] ] ]
]
