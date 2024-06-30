"
I am a demo application showing how to use Quasar Utils from Seaside.
"
Class {
	#name : 'QuasarDemoUtilsApp',
	#superclass : 'QuasarApplication',
	#instVars : [
		'demoName',
		'demoObjectA',
		'experiment4',
		'reactive1'
	],
	#category : 'Quasar-Demo-Basic',
	#package : 'Quasar-Demo',
	#tag : 'Basic'
}

{ #category : 'initialization' }
QuasarDemoUtilsApp class >> applicationPath [

	^ 'quasar/utils-demo'
]

{ #category : 'accessing' }
QuasarDemoUtilsApp class >> categoryName [

	^ #quasar
]

{ #category : 'initialization' }
QuasarDemoUtilsApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : 'accessing' }
QuasarDemoUtilsApp >> applicationTitle [

	^ 'Quasar Utils'
]

{ #category : 'accessing' }
QuasarDemoUtilsApp >> demoName [

	^ demoName
]

{ #category : 'accessing' }
QuasarDemoUtilsApp >> demoName: anObject [

	demoName := anObject
]

{ #category : 'accessing' }
QuasarDemoUtilsApp >> demoNames [

	^ #(
	DOM
	Other
	)
]

{ #category : 'rendering - quasar hooks' }
QuasarDemoUtilsApp >> quasarSetupContentOn: aJSStream with: html [

	aJSStream nextPutAll: '
const uid1 = ref("uid1 initial value");
const dom1 = ref("dom1 initial value");
'
]

{ #category : 'rendering - quasar hooks' }
QuasarDemoUtilsApp >> quasarSetupReturnCustomList: aList with: anAjaxFactory [

	aList
		add: 'uid1, utilUid(){ uid1.value = Quasar.uid() }';
		"add: 'dom1, utilDomOffset(){ dom1.value = Quasar.dom.offset(this.$refs.dom1Chip) }'"
		add: 'dom1, utilDomOffset(){ console.log(this.$refs.dom1Chip) }'
]

{ #category : 'demo - DOM' }
QuasarDemoUtilsApp >> renderDemoDOMOn: html [

	html text: 'Click to generate UID: '.
	html qChip
		clickable;
		vOnClick: 'utilUid($event)';
		vBind: 'label' with: 'uid1'
		"label: 'foobar'"
]

{ #category : 'demo - other' }
QuasarDemoUtilsApp >> renderDemoOtherOn: html [

	self renderDemoOtherUIDOn: html
]

{ #category : 'demo - other' }
QuasarDemoUtilsApp >> renderDemoOtherUIDOn: html [

	html text: 'Click to generate UID: '.
	html qChip
		clickable;
		vOnClick: 'utilUid($event)';
		vBind: 'label' with: 'uid1'
		"label: 'foobar'"
]

{ #category : 'rendering' }
QuasarDemoUtilsApp >> renderLayoutOn: html [

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

{ #category : 'rendering' }
QuasarDemoUtilsApp >> renderLayoutPageOn: html [
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

{ #category : 'rendering' }
QuasarDemoUtilsApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; persistent; side: 'left';
		class: 'bg-primary'; style: 'color: white';
		with: [
			html qScrollArea class: 'fit'; with: [
				"self renderNavBrandingOn: html."
				self renderNavOn: html ] ]
]

{ #category : 'rendering' }
QuasarDemoUtilsApp >> renderNavOn: html [

	html qList with: [
		self demoNames do: [ :eachItem |
			html qItem
				qTag: 'a'; href: (html urlForAction: [ self demoName: eachItem ]);
				with: [
					html qItemSection with: eachItem ] ] ]
]
