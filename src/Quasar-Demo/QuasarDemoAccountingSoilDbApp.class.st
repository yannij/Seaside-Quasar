Class {
	#name : 'QuasarDemoAccountingSoilDbApp',
	#superclass : 'QuasarDemoAccountingApp',
	#category : 'Quasar-Demo-Accounting',
	#package : 'Quasar-Demo',
	#tag : 'Accounting'
}

{ #category : 'initialization' }
QuasarDemoAccountingSoilDbApp class >> applicationPath [

	^ 'quasar/accounting-soil'
]

{ #category : 'initialization' }
QuasarDemoAccountingSoilDbApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : 'initialization' }
QuasarDemoAccountingSoilDbApp class >> repositoryClass [
	"
	self createData
	"

	^ QuasarDemoSoilCheckpointRepository
]

{ #category : 'rendering - quasar hooks' }
QuasarDemoAccountingSoilDbApp >> quasarConfigContentOn: aJSStream with: html [

	aJSStream nextPutAll: '
brand: {
	primary: ''#E5E4FA'',
	secondary: ''#e30425'',
	accent: ''#9C27B0'',
	dark: ''#1d1d1d'',
	positive: ''#21BA45'',
	negative: ''#C10015'',
	info: ''#31CCEC'',
	warning: ''#F2C037''
}'
]

{ #category : 'rendering' }
QuasarDemoAccountingSoilDbApp >> renderLayoutOn: html [

	self username ifNil: [
		html qApp id: self appId; with: [
			html render: self login ].
		^ self ].

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; vCloak; with: [
			html qHeader heightHint: 98; class: 'bg-primary'; style: 'color: black'; with: [
				html qToolbar with: [
					"html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'."
					self renderTabsOn: html.
					html qSpace.
					html qBtn flat; round; icon: 'view_sidebar'; vOnClick: 'this.$refs.sideSheet.toggle($event)' ] ].
			self renderLayoutPageOn: html.
			html render: self sideSheet ] ]
]
