Class {
	#name : #QuasarAjax,
	#superclass : #JSObject,
	#category : #'Quasar-Components'
}

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

{ #category : #actions }
QuasarAjax >> jsFetch [

	^ (JSFetch context: self renderContext)
		rendererClass: self rendererClass;
		yourself
]
