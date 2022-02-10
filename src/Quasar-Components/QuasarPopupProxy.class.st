Class {
	#name : #QuasarPopupProxy,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarPopupProxy >> breakpoint: anObject [

	self attributes at: 'breakpoint' put: anObject
]

{ #category : #attributes }
QuasarPopupProxy >> contextMenu [
	
	self attributes at: 'context-menu' put: true
]

{ #category : #attributes }
QuasarPopupProxy >> cover [
	
	self attributes at: 'cover' put: true
]

{ #category : #attributes }
QuasarPopupProxy >> noParentEvent [
	
	self attributes at: 'no-parent-event' put: true
]

{ #category : #accessing }
QuasarPopupProxy >> tag [

	^ 'q-popup-proxy'
]

{ #category : #attributes }
QuasarPopupProxy >> target: anObject [

	self attributes at: 'target' put: anObject
]

{ #category : #attributes }
QuasarPopupProxy >> transitionHide: anObject [

	self attributes at: 'transition-hide' put: anObject
]

{ #category : #attributes }
QuasarPopupProxy >> transitionShow: anObject [

	self attributes at: 'transition-show' put: anObject
]
