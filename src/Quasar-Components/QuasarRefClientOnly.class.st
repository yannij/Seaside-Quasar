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

	aJSStream
		nextPutAll: 'null'
]
