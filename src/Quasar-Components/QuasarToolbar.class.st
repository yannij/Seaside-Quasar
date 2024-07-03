Class {
	#name : 'QuasarToolbar',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarToolbar >> inset [

	self attributes at: 'inset' put: true
]

{ #category : 'accessing' }
QuasarToolbar >> tag [

	^ 'q-toolbar'
]
