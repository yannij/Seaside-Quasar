Class {
	#name : #QuasarCardActions,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarCardActions >> align: anObject [

	self attributes at: 'align' put: anObject
]

{ #category : #accessing }
QuasarCardActions >> tag [

	^ 'q-card-actions'
]

{ #category : #attributes }
QuasarCardActions >> vertical [

	self attributes at: 'vertical' put: true
]
