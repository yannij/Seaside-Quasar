Class {
	#name : #QuasarItem,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarItem >> active [
	
	self attributes at: 'active' put: true
]

{ #category : #attributes }
QuasarItem >> clickable [
	
	self attributes at: 'clickable' put: true
]

{ #category : #attributes }
QuasarItem >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarItem >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarItem >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarItem >> disable: aBoolean [
	
	self attributes at: 'disable' put: aBoolean
]

{ #category : #attributes }
QuasarItem >> focused [
	
	self attributes at: 'focused' put: true
]

{ #category : #attributes }
QuasarItem >> href: aString [
	
	self attributes at: 'href' put: aString
]

{ #category : #attributes }
QuasarItem >> insetLevel: aString [
	
	self attributes at: 'inset-level' put: aString
]

{ #category : #attributes }
QuasarItem >> label: aString [
	
	self attributes at: 'label' put: aString
]

{ #category : #attributes }
QuasarItem >> manualFocus [
	
	self attributes at: 'manual-focus' put: true
]

{ #category : #attributes }
QuasarItem >> qTag: aString [
	
	self attributes at: 'tag' put: aString
]

{ #category : #attributes }
QuasarItem >> tabindex: aString [
	
	self attributes at: 'tabindex' put: aString
]

{ #category : #accessing }
QuasarItem >> tag [

	^ 'q-item'
]

{ #category : #attributes }
QuasarItem >> to: aStringOrJsonObject [
	
	self attributes at: 'to' put: aStringOrJsonObject
]

{ #category : #attributes }
QuasarItem >> vRipple [
	
	self attributes at: 'v-ripple' put: true
]
