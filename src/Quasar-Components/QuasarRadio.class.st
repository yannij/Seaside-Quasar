Class {
	#name : #QuasarRadio,
	#superclass : #QuasarFormComponent,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarRadio >> color: anObject [
	
	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarRadio >> dark: anObject [
	
	self attributes at: 'dark' put: anObject
]

{ #category : #attributes }
QuasarRadio >> dense: anObject [
	
	self attributes at: 'dense' put: anObject
]

{ #category : #attributes }
QuasarRadio >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarRadio >> keepColor [
	
	self attributes at: 'keep-color' put: true
]

{ #category : #attributes }
QuasarRadio >> leftLabel [
	
	self attributes at: 'left-label' put: true
]

{ #category : #attributes }
QuasarRadio >> name: anObject [
	
	self attributes at: 'name' put: anObject
]

{ #category : #attributes }
QuasarRadio >> size: anObject [
	
	self attributes at: 'size' put: anObject
]

{ #category : #attributes }
QuasarRadio >> tabindex: anObject [
	
	self attributes at: 'tabindex' put: anObject
]

{ #category : #accessing }
QuasarRadio >> tag [

	^ 'q-radio'
]

{ #category : #attributes }
QuasarRadio >> val: anObject [
	
	self attributes at: 'val' put: anObject
]
