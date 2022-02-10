"
I am a customized version of WASessionCookieProtectionFilter that still allows access if a request (without the expected cookie) holds a time-limited token instead.

Example Usage. In the Stripe API is a checkout call, which requires a success and a failure URL. The URLs should take the user back to their context in the application, after the callout to Stripe. However, the URL would be blocked because the session cookie is not present in the scenario. The alternative token will still permit the access though.
"
Class {
	#name : #WATokenFallbackProtectionFilter,
	#superclass : #WASessionCookieProtectionFilter,
	#instVars : [
		'tokens',
		'goodToken'
	],
	#category : #'Quasar-Components'
}

{ #category : #acccessing }
WATokenFallbackProtectionFilter class >> tokenQueryFieldName [

	^ '_token'
]

{ #category : #initialization }
WATokenFallbackProtectionFilter >> createTokenCache [

	^ Dictionary new
]

{ #category : #accessing }
WATokenFallbackProtectionFilter >> goodToken [

	^ goodToken
]

{ #category : #accessing }
WATokenFallbackProtectionFilter >> goodToken: anObject [

	goodToken := anObject
]

{ #category : #initialization }
WATokenFallbackProtectionFilter >> initialize [

	super initialize.

	self tokens: self createTokenCache
]

{ #category : #accessing }
WATokenFallbackProtectionFilter >> newToken [
	| newValue |

	newValue := 1000000 atRandom.
	self tokens at: newValue printString put: DateAndTime now.
	^ newValue
]

{ #category : #accessing }
WATokenFallbackProtectionFilter >> tokens [

	^ tokens
]

{ #category : #accessing }
WATokenFallbackProtectionFilter >> tokens: anObject [

	tokens := anObject
]

{ #category : #private }
WATokenFallbackProtectionFilter >> verifyBrowserSessionIDFor: requestContext [

	^ (super verifyBrowserSessionIDFor: requestContext)
		ifTrue: [ true ]
		ifFalse: [ self verifyTokenFor: requestContext ]
]

{ #category : #private }
WATokenFallbackProtectionFilter >> verifyTokenFor: requestContext [
	| tokenFromRequest tokenCreatedTimestamp |

	tokenFromRequest := requestContext request queryFields at: self class tokenQueryFieldName ifAbsent: [ nil ].
	tokenCreatedTimestamp := self tokens at: tokenFromRequest ifAbsent: [ ^ false ].

	(DateAndTime now - tokenCreatedTimestamp) asSeconds < 600 ifTrue: [
		self addBrowserSessionIDFor: requestContext.
		^ true ].

	^ false
]
