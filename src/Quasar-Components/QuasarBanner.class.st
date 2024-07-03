Class {
	#name : 'QuasarBanner',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarBanner >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : 'attributes' }
QuasarBanner >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : 'attributes' }
QuasarBanner >> inlineActions [
	
	self attributes at: 'inline-actions' put: true
]

{ #category : 'attributes' }
QuasarBanner >> rounded [
	
	self attributes at: 'rounded' put: true
]

{ #category : 'accessing' }
QuasarBanner >> tag [

	^ 'q-banner'
]
