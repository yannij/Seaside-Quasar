Class {
	#name : #QuasarChip,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarChip >> clickable [
	
	self attributes at: 'clickable' put: true
]

{ #category : #attributes }
QuasarChip >> color: anObject [
	
	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarChip >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarChip >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarChip >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarChip >> icon: anObject [
	
	self attributes at: 'icon' put: anObject
]

{ #category : #attributes }
QuasarChip >> iconRemove: anObject [
	
	self attributes at: 'icon-remove' put: anObject
]

{ #category : #attributes }
QuasarChip >> iconRight: anObject [
	
	self attributes at: 'icon-right' put: anObject
]

{ #category : #attributes }
QuasarChip >> iconSelected: anObject [
	
	self attributes at: 'icon-selected' put: anObject
]

{ #category : #attributes }
QuasarChip >> label: anObject [
	
	self attributes at: 'label' put: anObject
]

{ #category : #attributes }
QuasarChip >> modelValue: aBoolean [

	self vBind: 'model-value' with: aBoolean
]

{ #category : #attributes }
QuasarChip >> outline [
	
	self attributes at: 'outline' put: true
]

{ #category : #attributes }
QuasarChip >> removable [
	
	self attributes at: 'removable' put: true
]

{ #category : #attributes }
QuasarChip >> ripple: anObject [
	
	self attributes at: 'ripple' put: anObject
]

{ #category : #attributes }
QuasarChip >> selected [
	
	self attributes at: 'selected' put: true
]

{ #category : #attributes }
QuasarChip >> size: anObject [
	
	self attributes at: 'size' put: anObject
]

{ #category : #attributes }
QuasarChip >> square [
	
	self attributes at: 'square' put: true
]

{ #category : #attributes }
QuasarChip >> tabindex: anObject [
	
	self attributes at: 'tabindex' put: anObject
]

{ #category : #accessing }
QuasarChip >> tag [

	^ 'q-chip'
]

{ #category : #attributes }
QuasarChip >> textColor: anObject [
	
	self attributes at: 'text-color' put: anObject
]
