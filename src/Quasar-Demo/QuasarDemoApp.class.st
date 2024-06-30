Class {
	#name : 'QuasarDemoApp',
	#superclass : 'QuasarApplication',
	#category : 'Quasar-Demo-Accounting',
	#package : 'Quasar-Demo',
	#tag : 'Accounting'
}

{ #category : 'accessing' }
QuasarDemoApp class >> categoryName [

	^ #demo
]

{ #category : 'hooks' }
QuasarDemoApp >> initialRequest: aRequest [

	super initialRequest: aRequest.

	"Set Ssid to facilitate sticky sessions via haproxy"
	self requestContext response
		headerAt: 'Ssid'
		put: self session key
]
