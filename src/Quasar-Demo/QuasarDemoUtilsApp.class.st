"
I am a demo application showing how to use Quasar Utils from Seaside.
"
Class {
	#name : #QuasarDemoUtilsApp,
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
QuasarDemoUtilsApp class >> applicationPath [

	^ 'quasar/utils-demo'
]

{ #category : #initialization }
QuasarDemoUtilsApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QuasarDemoUtilsApp >> applicationTitle [

	^ 'Quasar Utils'
]

{ #category : #accessing }
QuasarDemoUtilsApp >> demoName [

	^ demoName
]

{ #category : #accessing }
QuasarDemoUtilsApp >> demoName: anObject [

	demoName := anObject
]

{ #category : #accessing }
QuasarDemoUtilsApp >> demoNames [

	^ #(
	UID
	)
]

{ #category : #rendering }
QuasarDemoUtilsApp >> quasarSetupContentOn: aJSStream with: html [

	aJSStream nextPutAll: '
const uid1 = ref("zzz");'
]

{ #category : #rendering }
QuasarDemoUtilsApp >> quasarSetupReturnContentOn: aJSStream with: html [

	aJSStream nextPutAll: 'uid1, utilUid(){ uid1.value = Quasar.uid() }'
]

{ #category : #'demo - uuid' }
QuasarDemoUtilsApp >> renderDemoUIDOn: html [

	html text: 'Click to generate UID: '.
	html qChip
		clickable;
		vOnClick: 'utilUid($event)';
		vBind: 'label' with: 'uid1'
		"label: 'foobar'"
]

{ #category : #rendering }
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
					html qToolbarTitle with: [ html text: 'Quasar Component Demos' ] ] ].
			self renderLeftDrawerOn: html.
			self renderLayoutPageOn: html ] ]
]

{ #category : #rendering }
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

{ #category : #rendering }
QuasarDemoUtilsApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; persistent; side: 'left';
		class: 'bg-primary'; style: 'color: white';
		with: [
			html qScrollArea class: 'fit'; with: [
				"self renderNavBrandingOn: html."
				self renderNavOn: html ] ]
]

{ #category : #rendering }
QuasarDemoUtilsApp >> renderNavOn: html [

	html qList with: [
		self demoNames do: [ :eachItem |
			html qItem
				qTag: 'a'; href: (html urlForAction: [ self demoName: eachItem ]);
				with: [
					html qItemSection with: eachItem ] ] ]
]
