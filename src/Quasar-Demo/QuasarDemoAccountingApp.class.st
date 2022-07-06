Class {
	#name : #QuasarDemoAccountingApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'tab'
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

	self tab: 'tab1'
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
		"nextPutAll: 'const flyOriginDialog = ref(false);';
		nextPutAll: 'const flyDestinationDialog = ref(false);';"
		nextPutAll: 'const app = Vue.createApp({'.
	self quasarSetupOn: aJSStream with: html.
	aJSStream nextPutAll: '});'.
	aJSStream nextPutAll: 'app.use(Quasar, {'.
	self quasarConfigOn: aJSStream with: html.
	aJSStream nextPutAll: '});'.
	aJSStream nextPutAll: 'app.mount("#', self appId, '")'
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderAccountListOn: html [

	html qList style: 'background: white'; with: [
		QuasarDemoAccountingAccount instanceList do: [ :eachObject |
			html qItem with: [
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
QuasarDemoAccountingApp >> renderAccountsOn: html [

	self tab = 'accounts' ifFalse: [ ^ self ].

	self renderAccountListOn: html
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderCompaniesOn: html [

	self tab = 'companies' ifFalse: [ ^ self ].

	self renderCompanyListOn: html
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderCompanyListOn: html [

	html qList style: 'background: white'; with: [
		QuasarDemoAccountingCompany instanceList do: [ :eachObject |
			html qItem with: [
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
QuasarDemoAccountingApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; vCloak; with: [
		html qHeader heightHint: 98; class: 'bg-primary'; with: [
			html qToolbar with: [
				"html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'."
				html qImg src: (QuasarDemoAccountinglLibrary urlOf: #cranelogoPng); style: 'height: 56px; width: 56px'.
				self renderTabsOn: html.
				html qSpace.
				html qBtn dense; flat; round; icon: 'star'; vOnClick: '' ] ].
			self renderLayoutPageOn: html ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage with: [
			self renderTabPanelsOn: html ] ]
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
			html qRouteTab label: 'Companies'; href: (html urlForAction: [ self tab: 'companies' ]).
			html qRouteTab label: 'Accounts'; href: (html urlForAction: [ self tab: 'accounts' ]).
			html qRouteTab label: 'Users'; href: (html urlForAction: [ self tab: 'users' ]) ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderUserListOn: html [

	html qList style: 'background: white'; with: [
		QuasarDemoAccountingUser instanceList do: [ :eachObject |
			html qItem with: [
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
QuasarDemoAccountingApp >> renderUsersOn: html [

	self tab = 'users' ifFalse: [ ^ self ].

	self renderUserListOn: html
]

{ #category : #accessing }
QuasarDemoAccountingApp >> tab [

	^ tab
]

{ #category : #accessing }
QuasarDemoAccountingApp >> tab: anObject [

	tab := anObject
]

{ #category : #updating }
QuasarDemoAccountingApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.

	anHtmlRoot stylesheet url: (QuasarDemoAccountinglLibrary urlOf: #craneCss)

]
