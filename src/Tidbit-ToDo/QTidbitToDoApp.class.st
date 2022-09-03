"
I am an example ToDo app, built using Seaside-Quasar, Magritte, and Voyage/Mongo
"
Class {
	#name : #QTidbitToDoApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'loginComponent',
		'pageComponent',
		'currentUser',
		'viewStyleDark',
		'viewStyleDense',
		'viewStyleTextField',
		'sideSheetOpen',
		'sideNavOpen',
		'settingsView',
		'viewMap',
		'viewUser',
		'viewUsers',
		'viewTask',
		'viewTaskFilter',
		'appSettings'
	],
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #'class initialization' }
QTidbitToDoApp class >> applicationPath [

	^ 'tidbit/quaser-todo'
]

{ #category : #'class initialization' }
QTidbitToDoApp class >> dockerDeployPostLoad [
	<dockerDeployPostLoad>

	WAComponent mdqPublicServerUrlInstallDockerConfig
]

{ #category : #'class initialization' }
QTidbitToDoApp class >> dockerDeployPreLoad [
	<dockerDeployPreLoad>

	DockerDeploy current configNamesAdd: DockerDeploy defaultConfigName
]

{ #category : #'class initialization' }
QTidbitToDoApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QTidbitToDoApp class >> viewStyleTextFieldFilled [

	^ #filled
]

{ #category : #accessing }
QTidbitToDoApp class >> viewStyleTextFieldOutlined [

	^ #outlined
]

{ #category : #testing }
QTidbitToDoApp >> anonymousLoginAllowed [

	^ "false" true
]

{ #category : #accessing }
QTidbitToDoApp >> appSettings [

	^ appSettings
]

{ #category : #accessing }
QTidbitToDoApp >> appSettings: anObject [

	appSettings := anObject
]

{ #category : #accessing }
QTidbitToDoApp >> applicationTitle [

	^ 'Tidbit ToDo'
]

{ #category : #'utility - login' }
QTidbitToDoApp >> authenticateUsername: aUsername password: aPassword [
	"Answer a user instance if hashed pssword matches saved passwrodHass,
	or answer nil is does not match, or user not found"

	^ (self findUser: aUsername)
		ifNil: [ nil ]
		ifNotNil: [ :value |
			value passwordHash = (MDQLogin passwordHashFor: (aPassword ifNil: [ '' ] ifNotNil: [ :arg | arg ]))
				ifTrue: [ value ]
				ifFalse: [ nil ] ]
]

{ #category : #initialization }
QTidbitToDoApp >> buildApplicationSettings [

	^ MDQApplicationSettings new
]

{ #category : #rendering }
QTidbitToDoApp >> buildColorTheme [

	^ MDQTheme fromString:
'{
	"name": "Tidbit",
	"isDark": false,
	"colors": {
		"primary": "#1976d2",
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
QTidbitToDoApp >> buildLoginComponent [

	^ MDQLogin new
		loginTitle: self applicationTitle;
		loginId: 'demo, guset, user1-10';
		password: 'secret';
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

{ #category : #actions }
QTidbitToDoApp >> configureStyle [
	| tmp |

	tmp := self bodyRegion component.
	self bodyRegion component: self settingsView.
	self settingsView: tmp
]

{ #category : #accessing }
QTidbitToDoApp >> currentUser [

	^ currentUser
]

{ #category : #accessing }
QTidbitToDoApp >> currentUser: anObject [

	currentUser := anObject
]

{ #category : #'utility - login' }
QTidbitToDoApp >> findUser: aUsername [
	"Answer the user having username matching aUsername, or nil if not found"

	^ (self repository selectAll: TidbitUser)
		ifEmpty: [ nil ]
		ifNotEmpty: [ :value | value detect: [ :eachUser | eachUser username = aUsername ] ifNone: [ nil ] ]
]

{ #category : #initialization }
QTidbitToDoApp >> initialize [

	super initialize.

	self colorTheme: self buildColorTheme.

	self sideNavOpen: ((QuasarRefSyncClientToServer name: 'sideNavOpen' value: true) callbackBlock: [ :value | value not ]; yourself).
	self sideSheetOpen: ((QuasarRefSyncClientToServer name: 'sideSheetOpen' value: false) callbackBlock: [ :value | value not ]; yourself).
	self viewStyleDark: ((QuasarRefSyncClientToServer name: 'viewStyleDark' value: false)
			callbackBlock: [ :value | value not ];
			onSuccessScript: '$q.dark.set(viewStyleDark.value);';
			yourself).
	self viewStyleTextField: #filled.
	self viewStyleDense: false.

	self reactiveObjectsAdd: self sideNavOpen.
	self reactiveObjectsAdd: self sideSheetOpen.
	self reactiveObjectsAdd: self viewStyleDark.

	self initializeLayout
]

{ #category : #initialization }
QTidbitToDoApp >> initializeLayout [

	self loginComponent: self buildLoginComponent.
	self viewMap: IdentityDictionary new.
	self viewMapAt: #Tools put: TidbitViewTools new.
	self viewUsers: QTidbitViewUsers new.
	self viewTask: QTidbitViewTask new.
	self viewTaskFilter: QTidbitViewTaskSideSheet new.

	self appSettings: self buildApplicationSettings.
	self settingsView: MDQApplicationSettingsView new.
]

{ #category : #accessing }
QTidbitToDoApp >> loginComponent [

	^ loginComponent
]

{ #category : #accessing }
QTidbitToDoApp >> loginComponent: anObject [

	loginComponent := anObject
]

{ #category : #navigation }
QTidbitToDoApp >> navTo: aModel [

	self navTo: aModel aspect: nil
]

{ #category : #navigation }
QTidbitToDoApp >> navTo: aModel  aspect: anAspect [
	| newView |

	aModel ifNil: [ ^ self ].

	newView := aModel asComponent
					addValidatedForm;
					"addMessage: 'hello';"
					yourself.

	self pageComponentSet: newView.
	self sideSheetHide
]

{ #category : #navigation }
QTidbitToDoApp >> navToCustomView: aView [

	self pageComponentSet: aView.
	self sideSheetHide
]

{ #category : #'utility - login' }
QTidbitToDoApp >> newUsername: aUsername password: aPassword [
	| userModel |

	userModel := TidbitUser new
		username: aUsername;
		fullName: aUsername;
		passwordHash: (MDQLogin passwordHashFor: aPassword);
		yourself.

	self repository save: userModel.

	^ userModel

]

{ #category : #accessing }
QTidbitToDoApp >> pageComponent [

	^ pageComponent
]

{ #category : #accessing }
QTidbitToDoApp >> pageComponent: anObject [

	pageComponent := anObject
]

{ #category : #accessing }
QTidbitToDoApp >> pageComponentSet: anObject [

	self quasarDataClear.
	self pageComponent: anObject
]

{ #category : #'rendering - quasar hooks' }
QTidbitToDoApp >> quasarSetupReturnContentOn: aJSStream with: anAjaxFactory [
	| exports |

	exports := ',' join: (self quasarData, (self vueRefs keys)).

	aJSStream nextPutAll: exports
]

{ #category : #'utility - login' }
QTidbitToDoApp >> registerUsername: aUsername password: aPassword [
	"Answer a new user instance built from the userId/password,
	or answer nil user already exists"

	^ (self findUser: aUsername)
		ifNil: [ self newUsername: aUsername password: aPassword ]
		ifNotNil: [ :value | "User already exists" nil ]
]

{ #category : #rendering }
QTidbitToDoApp >> renderBtnLabel: aLabel icon: iconName dense: denseFlag callback: actionBlock on: html [

	html qBtn
		flat; round; denseIf: denseFlag; icon: iconName;
		type: 'a'; href: (html urlForAction: actionBlock)
]

{ #category : #rendering }
QTidbitToDoApp >> renderHeaderOn: html [
	| denseFlag |

	denseFlag := self viewStyleDense.

	html qHeader heightHint: 98; with: [
		html qToolbar with: [
			html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'sideNavOpenRefSync($event)'.
			html qToolbarTitle with: [ html text: 'Tidbit' ].
			true
				ifTrue: [ self renderBtnLabel: 'Logout' icon: 'logout' dense: denseFlag callback: [ self logout ] on: html ]
				ifFalse: [ self renderBtnLabel: 'Login' icon: 'login' dense: denseFlag callback: [ "self login" ] on: html ].
			html qBtn flat; round; denseIf: denseFlag; icon: 'dark_mode'; vOnClick: 'viewStyleDarkRefSync($event)'.
			self renderBtnLabel: 'Dense' icon: 'view_compact_alt' dense: denseFlag callback: [ self viewStyleDenseToggle ] on: html.
			self renderBtnLabel: 'Fields' icon: 'credit_card' dense: denseFlag callback: [ self viewStyleTextFieldToggle ] on: html.
			html qBtn dense; flat; round; icon: 'filter'; vOnClick: 'sideSheetOpenRefSync($event)' ] ]
]

{ #category : #rendering }
QTidbitToDoApp >> renderLayoutOn: html [

	"html script: 'document.body.style.setProperty(''--q-primary'', ''#00695C'')'.
	html script: 'document.body.style.setProperty(''--q-secondary'', ''#EF6C00'')'."
	self renderSetColorTheme: self colorTheme on: html.

	self isLoggedIn
		ifTrue: [ self renderTidbitOn: html ]
		ifFalse: [
			self loginComponent
				ifNotNil: [ :value | html render: value  ]
				ifNil: [
					self anonymousLoginAllowed
						ifTrue: [ self renderTidbitOn: html ]
						ifFalse: [
							self loginComponent ifNil: [ self loginComponent: self buildLoginComponent ].
							html render: self loginComponent ] ] ]
]

{ #category : #rendering }
QTidbitToDoApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage padding; with: [
			html render: self pageComponent ] ]
]

{ #category : #rendering }
QTidbitToDoApp >> renderLeftDrawerOn: html [

	html qDrawer
		ref: 'sideNav'; showIfAbove; side: 'left';
		vIf: 'sideNavOpen';
		"class: 'bg-secondary'; style: 'color: white';"
		style: 'background: blue-2';
		with: [
			html qScrollArea class: 'fit'; with: [
				"self renderNavBrandingOn: html."
				self renderNavOn: html ] ]
]

{ #category : #rendering }
QTidbitToDoApp >> renderNavOn: html [
	| navList |

	navList := OrderedCollection new
		add: #('Home' 'home') -> [ self viewUserGo ];
		add: #('Tasks' 'checklist') -> [ self viewTaskGo ];
		add: #('Users' 'perm_identity') -> [ self viewUsersGo ];
		add: #('Tools' 'build_circle') -> [ self viewToolsGo ];
		yourself.

	html qList
		denseIf: self viewStyleDense;
		with: [
			navList do: [ :eachItem |
				html qItem
					qTag: 'a'; href: (html urlForAction: eachItem value);
					with: [
						html qItemSection avatar; with: [
							html qIcon name: eachItem key second ].
						html qItemSection with: eachItem key first ] ] ]
]

{ #category : #rendering }
QTidbitToDoApp >> renderSideSheetOn: html [

	html qDrawer
		ref: 'sideSheet'; showIfAbove; side: 'right';
		vIf: 'sideSheetOpen';
		class: 'q-pa-md';
		"class: 'bg-secondary';" style: 'background: #E0F2F1';
		with: [
			html qScrollArea class: 'fit'; with: [
				html render: self viewTaskFilter ] ]
]

{ #category : #rendering }
QTidbitToDoApp >> renderTidbitOn: html [

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; vCloak; with: [
			self renderHeaderOn: html.
			self renderLeftDrawerOn: html.
			self renderLayoutPageOn: html.
			self renderSideSheetOn: html.
			"self renderBottomSheetOn: html."
			"self renderSettingsFabOn: html" ] ]
]

{ #category : #'utility - repository' }
QTidbitToDoApp >> repository [

	^ TidbitExampleDatabase memory1
	"^ VORepository current"
]

{ #category : #'utility - repository' }
QTidbitToDoApp >> repositoryRecreateTestData [

	TidbitExampleDatabase repositorySetUpMemorySingleton
]

{ #category : #'utility - repository' }
QTidbitToDoApp >> repositoryResetConnection [
	"Do nothing for memory repository"
]

{ #category : #'accessing - model' }
QTidbitToDoApp >> saveObject: anObject [

	self repository save: anObject
]

{ #category : #accessing }
QTidbitToDoApp >> settingsView [

	^ settingsView
]

{ #category : #accessing }
QTidbitToDoApp >> settingsView: anObject [

	settingsView := anObject
]

{ #category : #accessing }
QTidbitToDoApp >> sideNavOpen [

	^ sideNavOpen
]

{ #category : #accessing }
QTidbitToDoApp >> sideNavOpen: anObject [

	sideNavOpen := anObject
]

{ #category : #actions }
QTidbitToDoApp >> sideSheetHide [
	"Todo"
]

{ #category : #accessing }
QTidbitToDoApp >> sideSheetOpen [

	^ sideSheetOpen
]

{ #category : #accessing }
QTidbitToDoApp >> sideSheetOpen: anObject [

	sideSheetOpen := anObject
]

{ #category : #rendering }
QTidbitToDoApp >> themeColors [
	| result |

	result := OrderedDictionary new.

	self appSettings mdqTheme themeItems keysAndValuesDo: [ :eachKey :eachValue |
		result at: eachKey put: eachValue asHexString ].

	^ result
]

{ #category : #rendering }
QTidbitToDoApp >> themeFontFamily [

	^ self appSettings mdqTypography fontFamily
]

{ #category : #updating }
QTidbitToDoApp >> updateRootFonts: anHtmlRoot [

	super updateRootFonts: anHtmlRoot.

	"fontNames := 'Roboto|Roboto+Condensed|Bree+Serif|Fontdiner+Swanky|Open+Sans|Oxygen+Mono|Pacifico'."
	"fontNames := '|' join: (self fonts collect: [:eachChoice | eachChoice googleFontsFamily])."

	anHtmlRoot stylesheet url: (WAUrl absolute: 'https://fonts.googleapis.com/css?family=', self appSettings mdqTypography fontFamily).
	self appSettings mdqTypography fontFamilies do: [ :eachFontFamily |
		anHtmlRoot stylesheet url: (WAUrl absolute: 'https://fonts.googleapis.com/css?family=', eachFontFamily) ]
]

{ #category : #accessing }
QTidbitToDoApp >> viewMap [
	^ viewMap
]

{ #category : #accessing }
QTidbitToDoApp >> viewMap: anObject [
	viewMap := anObject
]

{ #category : #accessing }
QTidbitToDoApp >> viewMapAt: aKey [

	self viewMapAt: aKey ifAbsent: [ nil ]
]

{ #category : #accessing }
QTidbitToDoApp >> viewMapAt: aKey ifAbsent: aBlock [

	self viewMap at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
QTidbitToDoApp >> viewMapAt: aKey put: aContentArea [

	self viewMap at: aKey put: aContentArea
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleDark [

	^ viewStyleDark
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleDark: anObject [

	viewStyleDark := anObject
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleDarkToggle [

	self viewStyleDark: self viewStyleDark not
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleDense [

	^ viewStyleDense
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleDense: anObject [

	viewStyleDense := anObject
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleDenseToggle [

	self viewStyleDense: self viewStyleDense not
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleFilled [

	^ self "session" viewStyleTextFieldIsFilled
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleOutlined [

	^ self "session" viewStyleTextFieldIsOutlined
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleTextField [

	^ viewStyleTextField
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleTextField: anObject [

	viewStyleTextField := anObject
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleTextFieldIsFilled [

	^ self viewStyleTextField = self class viewStyleTextFieldFilled
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleTextFieldIsOutlined [

	^ self viewStyleTextFieldIsFilled not
]

{ #category : #accessing }
QTidbitToDoApp >> viewStyleTextFieldToggle [

	^ self viewStyleTextFieldIsFilled
		ifTrue: [ self viewStyleTextField: self class viewStyleTextFieldOutlined ]
		ifFalse: [ self viewStyleTextField: self class viewStyleTextFieldFilled ]
]

{ #category : #accessing }
QTidbitToDoApp >> viewTask [
	^ viewTask
]

{ #category : #accessing }
QTidbitToDoApp >> viewTask: anObject [
	viewTask := anObject
]

{ #category : #accessing }
QTidbitToDoApp >> viewTaskFilter [
	^ viewTaskFilter
]

{ #category : #accessing }
QTidbitToDoApp >> viewTaskFilter: anObject [
	viewTaskFilter := anObject
]

{ #category : #navigation }
QTidbitToDoApp >> viewTaskGo [

	self pageComponentSet: self viewTask.
	"self layout sideSheetUnhide"
]

{ #category : #navigation }
QTidbitToDoApp >> viewToolsGo [

	self pageComponentSet: (self viewMap at: #Tools)
]

{ #category : #accessing }
QTidbitToDoApp >> viewUser [
	^ viewUser
]

{ #category : #accessing }
QTidbitToDoApp >> viewUser: anObject [
	viewUser := anObject
]

{ #category : #navigation }
QTidbitToDoApp >> viewUserGo [

	self pageComponentSet: self viewUser
]

{ #category : #navigation }
QTidbitToDoApp >> viewUserSetTo: aModel [
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
QTidbitToDoApp >> viewUsers [
	^ viewUsers
]

{ #category : #accessing }
QTidbitToDoApp >> viewUsers: anObject [
	viewUsers := anObject
]

{ #category : #navigation }
QTidbitToDoApp >> viewUsersGo [

	self pageComponentSet: self viewUsers
]
