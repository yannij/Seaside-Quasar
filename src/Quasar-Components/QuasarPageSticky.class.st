Class {
	#name : #QuasarPageSticky,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarPageSticky >> expand [
	
	self attributes at: 'expand' put: true
]

{ #category : #attributes }
QuasarPageSticky >> heightHint: anObject [
	
	self attributes at: 'height-hint' put: anObject
]

{ #category : #attributes }
QuasarPageSticky >> offset: anObject [
	
	self attributes at: ':offset' put: anObject
]

{ #category : #attributes }
QuasarPageSticky >> position: anObject [
	
	self attributes at: 'position' put: anObject
]

{ #category : #accessing }
QuasarPageSticky >> tag [

	^ 'q-page-sticky'
]
