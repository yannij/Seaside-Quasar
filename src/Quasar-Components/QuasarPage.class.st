Class {
	#name : 'QuasarPage',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarPage >> padding [
	
	self attributes at: 'padding' put: true
]

{ #category : 'accessing' }
QuasarPage >> tag [

	^ 'q-page'
]
