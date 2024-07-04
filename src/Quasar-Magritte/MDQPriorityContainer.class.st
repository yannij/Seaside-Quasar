Class {
	#name : 'MDQPriorityContainer',
	#superclass : 'MAPriorityContainer',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'accessing' }
MDQPriorityContainer class >> defaultComponentClass [

	^ MDQContainerComponent
]

{ #category : 'accessing' }
MDQPriorityContainer class >> defaultComponentRenderer [

	^ MDQCssRenderer
]

{ #category : 'initialization' }
MDQPriorityContainer >> initialize [

	super initialize.

	self componentRenderer: self class defaultComponentRenderer
]
