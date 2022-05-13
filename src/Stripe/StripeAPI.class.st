"
I handle the communication with the ""stripe API"" (https://stripe.com/docs/api)
"
Class {
	#name : #StripeAPI,
	#superclass : #Object,
	#classVars : [
		'Current'
	],
	#category : #Stripe
}

{ #category : #accessing }
StripeAPI class >> current [

	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
StripeAPI class >> currentReset [

	Current := nil
]

{ #category : #initialization }
StripeAPI class >> dockerSecretsName [

	^ 'shrine'
]

{ #category : #accessing }
StripeAPI class >> stripePublishableKey [
	"
	DockerDeploy current loadSecretNamed: StripeAPI dockerSecretsName.
	StripeAPI stripePublishableKey.
	"

	^ DockerDeploy current
		secretsAt: self dockerSecretsName
		atKey: 'stripePublishableKey'
		ifAbsent: [ 'missing-stripePublishableKey' ]
]

{ #category : #accessing }
StripeAPI class >> stripeSecretKey [
	"
	DockerDeploy current loadSecretNamed: ShrineApp dockerSecretsName.
	ShrineApp stripeSecretKey.
	"

	^ DockerDeploy current
		secretsAt: self dockerSecretsName
		atKey: 'stripeSecretKey'
		ifAbsent: [ 'missing-stripeSecretKey' ]
]

{ #category : #accessing }
StripeAPI >> path: anArray request: aDictionary postAs: aSecretKey [
	| client |

	client := ZnClient new
		https;
		host: 'api.stripe.com';
		addPath: (Array with: 'v1' with: 'checkout' with: 'sessions');
		username: self stripeSecretKey password: '';
		yourself.

	aDictionary keysAndValuesDo: [ :key :value |
		client formAt: key put: value ].

	^ client post
]

{ #category : #accessing }
StripeAPI >> stripePublishableKey [

	^ self class stripePublishableKey
]

{ #category : #accessing }
StripeAPI >> stripeSecretKey [

	^ self class stripeSecretKey
]
