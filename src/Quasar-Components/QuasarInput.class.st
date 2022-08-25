Class {
	#name : #QuasarInput,
	#superclass : #QuasarFormComponent,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarInput >> borderless [

	self attributes at: 'borderless' put: true
]

{ #category : #attributes }
QuasarInput >> debounce: anObject [
	
	self attributes at: 'debounce' put: anObject
]

{ #category : #attributes }
QuasarInput >> inputClass: anObject [
	
	self attributes at: 'input-class' put: anObject
]

{ #category : #attributes }
QuasarInput >> inputStyle: anObject [
	
	self attributes at: 'input-style' put: anObject
]

{ #category : #api }
QuasarInput >> placeholder: aString [
	
	self attributes at: 'placeholder' put: aString
]

{ #category : #attributes }
QuasarInput >> prefix: anObject [
	
	self attributes at: 'prefix' put: anObject
]

{ #category : #attributes }
QuasarInput >> suffix: anObject [
	
	self attributes at: 'suffix' put: anObject
]

{ #category : #accessing }
QuasarInput >> tag [

	^ 'q-input'
]

{ #category : #attributes }
QuasarInput >> type: anObject [
	
	self attributes at: 'type' put: anObject
]
