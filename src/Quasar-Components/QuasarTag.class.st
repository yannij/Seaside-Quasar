Class {
	#name : #QuasarTag,
	#superclass : #WATagBrush,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarTag >> ref: anObject [
	
	self attributes at: 'ref' put: anObject
]
