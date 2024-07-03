Class {
	#name : 'QuasarTooltip',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarTooltip >> anchor: anObject [

	self attributes at: 'anchor' put: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> delay: anObject [

	self attributes at: 'delay' put: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> hideDelay: anObject [

	self attributes at: 'hide-delay' put: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> maxHeight: anObject [

	self attributes at: 'max-height' put: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> maxWidth: anObject [

	self attributes at: 'max-width' put: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> noParentEvent [

	self attributes at: 'no-parent-event' put: true
]

{ #category : 'attributes' }
QuasarTooltip >> offset: anObject [

	self vBind: 'offset' with: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> scrollTarget: anObject [

	self attributes at: 'scroll-target' put: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> self: anObject [

	self attributes at: 'self' put: anObject
]

{ #category : 'accessing' }
QuasarTooltip >> tag [

	^ 'q-tooltip'
]

{ #category : 'attributes' }
QuasarTooltip >> target: anObject [

	self attributes at: 'target' put: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> transitionDuration: anObject [

	self attributes at: 'transition-duration' put: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> transitionHide: anObject [

	self attributes at: 'transition-hide' put: anObject
]

{ #category : 'attributes' }
QuasarTooltip >> transitionShow: anObject [

	self attributes at: 'transition-show' put: anObject
]
