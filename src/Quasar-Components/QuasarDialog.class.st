Class {
	#name : #QuasarDialog,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarDialog >> maximized [
	
	self attributes at: 'maximized' put: true
]

{ #category : #attributes }
QuasarDialog >> persistent [
	
	self attributes at: 'persistent' put: true
]

{ #category : #accessing }
QuasarDialog >> tag [

	^ 'q-dialog'
]

{ #category : #attributes }
QuasarDialog >> transitionHide: anObject [
	
	self attributes at: 'transition-hide' put: anObject
]

{ #category : #attributes }
QuasarDialog >> transitionShow: anObject [
	
	self attributes at: 'transition-show' put: anObject
]
