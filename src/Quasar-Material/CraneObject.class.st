Class {
	#name : #CraneObject,
	#superclass : #Object,
	#classVars : [
		'DescriptionContainerClass'
	],
	#classInstVars : [
		'instanceList'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneObject class >> descriptionContainerClass [
	"
	self descriptionContainerClass: MCWPriorityContainer.
	self descriptionContainerClass: MDQPriorityContainer.
	self descriptionContainerClass: MAPriorityContainer.
	"

	^ DescriptionContainerClass ifNil: [ DescriptionContainerClass := MDQPriorityContainer ]
]

{ #category : #accessing }
CraneObject class >> descriptionContainerClass: anObject [

	^ DescriptionContainerClass := anObject
]

{ #category : #accessing }
CraneObject class >> instanceList [

	^ instanceList ifNil: [ instanceList := OrderedCollection new ]
]

{ #category : #accessing }
CraneObject class >> instanceList: anObject [

	instanceList := anObject
]

{ #category : #accessing }
CraneObject class >> instanceListAdd: anObject [

	self instanceList add: anObject
]

{ #category : #voyage }
CraneObject >> descriptionContainer [
	"Return the default description container."
	<magritteContainer>

	^ self class descriptionContainerClass new
		"componentRenderer: MCWCssRenderer;"
		label: self class label;
		propertyAt: #cardWidth ifAbsentPut: [ 600 ];
		yourself
]
