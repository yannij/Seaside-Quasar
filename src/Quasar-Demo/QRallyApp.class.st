Class {
	#name : #QRallyApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'loginComponent',
		'pageComponent'
	],
	#category : #'Quasar-Demo'
}

{ #category : #initialization }
QRallyApp class >> applicationPath [

	^ 'quasar/material-study-rally'
]

{ #category : #initialization }
QRallyApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QRallyApp >> applicationTitle [

	^ 'Rally'
]

{ #category : #'temp compat' }
QRallyApp >> bodyRegion [

	^ self
]

{ #category : #initialization }
QRallyApp >> buildLoginComponent [

	^ MDQLogin new
		loginTitle: self applicationTitle;
		authenticationBlock: [ :username :password | #guest ];
		recoverBlock: [ :username :tokenTyped :tokenSent | #guest ];
		registerBlock: [ :username :password | #guest ];
		sendTokenBlock: [ :username | '' ];
		yourself
]

{ #category : #'temp compat' }
QRallyApp >> component: ignored [

	^ self
]

{ #category : #accessing }
QRallyApp >> loginComponent [

	^ loginComponent
]

{ #category : #accessing }
QRallyApp >> loginComponent: anObject [

	loginComponent := anObject
]

{ #category : #accessing }
QRallyApp >> pageComponent [

	^ pageComponent
]

{ #category : #accessing }
QRallyApp >> pageComponent: anObject [

	pageComponent := anObject
]

{ #category : #rendering }
QRallyApp >> renderLayoutOn: html [

	html script: 'document.body.style.setProperty(''--q-primary'', ''#344955'')'.
	html script: 'document.body.style.setProperty(''--q-secondary'', ''#F9AA33'')'.
"
:root {
  --q-primary: #1976d2;
  --q-secondary: #26a69a;
  --q-accent: #9c27b0;
  --q-positive: #21ba45;
  --q-negative: #c10015;
  --q-info: #31ccec;
  --q-warning: #f2c037;
  --q-dark: #1d1d1d;
  --q-dark-page: #121212;
}
"

	"self isLoggedIn" true
		ifTrue: [ self renderLayoutRallyOn: html ]
		ifFalse: [
			self loginComponent
				ifNotNil: [ :value | html render: value  ]
				ifNil: [
					"self anonymousLoginAllowed" false
						ifTrue: [ self renderLayoutRallyOn: html ]
						ifFalse: [
							self loginComponent ifNil: [ self loginComponent: self buildLoginComponent ].
							html render: self loginComponent ] ] ]
]

{ #category : #rendering }
QRallyApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage with: [
			"self renderSettingsFabOn: html."
			self renderPageContentOn: html ] ]
]

{ #category : #rendering }
QRallyApp >> renderLayoutRallyOn: html [

	html qApp with: [
		html qLayout view: 'hHh lpR fFf'; with: [
			"html qHeader heightHint: 98; with: [
				html qToolbar with: [
					html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'.
					html qToolbarTitle with: [ html text: 'Rally' ] ] ]."
			self renderLeftDrawerOn: html.
			self renderLayoutPageOn: html.
			"self renderSideSheetOn: html.
			self renderBottomSheetOn: html."
			"self renderSettingsFabOn: html" ] ]
]

{ #category : #rendering }
QRallyApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; mini; side: 'left';
		class: 'bg-primary'; style: 'color: white';
		with: [
			html qScrollArea class: 'fit'; with: [
				"self renderNavBrandingOn: html."
				self renderNavOn: html ] ]
]

{ #category : #rendering }
QRallyApp >> renderNavBrandingOn: html [

	html div style: 'width: 100%'; with: [
		html span class: 'text-justify';
			style: 'font-size: 1.25rem';
			with: self applicationTitle ]
]

{ #category : #rendering }
QRallyApp >> renderNavOn: html [
	| navList |

	navList := OrderedCollection new
		add: "Overview" 'dashboard' -> QRallyOverview new;
		add: "Accounts" 'attach_money' -> QRallyAccountView new;
		add: "Bills" 'strikethrough_s' -> QRallyBillView new;
		add: "Budget" 'bar_chart' -> QRallyBudgetItemView new;
		add: "Alerts" 'notification_important' -> QRallyAlertView new;
		yourself.

	html qList with: [
		html qItem with: [
			html span class: 'text-h6'; with: self applicationTitle ].
		navList do: [ :eachItem |
			html qItem
				qTag: 'a'; href: (html urlForAction: [ self pageComponent: eachItem value ]);
				with: [
					html qItemSection avatar; with: [
						html qIcon name: eachItem key ].
					"html qItemSection with: eachItem key" ] ] ]
]

{ #category : #rendering }
QRallyApp >> renderPageContentOn: html [

	html div "class: 'no-padding';" with: [
		html render: self pageComponent ]
]
