Class {
	#name : #QuasarList,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarList >> bordered [
	
	self attributes at: 'bordered' put: true
]

{ #category : #attributes }
QuasarList >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarList >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarList >> padding [
	
	self attributes at: 'padding' put: true
]

{ #category : #attributes }
QuasarList >> separator [
	
	self attributes at: 'separator' put: true
]

{ #category : #accessing }
QuasarList >> tag [

	^ 'q-list'
]
