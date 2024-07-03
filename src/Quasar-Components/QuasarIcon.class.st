Class {
	#name : 'QuasarIcon',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarIcon >> color: anObject [

	self attributes at: 'color' put: anObject
]

{ #category : 'attributes' }
QuasarIcon >> icon: anObject [

	self attributes at: 'icon' put: anObject
]

{ #category : 'attributes' }
QuasarIcon >> left [

	self attributes at: 'left' put: true
]

{ #category : 'attributes' }
QuasarIcon >> name: anObject [

	self attributes at: 'name' put: anObject
]

{ #category : 'attributes' }
QuasarIcon >> qTag: anObject [

	self attributes at: 'tag' put: anObject
]

{ #category : 'attributes' }
QuasarIcon >> right [

	self attributes at: 'right' put: true
]

{ #category : 'attributes' }
QuasarIcon >> size: anObject [

	self attributes at: 'size' put: anObject
]

{ #category : 'accessing' }
QuasarIcon >> tag [

	^ 'q-icon'
]
