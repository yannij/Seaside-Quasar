"
I am an example loan/borrow exchange app, built using Material Design Seaside, Magritte, and Voyage/Mongo. The functionality was inspired by a question raised on the Pharo database Discord channel (approx mid-October 2021).
"
Class {
	#name : #LoanexApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'loginComponent',
		'pageComponent',
		'currentUser',
		'viewUser',
		'viewUsers',
		'viewTask',
		'filterValues',
		'appSettings'
	],
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #'class initialization' }
LoanexApp class >> applicationPath [

	^ 'tidbit/loanex'
]

{ #category : #'class initialization' }
LoanexApp class >> dockerDeployPostLoad [
	<dockerDeployPostLoad>

	WAComponent mdqPublicServerUrlInstallDockerConfig
]

{ #category : #'class initialization' }
LoanexApp class >> dockerDeployPreLoad [
	<dockerDeployPreLoad>

	DockerDeploy current configNamesAdd: DockerDeploy defaultConfigName
]

{ #category : #'class initialization' }
LoanexApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #testing }
LoanexApp >> anonymousLoginAllowed [

	^ false
]

{ #category : #accessing }
LoanexApp >> appSettings [

	^ appSettings
]

{ #category : #accessing }
LoanexApp >> appSettings: anObject [

	appSettings := anObject
]

{ #category : #accessing }
LoanexApp >> applicationTitle [

	^ 'LoanEx'
]

{ #category : #'utility - login' }
LoanexApp >> authenticateUsername: aUsername password: aPassword [
	"Answer a user instance if hashed pssword matches saved passwrodHass,
	or answer nil is does not match, or user not found"

	^ (self findUser: aUsername)
		ifNil: [ nil ]
		ifNotNil: [ :value |
			value passwordHash = (MDQLogin passwordHashFor: (aPassword ifNil: [ '' ] ifNotNil: [ :arg | arg ]))
				ifTrue: [ value ]
				ifFalse: [ nil ] ]
]

{ #category : #rendering }
LoanexApp >> buildColorTheme [

	^ MDQTheme fromString:
'{
	"name": "Loanex",
	"isDark": false,
	"colors": {
		"primary": "#1EB980",
		"secondary": "#26a69a",
		"accent": "#9c27b0",

		"positive": "#21ba45",
		"negative": "#c10015",
		"info": "#31ccec",
		"warning": "#f2c037",

		"background": "#fff"
	}
}'
]

{ #category : #initialization }
LoanexApp >> buildLoginComponent [

	^ MDQLogin new
		loginTitle: self applicationTitle;
		authenticationBlock: [ :username :password |
			| userOrNil |
			userOrNil := self authenticateUsername: username password: password.
			self viewUserSetTo: userOrNil.
			userOrNil ];
		recoverBlock: [ :username :tokenTyped :tokenSent |
			| userOrNil |
			self logFormat: 'Recovering: tokenTyped="{1}", tokenSent="{2}"' with: tokenTyped with: tokenSent.
			userOrNil := nil.
			tokenTyped = tokenSent ifTrue: [
				userOrNil := self findUser: username ].
			self viewUserSetTo: userOrNil.
			userOrNil ];
		registerBlock: [ :username :password |
			| userOrNil |
			self logFormat: 'Registering username="{1}"' with: username.
			userOrNil := self registerUsername: username password: password.
			self viewUserSetTo: userOrNil.
			userOrNil ];
		sendTokenBlock: [ :username |
			self logFormat: 'Sending token to username="{1}"' with: username.
			'1234' ];
		yourself
]

{ #category : #accessing }
LoanexApp >> colorThemeOLD [

	^ {
#'primary' -> '1EB980'.
"#'on-primary' -> '000000'.
#'secondary' -> 'FF6859'.
#'on-secondary' -> '000000'.
#'surface' -> '121212'.
#'on-surface' -> 'FFFFFF'.
#'background' -> '121212'"
} asOrderedDictionary
]

{ #category : #accessing }
LoanexApp >> currentUser [

	^ currentUser
]

{ #category : #accessing }
LoanexApp >> currentUser: anObject [

	currentUser := anObject
]

{ #category : #accessing }
LoanexApp >> filterValues [

	^ filterValues
]

{ #category : #accessing }
LoanexApp >> filterValues: anObject [

	filterValues := anObject
]

{ #category : #'utility - login' }
LoanexApp >> findUser: aUsername [
	"Answer the user having username matching aUsername, or nil if not found"

	^ (self repository selectAll: LoanexUser)
		ifEmpty: [ nil ]
		ifNotEmpty: [ :value | value detect: [ :eachUser | eachUser username = aUsername ] ifNone: [ nil ] ]
]

{ #category : #initialization }
LoanexApp >> initialize [

	super initialize.

	self colorTheme: self buildColorTheme.

	self filterValues: LoanexFilterValues new.
	self filterValues toyAvailable: #both.
	self initializeLayout
]

{ #category : #initialization }
LoanexApp >> initializeLayout [

	self loginComponent: self buildLoginComponent.
	self viewUsers: LoanexUserListView new.
	self viewTask: (LoanexToyListView new filterView: LoanexToyFilterView new).

	"self layout: self buildLayout.
	self setupLayout"
	self appSettings: MDQApplicationSettings new.
	"self settingsView: MDQApplicationSettingsView new."
]

{ #category : #accessing }
LoanexApp >> loginComponent [

	^ loginComponent
]

{ #category : #accessing }
LoanexApp >> loginComponent: anObject [

	loginComponent := anObject
]

{ #category : #navigation }
LoanexApp >> navTo: aModel [

	self navTo: aModel aspect: nil
]

{ #category : #navigation }
LoanexApp >> navTo: aModel  aspect: anAspect [
	| newView |

	aModel ifNil: [ ^ self ].

	newView := aModel asComponent
					addValidatedForm;
					"addMessage: 'hello';"
					yourself.

	self pageComponentSet: newView
]

{ #category : #'utility - login' }
LoanexApp >> newUsername: aUsername password: aPassword [
	| userModel |

	userModel := LoanexUser new
		username: aUsername;
		fullName: aUsername;
		passwordHash: (MDQLogin passwordHashFor: aPassword);
		yourself.

	self repository save: userModel.

	^ userModel

]

{ #category : #accessing }
LoanexApp >> pageComponent [

	^ pageComponent
]

{ #category : #accessing }
LoanexApp >> pageComponent: anObject [

	pageComponent := anObject
]

{ #category : #rendering }
LoanexApp >> pageComponentSet: anObject [

	self quasarDataClear.
	self pageComponent: anObject
]

{ #category : #'utility - login' }
LoanexApp >> registerUsername: aUsername password: aPassword [
	"Answer a new user instance built from the userId/password,
	or answer nil user already exists"

	^ (self findUser: aUsername)
		ifNil: [ self newUsername: aUsername password: aPassword ]
		ifNotNil: [ :value | "User already exists" nil ]
]

{ #category : #rendering }
LoanexApp >> renderLayoutOn: html [

	self renderSetColorTheme: self colorTheme on: html.
	"self renderSetTypographyFont: self themeFontFamily on: html."

	self isLoggedIn
		ifTrue: [ self renderLoanexOn: html ]
		ifFalse: [
			self loginComponent
				ifNotNil: [ :value | html render: value  ]
				ifNil: [
					self anonymousLoginAllowed
						ifTrue: [ self renderLoanexOn: html ]
						ifFalse: [
							self loginComponent ifNil: [ self loginComponent: self buildLoginComponent ].
							html render: self loginComponent ] ] ]
]

{ #category : #rendering }
LoanexApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage with: [
			"self renderSettingsFabOn: html."
			self renderPageContentOn: html ] ]
]

{ #category : #rendering }
LoanexApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; side: 'left';
		"class: 'bg-secondary'; style: 'color: white';"
		style: 'background: blue-2';
		with: [
			html qScrollArea class: 'fit'; with: [
				"self renderNavBrandingOn: html."
				self renderNavOn: html ] ]
]

{ #category : #rendering }
LoanexApp >> renderLoanexOn: html [

	html qApp with: [
		html qLayout view: 'hHh lpR fFf'; with: [
			html qHeader heightHint: 98; with: [
				html qToolbar with: [
					html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'.
					html qToolbarTitle with: [ html text: 'Loanex' ].
					html qBtn dense; flat; round; icon: 'filter'; vOnClick: 'this.$refs.sideSheet.toggle($event)'. ] ].
			self renderLeftDrawerOn: html.
			self renderLayoutPageOn: html.
			self renderSideSheetOn: html ] ]
]

{ #category : #rendering }
LoanexApp >> renderNavOn: html [
	| navList |

	navList := OrderedCollection new
		add: #('Home' 'home') -> [ self viewUserGo ];
		add: #('Loans' 'thumb_up') -> [ self viewToyLoansGo ];
		add: #('Toys' 'widgets') -> [ self viewTaskGo ];
		add: #('Users' 'perm_identity') -> [ self viewUsersGo ];
		yourself.

	html qList with: [
		navList do: [ :eachItem |
			html qItem
				qTag: 'a'; href: (html urlForAction: eachItem value);
				with: [
					html qItemSection avatar; with: [
						html qIcon name: eachItem key second ].
					html qItemSection with: eachItem key first ] ] ]
]

{ #category : #rendering }
LoanexApp >> renderPageContentOn: html [

	html div class: 'q-pa-md'; with: [
		html render: self pageComponent ]
]

{ #category : #rendering }
LoanexApp >> renderQuasarSetupOn: html [
	| exports vueRefsDefine list |

	exports := ',' join: (self quasarData, (self vueRefs keys)).

	list := OrderedCollection new.
	self vueRefs keysAndValuesDo: [ :key :value | list add: 'const ', key, ' = ref(', value asJson, ')' ].
	vueRefsDefine := ';' join: list.

	html document addLoadScript: (JSStream on:
'const { ref } = Vue;
const app = Vue.createApp({
	setup () {', vueRefsDefine, ';
		return {', exports, '}
	}
})
app.use(Quasar)
app.mount(''q-app'')')
]

{ #category : #rendering }
LoanexApp >> renderSideSheetOn: html [

	html qDrawer ref: 'sideSheet'; showIfAbove; side: 'right';
		class: 'q-pa-md';
		"class: 'bg-secondary';" style: 'background: #E0F2F1';
		with: [
			html qScrollArea class: 'fit'; with: [
				html render: self viewTask filterView ] ]
]

{ #category : #'utility - repository' }
LoanexApp >> repository [

	^ LoanexDatabase memory1
	"^ VORepository current"
]

{ #category : #'utility - repository' }
LoanexApp >> repositoryRecreateTestData [

	"LoanexDatabase repositorySetUpMemorySingleton"
]

{ #category : #'utility - repository' }
LoanexApp >> repositoryResetConnection [
	"Do nothing for memory repository"
]

{ #category : #'accessing - model' }
LoanexApp >> saveObject: anObject [

	self repository save: anObject
]

{ #category : #rendering }
LoanexApp >> themeColors [
	| result |

	result := OrderedDictionary new.

	self appSettings mdcTheme themeItems keysAndValuesDo: [ :eachKey :eachValue |
		result at: eachKey put: eachValue asHexString ].

	^ result
]

{ #category : #rendering }
LoanexApp >> themeFontFamily [

	^ self appSettings mdcTypography fontFamily
]

{ #category : #updating }
LoanexApp >> updateRootFonts: anHtmlRoot [

	super updateRootFonts: anHtmlRoot.

	anHtmlRoot stylesheet url: (WAUrl absolute: 'https://fonts.googleapis.com/css?family=Roboto Condensed')
]

{ #category : #accessing }
LoanexApp >> viewTask [
	^ viewTask
]

{ #category : #accessing }
LoanexApp >> viewTask: anObject [
	viewTask := anObject
]

{ #category : #navigation }
LoanexApp >> viewTaskGo [

	self pageComponentSet: self viewTask.
	"self layout sideSheetContent: self viewTask filterView.
	self viewTask filterView
		ifNil: [ self layout sideSheetHide ]
		ifNotNil: [ :value | self layout sideSheetUnhide ]"
]

{ #category : #navigation }
LoanexApp >> viewToyLoansGo [
	| newView |

	newView := LoanexToyLoanListView new filterView: LoanexToyLoadFilterView new; yourself.
	self pageComponentSet: newView.
	"self layout sideSheetContent: newView filterView.
	newView filterView
		ifNil: [ self layout sideSheetHide ]
		ifNotNil: [ :value | self layout sideSheetUnhide ]"
]

{ #category : #accessing }
LoanexApp >> viewUser [
	^ viewUser
]

{ #category : #accessing }
LoanexApp >> viewUser: anObject [
	viewUser := anObject
]

{ #category : #navigation }
LoanexApp >> viewUserGo [

	self pageComponentSet: self viewUser
]

{ #category : #navigation }
LoanexApp >> viewUserSetTo: aModel [
	| newView |

	self currentUser: aModel.

	aModel ifNil: [
		self viewUser: nil.
		^ self ].

	newView := aModel asComponent addValidatedForm; yourself.
	self viewUser: newView.
	self viewUserGo
]

{ #category : #accessing }
LoanexApp >> viewUsers [
	^ viewUsers
]

{ #category : #accessing }
LoanexApp >> viewUsers: anObject [
	viewUsers := anObject
]

{ #category : #navigation }
LoanexApp >> viewUsersGo [

	self pageComponentSet: self viewUsers
]
