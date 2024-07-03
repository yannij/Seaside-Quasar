Class {
	#name : 'QuasarItemSection',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarItemSection >> avatar [
	
	self attributes at: 'avatar' put: true
]

{ #category : 'attributes' }
QuasarItemSection >> noWrap [
	
	self attributes at: 'no-wrap' put: true
]

{ #category : 'attributes' }
QuasarItemSection >> side [
	
	self attributes at: 'side' put: true
]

{ #category : 'accessing' }
QuasarItemSection >> tag [

	^ 'q-item-section'
]

{ #category : 'attributes' }
QuasarItemSection >> thumbnail [
	
	self attributes at: 'thumbnail' put: true
]

{ #category : 'attributes' }
QuasarItemSection >> top [
	
	self attributes at: 'top' put: true
]
