Class {
	#name : 'QuasarFab',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarFab >> color: anObject [

	self attributes at: 'color' put: anObject
]

{ #category : 'attributes' }
QuasarFab >> externalLabel [

	self attributes at: 'external-label' put: true
]

{ #category : 'attributes' }
QuasarFab >> flat [

	self attributes at: 'flat' put: true
]

{ #category : 'attributes' }
QuasarFab >> icon: anObject [

	self attributes at: 'icon' put: anObject
]

{ #category : 'attributes' }
QuasarFab >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : 'attributes' }
QuasarFab >> labelPosition: anObject [

	self attributes at: 'label-position' put: anObject
]

{ #category : 'attributes' }
QuasarFab >> outline [

	self attributes at: 'outline' put: true
]

{ #category : 'attributes' }
QuasarFab >> push [

	self attributes at: 'push' put: true
]

{ #category : 'accessing' }
QuasarFab >> tag [

	^ 'q-fab'
]

{ #category : 'attributes' }
QuasarFab >> unelevated [

	self attributes at: 'unelevated' put: true
]
