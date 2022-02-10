Class {
	#name : #QuasarSeparator,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarSeparator >> color: anObject [
	
	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarSeparator >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarSeparator >> inset [
	
	self attributes at: 'inset' put: true
]

{ #category : #attributes }
QuasarSeparator >> inset: anObject [
	
	self attributes at: 'inset' put: anObject
]

{ #category : #attributes }
QuasarSeparator >> size: anObject [
	
	self attributes at: 'size' put: anObject
]

{ #category : #attributes }
QuasarSeparator >> spaced [
	
	self attributes at: 'spaced' put: true
]

{ #category : #attributes }
QuasarSeparator >> spaced: anObject [
	
	self attributes at: 'spaced' put: anObject
]

{ #category : #accessing }
QuasarSeparator >> tag [

	^ 'q-separator'
]

{ #category : #attributes }
QuasarSeparator >> vertical [
	
	self attributes at: 'vertical' put: true
]
