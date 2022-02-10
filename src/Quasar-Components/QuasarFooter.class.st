Class {
	#name : #QuasarFooter,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarFooter >> elevated [
	
	self attributes at: 'elevated' put: true
]

{ #category : #attributes }
QuasarFooter >> heightHint: anObject [
	
	self attributes at: 'height-hint' put: anObject
]

{ #category : #accessing }
QuasarFooter >> tag [

	^ 'q-footer'
]
