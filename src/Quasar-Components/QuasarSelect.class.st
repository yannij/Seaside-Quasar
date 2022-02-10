Class {
	#name : #QuasarSelect,
	#superclass : #QuasarFormComponent,
	#instVars : [
		'callback',
		'values'
	],
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarSelect >> borderless [
	
	self attributes at: 'borderless' put: true
]

{ #category : #callbacks }
QuasarSelect >> callback: aBlock [

	self isMultiple ifTrue: [
		values := Dictionary new.
		^ self name: (self storeCallback: (self callbackClass on: aBlock values: values)) ].

	super callback: aBlock
]

{ #category : #callbacks }
QuasarSelect >> callbackClass [

	self isMultiple ifTrue: [
		^ WAMultipleValuesCallback ].

	^ super callbackClass
]

{ #category : #attributes }
QuasarSelect >> clearable [
	
	self attributes at: 'clearable' put: true
]

{ #category : #attributes }
QuasarSelect >> color: anObject [

	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarSelect >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarSelect >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarSelect >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarSelect >> disable: aBoolean [
	
	self attributes at: 'disable' put: aBoolean
]

{ #category : #attributes }
QuasarSelect >> filled [
	
	self attributes at: 'filled' put: true
]

{ #category : #attributes }
QuasarSelect >> inputClass: anObject [
	
	self attributes at: 'input-class' put: anObject
]

{ #category : #attributes }
QuasarSelect >> inputStyle: anObject [
	
	self attributes at: 'input-style' put: anObject
]

{ #category : #callbacks }
QuasarSelect >> isMultiple [

	^ self attributes includesKey: 'multiple'
]

{ #category : #attributes }
QuasarSelect >> multiple [
	
	self attributes at: 'multiple' put: true
]

{ #category : #multiselect }
QuasarSelect >> multipleCallbackValue: aList [

	aList do: [ :each | self valueFor: each ]
]

{ #category : #multiselect }
QuasarSelect >> nextKey [

	^ values size + 1
]

{ #category : #attributes }
QuasarSelect >> options: anObject [

	self attributes at: ':options' put: anObject
]

{ #category : #attributes }
QuasarSelect >> outlined [
	
	self attributes at: 'outlined' put: true
]

{ #category : #attributes }
QuasarSelect >> readonly [
	
	self attributes at: 'readonly' put: true
]

{ #category : #attributes }
QuasarSelect >> readonly: aBoolean [
	
	self attributes at: 'readonly' put: aBoolean
]

{ #category : #attributes }
QuasarSelect >> rounded [
	
	self attributes at: 'rounded' put: true
]

{ #category : #attributes }
QuasarSelect >> square [
	
	self attributes at: 'square' put: true
]

{ #category : #callbacks }
QuasarSelect >> storeCallback: aCallback [

	self isMultiple ifTrue: [
		^ super storeCallback: (callback := aCallback) ].

	^ super storeCallback: aCallback
]

{ #category : #accessing }
QuasarSelect >> tag [

	^ 'q-select'
]

{ #category : #multiselect }
QuasarSelect >> valueFor: anObject [

	^ self valuesAt: self nextKey put: anObject
]

{ #category : #accessing }
QuasarSelect >> values [

	^ values
]

{ #category : #multiselect }
QuasarSelect >> valuesAt: key put: anObject [

	values at: key put: anObject.
	^ values size
]
