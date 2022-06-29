Class {
	#name : #QuasarEditor,
	#superclass : #QuasarFormComponent,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarEditor >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarEditor >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarEditor >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarEditor >> flat [
	
	self attributes at: 'flat' put: true
]

{ #category : #attributes }
QuasarEditor >> fullscreen [
	
	self attributes at: 'fullscreen' put: true
]

{ #category : #attributes }
QuasarEditor >> height: aString [
	
	self attributes at: 'height' put: aString
]

{ #category : #attributes }
QuasarEditor >> maxHeight: aString [
	
	self attributes at: 'max-height' put: aString
]

{ #category : #attributes }
QuasarEditor >> minHeight: aString [
	
	self attributes at: 'min-height' put: aString
]

{ #category : #attributes }
QuasarEditor >> noRouteFullscreenExit [
	
	self attributes at: 'no-route-fullscreen-exit' put: true
]

{ #category : #attributes }
QuasarEditor >> paragraphTag: aString [
	
	self attributes at: 'paragraph-tag' put: aString
]

{ #category : #attributes }
QuasarEditor >> placeholder: aString [
	
	self attributes at: 'placeholder' put: aString
]

{ #category : #attributes }
QuasarEditor >> readonly [
	
	self attributes at: 'readonly' put: true
]

{ #category : #attributes }
QuasarEditor >> square [
	
	self attributes at: 'square' put: true
]

{ #category : #accessing }
QuasarEditor >> tag [

	^ 'q-editor'
]
