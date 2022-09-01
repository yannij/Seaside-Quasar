Class {
	#name : #QuasarAjax,
	#superclass : #JSObject,
	#category : #'Quasar-Components'
}

{ #category : #actions }
QuasarAjax >> fetch [

	^ (JSFetch context: self renderContext)
		rendererClass: self rendererClass;
		yourself
]

{ #category : #actions }
QuasarAjax >> javascript [

	^ (JSScript context: self renderContext)
		rendererClass: self rendererClass;
		yourself
]

{ #category : #printing }
QuasarAjax >> javascriptContentOn: aStream [
	"Do nothing. Use as factory only"
]
