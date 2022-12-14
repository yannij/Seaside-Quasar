Class {
	#name : #QuasarErrorHandler,
	#superclass : #WAErrorHandler,
	#category : #'Quasar-Components'
}

{ #category : #actions }
QuasarErrorHandler >> handleDefault: anException [

	self requestContext respond: [ :response |
		response
			internalError;
			contentType: WAMimeType applicationJson;
			nextPutAll: ('QuasarErrorHandler: ', anException description) asJson ]
]
