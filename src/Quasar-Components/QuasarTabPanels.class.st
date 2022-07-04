Class {
	#name : #QuasarTabPanels,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarTabPanels >> align: anObject [

	self attributes at: 'align' put: anObject
]

{ #category : #attributes }
QuasarTabPanels >> animated [
	
	self attributes at: 'animated' put: true
]

{ #category : #attributes }
QuasarTabPanels >> infinite [
	
	self attributes at: 'infinite' put: true
]

{ #category : #attributes }
QuasarTabPanels >> keepAlive [
	
	self attributes at: 'keep-alive' put: true
]

{ #category : #attributes }
QuasarTabPanels >> keepAliveExclude: anObject [

	self attributes at: 'keep-alive-exclude' put: anObject
]

{ #category : #attributes }
QuasarTabPanels >> keepAliveInclude: anObject [

	self attributes at: 'keep-alive-include' put: anObject
]

{ #category : #attributes }
QuasarTabPanels >> keepAliveMax: anObject [

	self attributes at: 'keep-alive-max' put: anObject
]

{ #category : #attributes }
QuasarTabPanels >> swipeable [
	
	self attributes at: 'swipeable' put: true
]

{ #category : #accessing }
QuasarTabPanels >> tag [

	^ 'q-tab-panels'
]

{ #category : #attributes }
QuasarTabPanels >> transitionDuration: anObject [

	self attributes at: 'transition-duration' put: anObject
]

{ #category : #attributes }
QuasarTabPanels >> transitionNext: anObject [

	self attributes at: 'transition-next' put: anObject
]

{ #category : #attributes }
QuasarTabPanels >> transitionPrev: anObject [

	self attributes at: 'transition-prev' put: anObject
]

{ #category : #attributes }
QuasarTabPanels >> vertical [
	
	self attributes at: 'vertical' put: true
]
