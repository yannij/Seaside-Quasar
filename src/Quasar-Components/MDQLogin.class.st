Class {
	#name : #MDQLogin,
	#superclass : #QuasarComponent,
	#instVars : [
		'loginState',
		'loginTitle',
		'loginId',
		'password',
		'tokenTyped',
		'tokenSent',
		'authenticationBlock',
		'recoverBlock',
		'registerBlock',
		'sendTokenBlock',
		'responsePanel'
	],
	#category : #'Quasar-Components'
}

{ #category : #'utility - password' }
MDQLogin class >> passwordHashFor: aPassword [

	^ (Base64MimeConverter mimeEncode: (ReadStream on: (SHA1 hashMessage: aPassword))) contents
]

{ #category : #'model - api' }
MDQLogin >> attemptRecovery [
	| userOrNil |

	userOrNil := self recoverBlock
		ifNil: [ nil ]
		ifNotNil: [ :block | block value: self loginId value: self tokenTyped value: self tokenSent ].

	userOrNil
		ifNotNil: [
			self transitionOnEvent: self eventTokenMatch.
			self transitionOnEvent: self eventContinue ]
		ifNil: [ self transitionOnEvent: self eventTokenMismatch ]
]

{ #category : #'model - api' }
MDQLogin >> authenticate: aLoginId password: aPassword [

	self authenticationBlock
		ifNotNil: [ :theBlock |
			| userOrNil |
			userOrNil := theBlock value: aLoginId value: aPassword.
			userOrNil
				ifNil: [ self transitionOnEvent: self eventPasswordMismatch ]
				ifNotNil: [ self transitionOnEvent: self eventPasswordMatch ] ]
]

{ #category : #accessing }
MDQLogin >> authenticationBlock [
	^ authenticationBlock
]

{ #category : #accessing }
MDQLogin >> authenticationBlock: anObject [
	authenticationBlock := anObject
]

{ #category : #'model - api' }
MDQLogin >> beginLoggingIn [

	self password: String new.
	self transitionOnEvent: self eventLoginStart
]

{ #category : #'model - api' }
MDQLogin >> beginRecovering [

	self transitionOnEvent: self eventRecover
]

{ #category : #'model - api' }
MDQLogin >> beginRegistration [

	self transitionOnEvent: self eventRegister
]

{ #category : #private }
MDQLogin >> clearInputs [

	self loginId: String new.
	self password: String new.
	self tokenTyped: String new.
	self tokenSent: String new.

]

{ #category : #'model - api' }
MDQLogin >> confirmRegistration [

	self tokenTyped = self tokenSent
		ifFalse: [
			self mdqApplicationGet logFormat: 'Token mismatch: tokenTyped={1}, tokenSent={2}' with: self tokenTyped with: self tokenSent. 
			self transitionOnEvent: self eventTokenMismatch ]
		ifTrue: [
			self registerBlock
				ifNotNil: [ :theBlock |
					| userOrNil |
					userOrNil := theBlock value: self loginId value: self password.
					userOrNil
						ifNil: [ self error: 'Failed to create user: ', self loginId ]
						ifNotNil: [
							self clearInputs.
							self transitionOnEvent: self eventTokenMatch ] ] ]
]

{ #category : #'model - events' }
MDQLogin >> eventContinue [

	^ #Continue
]

{ #category : #'model - events' }
MDQLogin >> eventLoginStart [

	^ #LoginStart
]

{ #category : #'model - events' }
MDQLogin >> eventLogout [

	^ #Logout
]

{ #category : #'model - events' }
MDQLogin >> eventPasswordMatch [

	^ #PasswordMatch
]

{ #category : #'model - events' }
MDQLogin >> eventPasswordMismatch [

	^ #PasswordMismatch
]

{ #category : #'model - events' }
MDQLogin >> eventRecover [

	^ #Recover
]

{ #category : #'model - events' }
MDQLogin >> eventRegister [

	^ #Register
]

{ #category : #'model - events' }
MDQLogin >> eventTokenMatch [

	^ #TokenMatch
]

{ #category : #'model - events' }
MDQLogin >> eventTokenMismatch [

	^ #TokenMismatch
]

{ #category : #'model - events' }
MDQLogin >> eventTokenSent [

	^ #TokenSent
]

{ #category : #initialization }
MDQLogin >> initialize [

	super initialize.

	self loginState: self stateLoggingIn.
	self loginTitle: self loginTitleDefault.
	self loginId: String new.
	self password: String new.
]

{ #category : #testing }
MDQLogin >> isLoggedIn [

	^ self loginState = self stateLoggedIn
]

{ #category : #'model - api' }
MDQLogin >> loggedIn [

	self transitionOnEvent: self eventContinue
]

{ #category : #'model - api' }
MDQLogin >> loggedOut [

	self transitionOnEvent: self eventLogout.

	self session ifNotNil: [ :value | value unregister ].
	self mdqApplicationGet redirect
]

{ #category : #accessing }
MDQLogin >> loginId [
	^ loginId
]

{ #category : #accessing }
MDQLogin >> loginId: anObject [
	loginId := anObject
]

{ #category : #accessing }
MDQLogin >> loginState [
	^ loginState
]

{ #category : #accessing }
MDQLogin >> loginState: anObject [
	loginState := anObject
]

{ #category : #accessing }
MDQLogin >> loginTitle [
	^ loginTitle
]

{ #category : #accessing }
MDQLogin >> loginTitle: anObject [
	loginTitle := anObject
]

{ #category : #initialization }
MDQLogin >> loginTitleDefault [

	^ 'MDQ Seaside'
]

{ #category : #rendering }
MDQLogin >> onClickNotYetImplementedScript: html [

	^ (html jQuery ajax)
		callback: [ :value | ];
		script: [ :s | s alert: 'Not yet implemented' ];
		yourself
]

{ #category : #accessing }
MDQLogin >> password [
	^ password
]

{ #category : #accessing }
MDQLogin >> password: anObject [
	password := anObject
]

{ #category : #accessing }
MDQLogin >> recoverBlock [
	^ recoverBlock
]

{ #category : #accessing }
MDQLogin >> recoverBlock: anObject [
	recoverBlock := anObject
]

{ #category : #'model - api' }
MDQLogin >> register: aLoginId password: aPassword [

	self registerBlock
		ifNotNil: [ :theBlock |
			| userOrNil |
			userOrNil := theBlock value: aLoginId value: aPassword.
			userOrNil
				ifNil: [ self error: 'Failed to create user: ', aLoginId ]
				ifNotNil: [
					self sendToken.
					self transitionOnEvent: self eventTokenSent ] ]
]

{ #category : #accessing }
MDQLogin >> registerBlock [
	^ registerBlock
]

{ #category : #accessing }
MDQLogin >> registerBlock: anObject [
	registerBlock := anObject
]

{ #category : #rendering }
MDQLogin >> renderButton: aButtonText callback: aBlock on: html [

	html div class: 'q-py-sm'; with: [
		"html qBtn unelevated; outline;
			type: 'submit';"
		html submitButton
			callback: aBlock;
			"onClick: ((html jQuery ajax)
				callback: [ :value | self authenticate: value ] value: ((html jQuery id: passwordComponent htmlIdPassword) value);
				script: [ :s | s alert: 'The submitted value is: ''', self password, '''.' ];
				onComplete: html javascript refresh;
				yourself);"
			with: aButtonText ]
]

{ #category : #rendering }
MDQLogin >> renderButtonInline: aButtonText caption: aCaptionText callback: aBlock on: html [

	html div class: 'text-right'; class: 'q-pt-sm'; with: [
		html span class: 'text-caption'; with: aCaptionText.
		html space.
		html qBtn unelevated; outline; "class: 'q-px-none';" type: 'a'; href: (html urlForAction: aBlock); with: aButtonText ]
]

{ #category : #rendering }
MDQLogin >> renderCaption: aString on: html [

	html div style: 'margin: 4px auto 0px auto; width: 300px; text-align: left'; with: [
		html span class: 'text-caption'; with: aString ]
]

{ #category : #rendering }
MDQLogin >> renderContentOn: html [

	html qApp id: self mdqApplicationGet appId; with: [
		self renderCurrentStateOn: html ]
]

{ #category : #rendering }
MDQLogin >> renderCurrentStateOn: html [
	| renderMap |

	renderMap := IdentityDictionary new
		at: self stateLoggedIn put: #renderLoggedInOn:;
		at: self stateLoggingIn put: #renderLoggingInOn:;
		at: self stateRecovered put: #renderRecoveredOn:;
		at: self stateRecovering put: #renderRecoveringOn:;
		at: self stateRecoveryStarted put: #renderRecoveryStartedOn:;
		at: self stateRegistered put: #renderRegisteredOn:;
		at: self stateRegistering put: #renderRegisteringOn:;
		at: self stateRegistrationStarted put: #renderRegistrationStartedOn:;
		yourself.

	html div style: 'display: flex; justify-content: center; height: 100vh; align-items: center;'; with: [
		html qCard flat; bordered; class: 'q-pa-xs'; with: [
			(renderMap at: self loginState ifAbsent: [ nil ]) ifNotNil: [ :value |
				self perform: value with: html ] ] ]
]

{ #category : #rendering }
MDQLogin >> renderField: aLabel type: anInputType for: anAspect on: html [
	| fieldId |

	html div class: 'q-py-sm'; with: [
		html div class: 'q-gutter-y-sm column'; with: [
			"html html: '<q-input filled v-model=""text"" label=""Label""></q-input>'"
			fieldId := html nextId.
			html textInput
				type: anInputType;
				attributeAt: 'step' put: '1';
				on: anAspect of: self.
			"html qInput filled; label: aLabel; type: anInputType; modelValue: (self perform: anAspect)" ]]
]

{ #category : #rendering }
MDQLogin >> renderFieldPassword: aLabel for: anAspect on: html [

	self renderField: aLabel type: 'password' for: anAspect on: html
]

{ #category : #rendering }
MDQLogin >> renderFieldText: aLabel for: anAspect on: html [

	self renderField: aLabel type: 'text' for: anAspect on: html
]

{ #category : #rendering }
MDQLogin >> renderLineOn: html [

	html horizontalRule style: 'border-top: 1px dashed black; margin: 12px auto 8px auto; width: 300px'
]

{ #category : #'rendering - model' }
MDQLogin >> renderLoggedInOn: html [

	self renderLoginHeaderOn: html.

	self renderLineOn: html.
	self renderCaption: 'Welcome' on: html
]

{ #category : #'rendering - model' }
MDQLogin >> renderLoggingInOn: html [

	self renderLoginHeaderOn: html.

	self renderSingleSignOnOn: html.

	self renderLineOn: html.
	self renderCaption: 'Or use your email to login' on: html.

	html form with: [
		self renderLoginIdOn: html.
		self renderPasswordOn: html.
		html div class: 'text-right'; with: [
			self renderButton: 'Login' callback: [ self authenticate: self loginId password: self password ] on: html ] ].

	"html qSeparator."
	self renderButtonInline: 'Recover' caption: 'Forgot password ?' callback: [ self beginRecovering ] on: html.
	self renderButtonInline: 'Register' caption: 'Don''t have an account ?' callback: [ self beginRegistration ] on: html.

]

{ #category : #rendering }
MDQLogin >> renderLoginHeaderOn: html [

	html div class: 'text-center text-uppercase'; style: 'font-size: 3rem'; with: self loginTitle
]

{ #category : #rendering }
MDQLogin >> renderLoginIdOn: html [

	self renderFieldText: 'Your email or user ID' for: #loginId on: html
]

{ #category : #rendering }
MDQLogin >> renderPasswordOn: html [

	self renderFieldPassword: 'Password' for: #password on: html
]

{ #category : #'rendering - model' }
MDQLogin >> renderRecoveredOn: html [

	self renderLoginHeaderOn: html.

	self renderLineOn: html.
	self renderCaption: 'Recovered' on: html.

	self renderSpacerOn: html.
	self renderButtonInline: 'Continue' caption: '' callback: [ self loggedIn ] on: html.
]

{ #category : #'rendering - model' }
MDQLogin >> renderRecoveringOn: html [

	self renderLoginHeaderOn: html.

	self renderLineOn: html.
	self renderCaption: 'Enter recovery token' on: html.

	html form with: [
		self renderTokenTypedOn: html.
		self renderButton: 'Recover' callback: [ self attemptRecovery ] on: html ].

	self renderSpacerOn: html.
	self renderButtonInline: 'Login here' caption: 'Already a member ?' callback: [ self beginLoggingIn ] on: html.
]

{ #category : #'rendering - model' }
MDQLogin >> renderRecoveryStartedOn: html [

	self renderLoginHeaderOn: html.

	self renderLineOn: html.
	self renderCaption: 'Reset account' on: html.

	html form with: [
		self renderLoginIdOn: html.
		self renderButton: 'Reset' callback: [ self sendToken ] on: html ].

	self renderSpacerOn: html.
	self renderButtonInline: 'Login here' caption: 'Already a member ?' callback: [ self beginLoggingIn ] on: html.
]

{ #category : #'rendering - model' }
MDQLogin >> renderRegisteredOn: html [

	self renderLoginHeaderOn: html.

	self renderLineOn: html.
	self renderCaption: 'Registered successfully !' on: html.

	self renderSpacerOn: html.
	self renderButtonInline: 'Continue' caption: '' callback: [ self loggedIn ] on: html.
]

{ #category : #'rendering - model' }
MDQLogin >> renderRegisteringOn: html [

	self renderLoginHeaderOn: html.

	self renderLineOn: html.
	self renderCaption: 'Enter registration token' on: html.

	html form with: [
		self renderTokenTypedOn: html.
		self renderButton: 'Submit' callback: [ self confirmRegistration ] on: html ].

	self renderSpacerOn: html.
	self renderButtonInline: 'Login here' caption: 'Already a member ?' callback: [ self beginLoggingIn ] on: html.
]

{ #category : #'rendering - model' }
MDQLogin >> renderRegistrationStartedOn: html [

	self renderLoginHeaderOn: html.

	self renderLineOn: html.
	self renderCaption: 'Create new account' on: html.

	html form with: [
		self renderLoginIdOn: html.
		self renderPasswordOn: html.
		self renderButton: 'Register me' callback: [ self sendToken ] on: html ].

	self renderSpacerOn: html.
	self renderButtonInline: 'Login here' caption: 'Already a member ?' callback: [ self beginLoggingIn ] on: html.
]

{ #category : #rendering }
MDQLogin >> renderSingleSignOnOn: html [

	html div style: 'margin: 0px auto; width: 300px; text-align: left'; with: [
		html span class: 'text-caption'; with: 'Login with' ].
	html div style: 'margin: 0px auto; width: 300px; text-align: center'; with: [
		html qBtn outline;
			onClick: (self onClickNotYetImplementedScript: html);
			with: 'Google'.
		html qBtn outline;
			onClick: (self onClickNotYetImplementedScript: html);
			with: 'Twitter'.
		html qBtn outline;
			onClick: (self onClickNotYetImplementedScript: html);
			with: 'Facebook' ]
]

{ #category : #rendering }
MDQLogin >> renderSpacerOn: html [

	html break
]

{ #category : #rendering }
MDQLogin >> renderTokenTypedOn: html [

	self renderFieldPassword: 'Token' for: #tokenTyped on: html
]

{ #category : #'model - api' }
MDQLogin >> sendToken [
	| token |

	token := self sendTokenTo: self loginId.
	token ifNotNil: [ :value | self tokenSent: token ].

	self transitionOnEvent: self eventTokenSent
]

{ #category : #accessing }
MDQLogin >> sendTokenBlock [
	^ sendTokenBlock
]

{ #category : #accessing }
MDQLogin >> sendTokenBlock: anObject [
	sendTokenBlock := anObject
]

{ #category : #private }
MDQLogin >> sendTokenTo: aLoginId [

	^ self sendTokenBlock
		ifNil: [ nil ]
		ifNotNil: [ :block | block value: self loginId ]
]

{ #category : #'model - states' }
MDQLogin >> stateLoggedIn [

	^ #Authenticated
]

{ #category : #'model - states' }
MDQLogin >> stateLoggedOut [

	^ #LoggedOut
]

{ #category : #'model - states' }
MDQLogin >> stateLoggingIn [

	^ #LoggingIn
]

{ #category : #'model - states' }
MDQLogin >> stateRecovered [

	^ #Recovered
]

{ #category : #'model - states' }
MDQLogin >> stateRecovering [

	^ #Recovering
]

{ #category : #'model - states' }
MDQLogin >> stateRecoveryStarted [

	^ #RecoveryStarted
]

{ #category : #'model - states' }
MDQLogin >> stateRegistered [

	^ #Registered
]

{ #category : #'model - states' }
MDQLogin >> stateRegistering [

	^ #Registering
]

{ #category : #'model - states' }
MDQLogin >> stateRegistrationStarted [

	^ #RegistrationStarted
]

{ #category : #accessing }
MDQLogin >> tokenSent [
	^ tokenSent
]

{ #category : #accessing }
MDQLogin >> tokenSent: anObject [
	tokenSent := anObject
]

{ #category : #accessing }
MDQLogin >> tokenTyped [
	^ tokenTyped
]

{ #category : #accessing }
MDQLogin >> tokenTyped: anObject [
	tokenTyped := anObject
]

{ #category : #'model - events' }
MDQLogin >> transitionOnEvent: anEvent [
	| currentState nextState |

	anEvent = self eventLoginStart ifTrue: [ ^ self loginState: self stateLoggingIn ].

	currentState := self loginState.
	"Stay in same state when not specified, to avoid noise from error"
	nextState := currentState.

	currentState = self stateLoggingIn ifTrue: [
		anEvent = self eventPasswordMismatch ifTrue: [ nextState := self stateLoggingIn ].
		anEvent = self eventPasswordMatch ifTrue: [ nextState := self stateLoggedIn ].
		anEvent = self eventRecover ifTrue: [ nextState := self stateRecoveryStarted ].
		anEvent = self eventRegister ifTrue: [ nextState := self stateRegistrationStarted ] ].

	currentState = self stateRecoveryStarted ifTrue: [
		anEvent = self eventTokenSent ifTrue: [ nextState := self stateRecovering ] ].

	currentState = self stateRecovering ifTrue: [
		anEvent = self eventTokenMatch ifTrue: [ nextState := self stateRecovered ].
		anEvent = self eventTokenMismatch ifTrue: [ nextState := self stateRecovering ] ].

	currentState = self stateRecovered ifTrue: [
		anEvent = self eventContinue ifTrue: [ nextState := self stateLoggedIn ] ].

	currentState = self stateRegistrationStarted ifTrue: [
		anEvent = self eventTokenSent ifTrue: [ nextState := self stateRegistering ] ].

	currentState = self stateRegistering ifTrue: [
		anEvent = self eventTokenMatch ifTrue: [ nextState := self stateRegistered.
		anEvent = self eventTokenMismatch ifTrue: [ nextState := self stateRegistering ] ] ].

	currentState = self stateRegistered ifTrue: [
		anEvent = self eventContinue ifTrue: [ nextState := self stateLoggedIn ] ].

	currentState = self stateLoggedIn ifTrue: [
		anEvent = self eventLogout ifTrue: [ nextState := self stateLoggedOut ] ].

	nextState = #none
		ifTrue: [ self error: self printString, ' has no transition from: ', currentState printString, ' on: ', anEvent printString ]
		ifFalse: [
			self mdqApplicationGet logFormat: '{1}: {2} -> {3} on {4}' with: self printString with: currentState printString with: nextState printString with: anEvent printString.
			self loginState: nextState ]
]
