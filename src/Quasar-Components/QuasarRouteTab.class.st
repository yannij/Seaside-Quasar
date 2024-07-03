Class {
	#name : 'QuasarRouteTab',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarRouteTab >> align: anObject [
	
	self attributes at: 'align' put: anObject
]

{ #category : 'attributes' }
QuasarRouteTab >> href: anObject [
	
	self attributes at: 'href' put: anObject
]

{ #category : 'attributes' }
QuasarRouteTab >> label: anObject [
	
	self attributes at: 'label' put: anObject
]

{ #category : 'acccessing' }
QuasarRouteTab >> tag [

	^ 'q-route-tab'
]

{ #category : 'attributes' }
QuasarRouteTab >> to: anObject [
	
	self attributes at: 'to' put: anObject
]
