Class {
	#name : 'QuasarHeader',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarHeader >> elevated [
	
	self attributes at: 'elevated' put: true
]

{ #category : 'attributes' }
QuasarHeader >> heightHint: anObject [
	
	self attributes at: 'height-hint' put: anObject
]

{ #category : 'accessing' }
QuasarHeader >> tag [

	^ 'q-header'
]
