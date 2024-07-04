Class {
	#name : 'MDQModel',
	#superclass : 'Object',
	#classVars : [
		'DescriptionContainerClass'
	],
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'accessing' }
MDQModel class >> descriptionContainerClass [
	"
	self descriptionContainerClass: MCWPriorityContainer.
	self descriptionContainerClass: MDQPriorityContainer.
	"

	^ DescriptionContainerClass ifNil: [ DescriptionContainerClass := MDQPriorityContainer ]
]

{ #category : 'accessing' }
MDQModel class >> descriptionContainerClass: anObject [
	DescriptionContainerClass := anObject
]

{ #category : 'accessing' }
MDQModel >> descriptionContainer [
	"Return the default description container."
	<magritteContainer>

	^ self class descriptionContainerClass new
		"componentRenderer: MCWCssRenderer;"
		label: self class label;
		"propertyAt: #cardWidth ifAbsentPut: [ 600 ];"
		yourself
]
