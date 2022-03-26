Class {
	#name : #QuasarInput,
	#superclass : #QuasarFormComponent,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarInput >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarInput >> disable: aBoolean [
	
	self attributes at: 'disable' put: aBoolean
]

{ #category : #attributes }
QuasarInput >> filled [
	
	self attributes at: 'filled' put: true
]

{ #category : #attributes }
QuasarInput >> inputClass: anObject [
	
	self attributes at: 'input-class' put: anObject
]

{ #category : #attributes }
QuasarInput >> inputStyle: anObject [
	
	self attributes at: 'input-style' put: anObject
]

{ #category : #attributes }
QuasarInput >> outlined [
	
	self attributes at: 'outlined' put: true
]

{ #category : #attributes }
QuasarInput >> readonly [
	
	self attributes at: 'readonly' put: true
]

{ #category : #attributes }
QuasarInput >> readonly: aBoolean [
	
	self attributes at: 'readonly' put: aBoolean
]

{ #category : #attributes }
QuasarInput >> stackLabel [
	
	self attributes at: 'stack-label' put: true
]

{ #category : #accessing }
QuasarInput >> tag [

	^ 'q-input'
]

{ #category : #attributes }
QuasarInput >> type: anObject [
	
	self attributes at: 'type' put: anObject
]
