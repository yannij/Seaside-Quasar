Class {
	#name : #QuasarPagination,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarPagination >> activeColor: anObject [
	
	self attributes at: 'active-color' put: anObject
]

{ #category : #attributes }
QuasarPagination >> activeTextColor: anObject [
	
	self attributes at: 'active-text-color' put: anObject
]

{ #category : #attributes }
QuasarPagination >> boundaryLinks [
	
	self attributes at: 'boundary-links' put: true
]

{ #category : #attributes }
QuasarPagination >> boundaryNumbers [
	
	self attributes at: 'boundary-numbers' put: true
]

{ #category : #attributes }
QuasarPagination >> boundaryNumbers: aBoolean [
	
	self attributes at: 'boundary-numbers' put: aBoolean
]

{ #category : #attributes }
QuasarPagination >> color: anObject [
	
	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarPagination >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarPagination >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarPagination >> directionLinks [
	
	self attributes at: 'direction-links' put: true
]

{ #category : #attributes }
QuasarPagination >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarPagination >> ellipses [
	
	self attributes at: 'ellipses' put: true
]

{ #category : #attributes }
QuasarPagination >> flat [
	
	self attributes at: 'flat' put: true
]

{ #category : #attributes }
QuasarPagination >> glossy [
	
	self attributes at: 'glossy' put: true
]

{ #category : #attributes }
QuasarPagination >> iconFirst: anObject [
	
	self attributes at: 'icon-first' put: anObject
]

{ #category : #attributes }
QuasarPagination >> iconLast: anObject [
	
	self attributes at: 'icon-last' put: anObject
]

{ #category : #attributes }
QuasarPagination >> iconNext: anObject [
	
	self attributes at: 'icon-next' put: anObject
]

{ #category : #attributes }
QuasarPagination >> iconPrev: anObject [
	
	self attributes at: 'icon-prev' put: anObject
]

{ #category : #attributes }
QuasarPagination >> input [
	
	self attributes at: 'input' put: true
]

{ #category : #attributes }
QuasarPagination >> inputClass: anObject [
	
	self attributes at: 'input-class' put: anObject
]

{ #category : #attributes }
QuasarPagination >> inputStyle: anObject [
	
	self attributes at: 'active-text-color' put: anObject
]

{ #category : #attributes }
QuasarPagination >> max: anObject [
	
	self attributes at: 'max' put: anObject
]

{ #category : #attributes }
QuasarPagination >> maxPages: anObject [
	
	self attributes at: 'max-pages' put: anObject
]

{ #category : #attributes }
QuasarPagination >> min: anObject [
	
	self attributes at: 'min' put: anObject
]

{ #category : #attributes }
QuasarPagination >> outline [
	
	self attributes at: 'outline' put: true
]

{ #category : #attributes }
QuasarPagination >> padding: anObject [
	
	self attributes at: 'padding' put: anObject
]

{ #category : #attributes }
QuasarPagination >> push [
	
	self attributes at: 'push' put: true
]

{ #category : #attributes }
QuasarPagination >> ripple: anObject [
	
	self attributes at: 'ripple' put: anObject
]

{ #category : #attributes }
QuasarPagination >> round [
	
	self attributes at: 'round' put: true
]

{ #category : #attributes }
QuasarPagination >> rounded [
	
	self attributes at: 'rounded' put: true
]

{ #category : #attributes }
QuasarPagination >> size: anObject [
	
	self attributes at: 'size' put: anObject
]

{ #category : #accessing }
QuasarPagination >> tag [

	^ 'q-pagination'
]

{ #category : #attributes }
QuasarPagination >> textColor: anObject [
	
	self attributes at: 'text-color' put: anObject
]

{ #category : #attributes }
QuasarPagination >> unelevated [
	
	self attributes at: 'unelevated' put: true
]
