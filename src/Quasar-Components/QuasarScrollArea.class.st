Class {
	#name : 'QuasarScrollArea',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarScrollArea >> barStyle: anObject [

	self attributes at: 'bar-style' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> contentActiveStyle: anObject [

	self attributes at: 'content-active-style' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> contentStyle: anObject [

	self attributes at: 'content-style' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> dark [

	self attributes at: 'dark' put: true
]

{ #category : 'attributes' }
QuasarScrollArea >> delay: anObject [

	self attributes at: 'delay' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> horizontalBarStyle: anObject [

	self attributes at: 'horizontal-bar-style' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> horizontalThumbStyle: anObject [

	self attributes at: 'horizontal-thumb-style' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> style: anObject [

	self attributes at: 'style' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> tabindex: anObject [

	self attributes at: 'tabindex' put: anObject
]

{ #category : 'accessing' }
QuasarScrollArea >> tag [

	^ 'q-scroll-area'
]

{ #category : 'attributes' }
QuasarScrollArea >> thumbStyle: anObject [

	self attributes at: 'thumb-style' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> verticalBarStyle: anObject [

	self attributes at: 'vertical-bar-style' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> verticalThumbStyle: anObject [

	self attributes at: 'vertical-thumb-style' put: anObject
]

{ #category : 'attributes' }
QuasarScrollArea >> visible [

	self attributes at: 'visible' put: true
]
