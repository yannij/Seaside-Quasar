Class {
	#name : #QuasarDrawer,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarDrawer >> behavior: anObject [

	self attributes at: 'behavior' put: anObject
]

{ #category : #attributes }
QuasarDrawer >> bordered [

	self attributes at: 'bordered' put: true
]

{ #category : #attributes }
QuasarDrawer >> breakpoint: anObject [

	self attributes at: 'breakpoint' put: anObject
]

{ #category : #attributes }
QuasarDrawer >> dark [

	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarDrawer >> elevated [

	self attributes at: 'elevated' put: true
]

{ #category : #attributes }
QuasarDrawer >> mini [

	self mini: true
]

{ #category : #attributes }
QuasarDrawer >> mini: aBoolean [

	self attributes at: 'mini' put: aBoolean
]

{ #category : #attributes }
QuasarDrawer >> miniToOverlay [

	self miniToOverlay: true
]

{ #category : #attributes }
QuasarDrawer >> miniToOverlay: aBoolean [

	self attributes at: 'mini-to-overlay' put: aBoolean
]

{ #category : #attributes }
QuasarDrawer >> miniWidth: anObject [

	self attributes at: 'mini-width' put: anObject
]

{ #category : #attributes }
QuasarDrawer >> modelValue: aBoolean [

	self attributes at: 'model-value' put: aBoolean
]

{ #category : #attributes }
QuasarDrawer >> noSwipeBackdrop [

	self attributes at: 'no-swipe-backdrop' put: true
]

{ #category : #attributes }
QuasarDrawer >> noSwipeClose [

	self attributes at: 'no-swipe-close' put: true
]

{ #category : #attributes }
QuasarDrawer >> noSwipeOpen [

	self attributes at: 'no-swipe-open' put: true
]

{ #category : #attributes }
QuasarDrawer >> overlay [

	self overlay: true
]

{ #category : #attributes }
QuasarDrawer >> overlay: anObject [

	self attributes at: 'overlay' put: anObject
]

{ #category : #attributes }
QuasarDrawer >> persistent [

	self persistent: true
]

{ #category : #attributes }
QuasarDrawer >> persistent: aBoolean [

	self attributes at: 'persistent' put: aBoolean
]

{ #category : #attributes }
QuasarDrawer >> showIfAbove [

	self attributes at: 'show-if-above' put: true
]

{ #category : #attributes }
QuasarDrawer >> side: anObject [

	self attributes at: 'side' put: anObject
]

{ #category : #accessing }
QuasarDrawer >> tag [

	^ 'q-drawer'
]

{ #category : #attributes }
QuasarDrawer >> width: anObject [

	self attributes at: 'width' put: anObject
]
