Class {
	#name : #MDQTwitterOAuth1Component,
	#superclass : #MDQOAuth1Component,
	#instVars : [
		'twitterAccess'
	],
	#category : #'Quasar-SSO'
}

{ #category : #accessing }
MDQTwitterOAuth1Component >> accessToken: aToken [

	super accessToken: aToken.
	
	twitterAccess := ZnOAuth1TwitterUserAccess new
		oauth1Service: self oauthService ;
		accessToken: self accessToken ;
		yourself.
]

{ #category : #initialization }
MDQTwitterOAuth1Component >> initialize [

	super initialize.

	self oauthService: (ZnOAuth1Service new
		providerAccount: (ZnOAuth1ConsumerData newForTwitterAuthentication
			consumer: (DockerDeploy current configsAt: DockerDeploy defaultConfigName atKey: 'oauth1TwitterConsumerKey') ;
			consumerSecret: (DockerDeploy current configsAt: DockerDeploy defaultConfigName atKey: 'oauth1TwitterConsumerSecret') ;
			yourself ))
]

{ #category : #accessing }
MDQTwitterOAuth1Component >> twitterAccess [

	^ twitterAccess
]
