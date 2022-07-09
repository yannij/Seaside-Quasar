Class {
	#name : #QuasarDemoAccountingApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'tab',
		'sideSheet',
		'sideSheetOpen',
		'model',
		'modelView'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #initialization }
QuasarDemoAccountingApp class >> applicationPath [

	^ 'quasar/accounting'
]

{ #category : #initialization }
QuasarDemoAccountingApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QuasarDemoAccountingApp >> applicationTitle [

	^ 'Accounting'
]

{ #category : #initialization }
QuasarDemoAccountingApp >> initialize [

	super initialize.

	self sideSheetOpen: ((QuasarReactiveRefSet name: 'sideSheetOpen' value: true) transformBlock: [ :value | value ]; traceOn; yourself).
	self reactiveObjectsAdd: self sideSheetOpen.
	self sideSheet: QuasarDemoSideSheet new.
	self tab: 'users'
]

{ #category : #accessing }
QuasarDemoAccountingApp >> model [

	^ model
]

{ #category : #accessing }
QuasarDemoAccountingApp >> model: anObject [

	model := anObject
]

{ #category : #accessing }
QuasarDemoAccountingApp >> modelSet: anObject [

	self model: anObject.
	anObject
		ifNil: [ self modelView: nil ]
		ifNotNil: [ self modelView: (anObject viewClass on: anObject) ]
]

{ #category : #accessing }
QuasarDemoAccountingApp >> modelView [

	^ modelView
]

{ #category : #accessing }
QuasarDemoAccountingApp >> modelView: anObject [

	modelView := anObject
]

{ #category : #rendering }
QuasarDemoAccountingApp >> quasarConfigContentOn: aJSStream with: html [

	aJSStream nextPutAll: '
brand: {
	primary: ''#5d1049'',
	secondary: ''#e30425'',
	accent: ''#9C27B0'',
	dark: ''#1d1d1d'',
	positive: ''#21BA45'',
	negative: ''#C10015'',
	info: ''#31CCEC'',
	warning: ''#F2C037''
}'
]

{ #category : #rendering }
QuasarDemoAccountingApp >> quasarOnLoadOn: aJSStream with: html [

	aJSStream
		nextPutAll: 'const { ref } = Vue;';
		nextPutAll: 'const app = Vue.createApp({'.
	self quasarSetupOn: aJSStream with: html.
	aJSStream nextPutAll: '});'.
	aJSStream nextPutAll: 'app.use(Quasar, {'.
	self quasarConfigOn: aJSStream with: html.
	aJSStream nextPutAll: '});'.
	aJSStream nextPutAll: 'app.mount("#', self appId, '")'
]

{ #category : #rendering }
QuasarDemoAccountingApp >> quasarSetupReturnContentOn: aJSStream with: html [
	| exports |

	exports := ',' join: (self quasarData, (self vueRefs keys)).
	exports ifNotEmpty: [
		aJSStream nextPutAll: exports ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderAccountsOn: html [

	self tab = 'accounts' ifFalse: [ ^ self ].

	self renderModelList: QuasarDemoAccountingAccount instanceList on: html
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderCompaniesOn: html [

	self tab = 'companies' ifFalse: [ ^ self ].

	self renderModelList: QuasarDemoAccountingCompany instanceList on: html
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; vCloak; with: [
			html qHeader heightHint: 98; class: 'bg-primary'; with: [
				html qToolbar with: [
					"html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'."
					html qImg src: (QuasarDemoAccountinglLibrary urlOf: #cranelogoPng); style: 'height: 56px; width: 56px'.
					self renderTabsOn: html.
					html qSpace.
					html qBtn flat; round; icon: 'view_sidebar'; vOnClick: 'this.$refs.sideSheet.toggle($event)' ] ].
			self renderLayoutPageOn: html.
			html render: self sideSheet ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage with: [
			self renderModelOn: html ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderModelList: aList on: html [

	html qList style: 'background: white'; with: [
		aList do: [ :eachObject |
			html qItem qTag: 'a'; href: (html urlForAction: [ self modelSet: eachObject ]); with: [
				html qItemSection top; avatar; with: [
					html qAvatar color: 'primary'; textColor: 'white'; icon: 'star' ].
				html qItemSection with: [
					html qItemLabel with: eachObject name.
					html qItemLabel caption; "lines: 2;"
						with: eachObject summaryString ].
				"html qItemSection with: [
					html qItemLabel style: 'color: red'; with: eachObject price ]" ] ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderModelOn: html [

	self modelView isNil ifTrue: [
		^ html heading level2; with: 'No model selected' ].

	html render: self modelView
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderTabPanelsOn: html [

	html qTabPanels "vModel: 'tab';" modelValue: self tab; animated; with: [
		html qTabPanel name: 'companies'; class: 'q-pa-none'; with: [ self renderCompaniesOn: html ].
		html qTabPanel name: 'accounts'; class: 'q-pa-none'; with: [ self renderAccountsOn: html ].
		html qTabPanel name: 'users'; class: 'q-pa-none'; with: [ self renderUsersOn: html ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderTabsOn: html [

	html qTabs
		vModel: self tab;
		with: [
			html qRouteTab label: 'Companies'; href: (html urlForAction: [ self tabSet: 'companies' ]).
			html qRouteTab label: 'Accounts'; href: (html urlForAction: [ self tabSet: 'accounts' ]).
			html qRouteTab label: 'Users'; href: (html urlForAction: [ self tabSet: 'users' ]) ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderUsersOn: html [

	self tab = 'users' ifFalse: [ ^ self ].

	self renderModelList: QuasarDemoAccountingUser instanceList on: html
]

{ #category : #accessing }
QuasarDemoAccountingApp >> sideSheet [

	^ sideSheet
]

{ #category : #accessing }
QuasarDemoAccountingApp >> sideSheet: anObject [

	sideSheet := anObject
]

{ #category : #accessing }
QuasarDemoAccountingApp >> sideSheetOpen [

	^ sideSheetOpen
]

{ #category : #accessing }
QuasarDemoAccountingApp >> sideSheetOpen: anObject [

	sideSheetOpen := anObject
]

{ #category : #accessing }
QuasarDemoAccountingApp >> tab [

	^ tab
]

{ #category : #accessing }
QuasarDemoAccountingApp >> tab: anObject [

	tab := anObject
]

{ #category : #accessing }
QuasarDemoAccountingApp >> tabSet: anObject [

	self tab: anObject.
	self modelSet: nil
]

{ #category : #updating }
QuasarDemoAccountingApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.

	anHtmlRoot stylesheet url: (QuasarDemoAccountinglLibrary urlOf: #craneCss)

]
