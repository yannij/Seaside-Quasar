"
I represent a Quasar ref object whose value is maintained only on the browser. The server side has no need to synchronize with the client side value.
"
Class {
	#name : #QuasarRefClientOnly,
	#superclass : #QuasarRefObject,
	#category : #'Quasar-Components'
}

{ #category : #actions }
QuasarRefClientOnly >> refValueUpdate: anObject [
	"Do nothing"
]

{ #category : #'rendering - ajax' }
QuasarRefClientOnly >> writeCodeOn: aJSStream with: anAjaxFactory [

	"aJSStream
		nextPutAll: 'null'"
]
