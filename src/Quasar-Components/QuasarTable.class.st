Class {
	#name : #QuasarTable,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarTable >> bordered [
	
	self attributes at: 'bordered' put: true
]

{ #category : #attributes }
QuasarTable >> columns: anObject [
	
	self attributes at: ':columns' put: anObject
]

{ #category : #attributes }
QuasarTable >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarTable >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarTable >> flat [
	
	self attributes at: 'flat' put: true
]

{ #category : #attributes }
QuasarTable >> rowKey: anObject [
	
	self attributes at: 'row-key' put: anObject
]

{ #category : #attributes }
QuasarTable >> rows: anObject [
	
	self attributes at: ':rows' put: anObject
]

{ #category : #attributes }
QuasarTable >> square [
	
	self attributes at: 'square' put: true
]

{ #category : #accessing }
QuasarTable >> tag [

	^ 'q-table'
]

{ #category : #attributes }
QuasarTable >> title: anObject [
	
	self attributes at: 'title' put: anObject
]
