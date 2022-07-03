Class {
	#name : #QuasarTabs,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarTabs >> activeBgColor: anObject [
	
	self attributes at: 'active-bg-color' put: anObject
]

{ #category : #attributes }
QuasarTabs >> activeClass: anObject [
	
	self attributes at: 'active-class' put: anObject
]

{ #category : #attributes }
QuasarTabs >> activeColor: anObject [
	
	self attributes at: 'active-color' put: anObject
]

{ #category : #attributes }
QuasarTabs >> align: anObject [
	
	self attributes at: 'align' put: anObject
]

{ #category : #attributes }
QuasarTabs >> breakpoint: anObject [
	
	self attributes at: 'breakpoint' put: anObject
]

{ #category : #attributes }
QuasarTabs >> contentClass: anObject [
	
	self attributes at: 'content-class' put: anObject
]

{ #category : #attributes }
QuasarTabs >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarTabs >> indicatorColor: anObject [
	
	self attributes at: 'indicator-color' put: anObject
]

{ #category : #attributes }
QuasarTabs >> inlineLabel [
	
	self attributes at: 'inline-label' put: true
]

{ #category : #attributes }
QuasarTabs >> leftIcon: anObject [
	
	self attributes at: 'left-icon' put: anObject
]

{ #category : #attributes }
QuasarTabs >> mobileArrows: anObject [

	self attributes at: 'mobile-arrows' put: anObject
]

{ #category : #attributes }
QuasarTabs >> modelValue: aBoolean [

	self vBind: 'model-value' with: aBoolean
]

{ #category : #attributes }
QuasarTabs >> narrowIndicator [
	
	self attributes at: 'narrow-indicator' put: true
]

{ #category : #attributes }
QuasarTabs >> noCaps [
	
	self attributes at: 'no-caps' put: true
]

{ #category : #attributes }
QuasarTabs >> outsideArrows: anObject [

	self attributes at: 'outside-arrows' put: anObject
]

{ #category : #attributes }
QuasarTabs >> rightIcon: anObject [
	
	self attributes at: 'right-icon' put: anObject
]

{ #category : #attributes }
QuasarTabs >> shrink [
	
	self attributes at: 'shrink' put: true
]

{ #category : #attributes }
QuasarTabs >> stretch [
	
	self attributes at: 'stretch' put: true
]

{ #category : #attributes }
QuasarTabs >> switchIndicator [
	
	self attributes at: 'switch-indicator' put: true
]

{ #category : #accessing }
QuasarTabs >> tag [

	^ 'q-tabs'
]

{ #category : #attributes }
QuasarTabs >> vertical [
	
	self attributes at: 'vertical' put: true
]
