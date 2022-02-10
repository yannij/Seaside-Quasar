Class {
	#name : #QuasarMarkupTable,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarMarkupTable >> maximized [
	
	self attributes at: 'maximized' put: true
]

{ #category : #accessing }
QuasarMarkupTable >> tag [

	^ 'q-markup-table'
]

{ #category : #attributes }
QuasarMarkupTable >> transitionHide: anObject [
	
	self attributes at: 'transition-hide' put: anObject
]
