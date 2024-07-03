Class {
	#name : 'QuasarToggle',
	#superclass : 'QuasarFormComponent',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarToggle >> align: anObject [

	self attributes at: 'align' put: anObject
]

{ #category : 'attributes' }
QuasarToggle >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : 'accessing' }
QuasarToggle >> tag [

	^ 'q-toggle'
]

{ #category : 'attributes' }
QuasarToggle >> vertical [

	self attributes at: 'vertical' put: true
]
