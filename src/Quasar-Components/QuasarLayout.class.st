Class {
	#name : #QuasarLayout,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarLayout >> tag [

	^ 'q-layout'
]

{ #category : #attributes }
QuasarLayout >> view: aString [
	
	self attributes at: 'view' put: aString
]
