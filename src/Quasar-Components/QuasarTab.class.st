Class {
	#name : 'QuasarTab',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarTab >> align: anObject [

	self attributes at: 'align' put: anObject
]

{ #category : 'attributes' }
QuasarTab >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : 'attributes' }
QuasarTab >> name: anObject [

	self attributes at: 'name' put: anObject
]

{ #category : 'accessing' }
QuasarTab >> tag [

	^ 'q-tab'
]

{ #category : 'attributes' }
QuasarTab >> vertical [
	
	self attributes at: 'vertical' put: true
]
