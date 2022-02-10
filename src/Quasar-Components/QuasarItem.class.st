Class {
	#name : #QuasarItem,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarItem >> clickable [
	
	self attributes at: 'clickable' put: true
]

{ #category : #attributes }
QuasarItem >> href: aString [
	
	self attributes at: 'href' put: aString
]

{ #category : #attributes }
QuasarItem >> qTag: aString [
	
	self attributes at: 'tag' put: aString
]

{ #category : #accessing }
QuasarItem >> tag [

	^ 'q-item'
]

{ #category : #attributes }
QuasarItem >> vRipple [
	
	self attributes at: 'v-ripple' put: true
]
