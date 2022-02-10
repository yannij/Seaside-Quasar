Class {
	#name : #QuasarCard,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarCard >> bordered [
	
	self attributes at: 'bordered' put: true
]

{ #category : #attributes }
QuasarCard >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarCard >> flat [
	
	self attributes at: 'flat' put: true
]

{ #category : #attributes }
QuasarCard >> qTag: anObject [
	
	self attributes at: 'tag' put: anObject
]

{ #category : #attributes }
QuasarCard >> square [
	
	self attributes at: 'square' put: true
]

{ #category : #accessing }
QuasarCard >> tag [

	^ 'q-card'
]
