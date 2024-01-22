Class {
	#name : #QuasarDemoApp,
	#superclass : #QuasarApplication,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #hooks }
QuasarDemoApp >> initialRequest: aRequest [

	super initialRequest: aRequest.

	"Set Ssid to facilitate sticky sessions via haproxy"
	self requestContext response
		headerAt: 'Ssid'
		put: self session key
]
