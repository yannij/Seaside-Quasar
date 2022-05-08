Class {
	#name : #MDQOAuth1Component,
	#superclass : #WAComponent,
	#instVars : [
		'oauthService',
		'requestToken',
		'accessToken'
	],
	#category : #'Quasar-SSO'
}

{ #category : #accessing }
MDQOAuth1Component >> accessToken [
	^ accessToken
]

{ #category : #accessing }
MDQOAuth1Component >> accessToken: anObject [
	accessToken := anObject
]

{ #category : #actions }
MDQOAuth1Component >> gotoSignOn: aCallbackUrl [
	"Redirect the client to the OAuth provider to handle the sign-in and authorization."

	self oauthService hasKeys
		ifFalse: [ self error: 'Consumer key and/or secret missing.' ].

	requestToken := self oauthService getRequestTokenFor: aCallbackUrl with: nil.
	
	self requestContext
		redirectTo: (self oauthService loginUrlFor: requestToken) ; 
		respond
	
]

{ #category : #actions }
MDQOAuth1Component >> handleCallback [
	"Hanlde the callback from the OAuth provider. If the client approved our request
	we can now get the access token." 

	| request token verifier |

	request := self requestContext request.

	token := request at: 'oauth_token'.
	verifier := request at: 'oauth_verifier'.
	
	(token isNil or: [ verifier isNil])
		ifTrue: [ ^self ].
		
	token = self requestToken value
		ifFalse: [ self error: 'Invalid token value' ].
	
	self accessToken: (self oauthService getAccessToken: self requestToken verifier: verifier)
]

{ #category : #accessing }
MDQOAuth1Component >> oauthService [
	^ oauthService
]

{ #category : #accessing }
MDQOAuth1Component >> oauthService: anObject [
	oauthService := anObject
]

{ #category : #accessing }
MDQOAuth1Component >> requestToken [
	^ requestToken
]
