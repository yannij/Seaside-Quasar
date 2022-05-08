Class {
	#name : #MDQLoginSSO,
	#superclass : #QuasarComponent,
	#instVars : [
		'loginState',
		'loginTitle',
		'responsePanel',
		'loginSuccessBlock'
	],
	#category : #'Quasar-SSO'
}

{ #category : #'utility - password' }
MDQLoginSSO class >> passwordHashFor: aPassword [

	^ (Base64MimeConverter mimeEncode: (ReadStream on: (SHA1 hashMessage: aPassword))) contents
]

{ #category : #readme }
MDQLoginSSO class >> readme [
	"To load the needed ZincSSO code, add the following to BaselineOf"
	| spec |

	spec
		baseline: 'ZincSSO'
		with: [ spec repository: 'github://svenvc/zinc:master/repository';
			loads: #('Zinc-SSO-OAuth1-Core' 'Zinc-SSO-OAuth2-Core') ].
]

{ #category : #state }
MDQLoginSSO >> beStateLoggedIn [

	self loginState: self stateLoggedIn
]

{ #category : #state }
MDQLoginSSO >> beStateLoggedOut [

	self loginState: self stateLoggedOut
]

{ #category : #actions }
MDQLoginSSO >> handleCallback [

	self responsePanel handleCallback.
	self responsePanel twitterAccess ifNotNil: [ :twitterAccess |
		"twitterAccess inspect."
		twitterAccess accessToken ifNotNil: [ :twitterToken |
			twitterToken screenName ifNotNil: [ :screenName |
				self beStateLoggedIn.
				self loginSuccessBlock ifNotNil: [ :block |
					block value: screenName value: #twitter ].
				Transcript crShow: screenName ] ] ]
]

{ #category : #initialization }
MDQLoginSSO >> initialize [

	super initialize.

	self beStateLoggedOut
]

{ #category : #testing }
MDQLoginSSO >> isLoggedIn [

	self responsePanel ifNotNil: [ :panel |
		^ panel accessToken notNil and: [ panel accessToken userId notNil ] ].

	^ false
]

{ #category : #state }
MDQLoginSSO >> isStateLoggedIn [

	^ self loginState = self stateLoggedIn
]

{ #category : #state }
MDQLoginSSO >> isStateLoggedOut [

	^ self loginState = self stateLoggedOut
]

{ #category : #actions }
MDQLoginSSO >> loggedOut [

	self session ifNotNil: [ :value | value unregister ].
	self mdqApplicationGet redirect
]

{ #category : #accessing }
MDQLoginSSO >> loginState [

	^ loginState
]

{ #category : #accessing }
MDQLoginSSO >> loginState: anObject [

	loginState := anObject
]

{ #category : #accessing }
MDQLoginSSO >> loginSuccessBlock [

	^ loginSuccessBlock
]

{ #category : #accessing }
MDQLoginSSO >> loginSuccessBlock: anObject [

	loginSuccessBlock := anObject
]

{ #category : #accessing }
MDQLoginSSO >> loginTitle [

	^ loginTitle
]

{ #category : #accessing }
MDQLoginSSO >> loginTitle: anObject [

	loginTitle := anObject
]

{ #category : #rendering }
MDQLoginSSO >> onClickNotYetImplementedScript: html [

	^ (html jQuery ajax)
		callback: [ :value | ];
		script: [ :s | s alert: 'Not yet implemented' ];
		yourself
]

{ #category : #rendering }
MDQLoginSSO >> renderContentOn: html [

	html qApp id: self mdqApplicationGet appId; with: [
		html div vCloak; with: [
			self renderCurrentStateOn: html ] ]
]

{ #category : #rendering }
MDQLoginSSO >> renderCurrentStateOn: html [

	html div style: 'display: flex; justify-content: center; height: 90vh; align-items: center;';
		with: [
			html qCard flat; bordered; class: 'q-pa-xs'; "style: 'width: 350px';" with: [
				self renderLoginHeaderOn: html.
				self renderSingleSignOnOn: html.
				html break.
				html div class: 'q-gutter-sm'; with: [
					self renderSignOnDevOn: html.
					self renderSignOnAnonymousOn: html ] ] ]
]

{ #category : #rendering }
MDQLoginSSO >> renderLoginHeaderOn: html [

	html div class: 'q-py-md'; with: [
		html span class: 'text-h3'; with: self loginTitle ]
]

{ #category : #rendering }
MDQLoginSSO >> renderSignOnAnonymousOn: html [

	self renderSignOnId: nil name: 'Guest' on: html
]

{ #category : #rendering }
MDQLoginSSO >> renderSignOnDevOn: html [

	self renderSignOnId: 'test' name: 'Test' on: html.
	self renderSignOnId: 'gallery' name: 'Gallery' on: html.
	self renderSignOnId: 'admin' name: 'Admin' on: html
]

{ #category : #rendering }
MDQLoginSSO >> renderSignOnId: aUserId name: aUsername on: html [

	html qBtn
		outline;
		type: 'a'; href: (html urlForAction: [
			self beStateLoggedIn.
			self loginSuccessBlock ifNotNil: [ :block |
				block value: aUserId value: nil ] ]);
		with: aUsername
]

{ #category : #rendering }
MDQLoginSSO >> renderSignOnTwitterOn: html [
	| callback url |

	callback := WAActionCallback on: [ self handleCallback ] .
	url := html actionUrl copy addField: (html callbacks store: callback).
	url takeServerParametersFromRequest: self requestContext request.

	html qBtn
		outline;
		type: 'a'; href: (html urlForAction: [ self signOnUsingOAuth1Twitter: url ]);
		"with: [
			html image
				url: (ZnSSOSeasideDemoFileLibrary urlOf: #ssoTwitterGrayPng ) ;
				title: ' Sign in with Twitter' ]."
		with: 'Twitter'
]

{ #category : #rendering }
MDQLoginSSO >> renderSingleSignOnOn: html [

	html div with: [
		html span class: 'text-caption'; with: 'Login with' ].
	html div class: 'q-gutter-sm'; with: [
		self renderSignOnTwitterOn: html.
		html qBtn outline; onClick: (self onClickNotYetImplementedScript: html); label: 'Google'.
		html qBtn outline; onClick: (self onClickNotYetImplementedScript: html); label: 'Facebook'.
		html qBtn outline; onClick: (self onClickNotYetImplementedScript: html); label: 'GitHub'.
		html qBtn outline; onClick: (self onClickNotYetImplementedScript: html); label: 'Stripe' ]
]

{ #category : #accessing }
MDQLoginSSO >> responsePanel [

	^ responsePanel
]

{ #category : #accessing }
MDQLoginSSO >> responsePanel: anObject [

	responsePanel := anObject
]

{ #category : #actions }
MDQLoginSSO >> signOnUsingOAuth1Twitter: aCallbackUrl [
	
	self responsePanel: MDQTwitterOAuth1Component new.
	self responsePanel gotoSignOn: aCallbackUrl
]

{ #category : #state }
MDQLoginSSO >> stateLoggedIn [

	^ #LoggedIn
]

{ #category : #state }
MDQLoginSSO >> stateLoggedOut [

	^ #LoggedOut
]
