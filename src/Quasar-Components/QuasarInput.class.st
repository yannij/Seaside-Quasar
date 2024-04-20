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
QuasarInput >> bottomSlots: aBoolean [

	self attributes at: 'bottom-slots' put: aBoolean
]

{ #category : #attributes }
QuasarInput >> counter [

	self attributes at: 'counter' put: true
]

{ #category : #attributes }
QuasarInput >> debounce: anObject [
	
	self attributes at: 'debounce' put: anObject
]

{ #category : #attributes }
QuasarInput >> hideBottomSpace [

	self attributes at: 'hide-bottom-space' put: true
]

{ #category : #attributes }
QuasarInput >> hint: anObject [
	
	self attributes at: 'hint' put: anObject
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
QuasarInput >> labelSlot: aBoolean [

	self attributes at: 'label-slot' put: aBoolean
]

{ #category : #attributes }
QuasarInput >> lazyRules [

	self attributes at: 'lazy-rules' put: true
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
