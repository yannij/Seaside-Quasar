Class {
	#name : #QuasarFabAction,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarFabAction >> anchor: anObject [
	
	self attributes at: 'anchor' put: anObject
]

{ #category : #attributes }
QuasarFabAction >> color: anObject [
	
	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarFabAction >> externalLabel [
	
	self attributes at: 'external-label' put: true
]

{ #category : #attributes }
QuasarFabAction >> flat [
	
	self attributes at: 'flat' put: true
]

{ #category : #attributes }
QuasarFabAction >> glossy [
	
	self attributes at: 'glossy' put: true
]

{ #category : #attributes }
QuasarFabAction >> icon: anObject [
	
	self attributes at: 'icon' put: anObject
]

{ #category : #attributes }
QuasarFabAction >> label: anObject [
	
	self attributes at: 'label' put: anObject
]

{ #category : #attributes }
QuasarFabAction >> labelPosition: anObject [
	
	self attributes at: 'label-position' put: anObject
]

{ #category : #attributes }
QuasarFabAction >> outline [
	
	self attributes at: 'outline' put: true
]

{ #category : #attributes }
QuasarFabAction >> padding: anObject [
	
	self attributes at: 'padding' put: anObject
]

{ #category : #attributes }
QuasarFabAction >> push [
	
	self attributes at: 'push' put: true
]

{ #category : #attributes }
QuasarFabAction >> replace [
	
	self attributes at: 'to' put: true
]

{ #category : #attributes }
QuasarFabAction >> square [
	
	self attributes at: 'square' put: true
]

{ #category : #accessing }
QuasarFabAction >> tag [

	^ 'q-fab-action'
]

{ #category : #attributes }
QuasarFabAction >> textColor: anObject [
	
	self attributes at: 'text-color' put: anObject
]

{ #category : #attributes }
QuasarFabAction >> to: anObject [
	
	self attributes at: 'to' put: anObject
]

{ #category : #attributes }
QuasarFabAction >> type: anObject [
	
	self attributes at: 'type' put: anObject
]

{ #category : #attributes }
QuasarFabAction >> unelevated [
	
	self attributes at: 'unelevated' put: true
]

{ #category : #attributes }
QuasarFabAction >> vOnClick: aString [
	
	self attributes at: '@click' put: aString
]
