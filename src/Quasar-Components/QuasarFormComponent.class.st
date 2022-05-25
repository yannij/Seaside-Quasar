Class {
	#name : #QuasarFormComponent,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #callbacks }
QuasarFormComponent >> callback: aBlock [

	self name: (self storeCallback: (self callbackClass on: aBlock))
]

{ #category : #callbacks }
QuasarFormComponent >> callbackClass [

	^ WAValueCallback
]

{ #category : #attributes }
QuasarFormComponent >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarFormComponent >> dense: anObject [
	
	self attributes at: 'dense' put: anObject
]

{ #category : #attributes }
QuasarFormComponent >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarFormComponent >> disable: aBoolean [
	
	self attributes at: 'disable' put: aBoolean
]

{ #category : #attributes }
QuasarFormComponent >> filled [
	
	self attributes at: 'filled' put: true
]

{ #category : #attributes }
QuasarFormComponent >> label: anObject [
	
	self attributes at: 'label' put: anObject
]

{ #category : #attributes }
QuasarFormComponent >> modelValue: anObject [
	
	self attributes at: ':model-value' put: anObject
]

{ #category : #attributes }
QuasarFormComponent >> name: anObject [
	
	self attributes at: 'name' put: anObject
]

{ #category : #callbacks }
QuasarFormComponent >> on: aSelector of: anObject [

	"self value: (anObject perform: aSelector)."
	self callback: (GRDelayedSend 
			receiver: anObject
			selector: aSelector asMutator)
]

{ #category : #attributes }
QuasarFormComponent >> outlined [
	
	self attributes at: 'outlined' put: true
]

{ #category : #attributes }
QuasarFormComponent >> readonly [
	
	self attributes at: 'readonly' put: true
]

{ #category : #attributes }
QuasarFormComponent >> readonly: aBoolean [
	
	self attributes at: 'readonly' put: aBoolean
]

{ #category : #attributes }
QuasarFormComponent >> stackLabel [
	
	self attributes at: 'stack-label' put: true
]
