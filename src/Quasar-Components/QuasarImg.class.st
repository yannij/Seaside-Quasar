Class {
	#name : 'QuasarImg',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarImg >> alt: anObject [
	
	self attributes at: 'alt' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> crossorigin: anObject [
	
	self attributes at: 'crossorigin' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> decoding: anObject [
	
	self attributes at: 'decoding' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> draggable [
	
	self attributes at: 'draggable' put: true
]

{ #category : 'attributes' }
QuasarImg >> draggable: anObject [
	
	self attributes at: 'draggable' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> fit: anObject [
	
	self attributes at: 'fit' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> height: anObject [
	
	self attributes at: 'height' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> imgClass: anObject [
	
	self attributes at: 'img-class' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> imgStyle: anObject [
	
	self attributes at: 'img-style' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> initialRatio: anObject [
	
	self attributes at: 'initial-ratio' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> loading: anObject [
	
	self attributes at: 'loading' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> noNativeMenu [
	
	self attributes at: 'no-native-menu' put: true
]

{ #category : 'attributes' }
QuasarImg >> noNativeMenu: anObject [
	
	self attributes at: 'no-native-menu' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> noSpinner [
	
	self attributes at: 'no-spinner' put: true
]

{ #category : 'attributes' }
QuasarImg >> noSpinner: anObject [
	
	self attributes at: 'no-spinner' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> noTransition [
	
	self attributes at: 'no-transition' put: true
]

{ #category : 'attributes' }
QuasarImg >> noTransition: anObject [
	
	self attributes at: 'no-transition' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> placeholderSrc: anObject [
	
	self attributes at: 'placeholder-src' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> position: anObject [
	
	self attributes at: 'position' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> ratio: anObject [
	
	self attributes at: 'ratio' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> referrerpolicy: anObject [
	
	self attributes at: 'referrerpolicy' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> sizes: anObject [
	
	self attributes at: 'sizes' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> spinnerColor: anObject [
	
	self attributes at: 'spinner-color' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> spinnerSize: anObject [
	
	self attributes at: 'spinner-size' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> src: anObject [
	
	self attributes at: 'src' put: anObject
]

{ #category : 'attributes' }
QuasarImg >> srcset: anObject [
	
	self attributes at: 'srcset' put: anObject
]

{ #category : 'accessing' }
QuasarImg >> tag [

	^ 'q-img'
]

{ #category : 'attributes' }
QuasarImg >> width: anObject [
	
	self attributes at: 'width' put: anObject
]
