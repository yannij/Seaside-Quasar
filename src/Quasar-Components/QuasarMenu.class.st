Class {
	#name : 'QuasarMenu',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarMenu >> autoClose [
	
	self attributes at: 'auto-close' put: true
]

{ #category : 'attributes' }
QuasarMenu >> cover [
	
	self attributes at: 'cover' put: true
]

{ #category : 'accessing' }
QuasarMenu >> tag [

	^ 'q-menu'
]
