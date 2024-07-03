Class {
	#name : 'QuasarBtnGroup',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarBtnGroup >> flat [

	self attributes at: 'flat' put: true
]

{ #category : 'attributes' }
QuasarBtnGroup >> glossy [

	self attributes at: 'glossy' put: true
]

{ #category : 'attributes' }
QuasarBtnGroup >> outline [

	self attributes at: 'outline' put: true
]

{ #category : 'attributes' }
QuasarBtnGroup >> push [

	self attributes at: 'push' put: true
]

{ #category : 'attributes' }
QuasarBtnGroup >> rounded [

	self attributes at: 'rounded' put: true
]

{ #category : 'attributes' }
QuasarBtnGroup >> spread [

	self attributes at: 'spread' put: true
]

{ #category : 'attributes' }
QuasarBtnGroup >> stretch [

	self attributes at: 'stretch' put: true
]

{ #category : 'accessing' }
QuasarBtnGroup >> tag [

	^ 'q-btn-group'
]

{ #category : 'attributes' }
QuasarBtnGroup >> unelevated [

	self attributes at: 'unelevated' put: true
]
