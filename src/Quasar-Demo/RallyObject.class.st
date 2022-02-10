Class {
	#name : #RallyObject,
	#superclass : #Object,
	#classVars : [
		'DescriptionContainerClass'
	],
	#classInstVars : [
		'instanceList'
	],
	#category : #'Quasar-Demo'
}

{ #category : #accessing }
RallyObject class >> descriptionContainerClass [
	"
	self descriptionContainerClass: MCWPriorityContainer.
	self descriptionContainerClass: MDQPriorityContainer.
	self descriptionContainerClass: MAPriorityContainer.
	"

	^ DescriptionContainerClass ifNil: [ DescriptionContainerClass := MDQPriorityContainer ]
]

{ #category : #accessing }
RallyObject class >> descriptionContainerClass: anObject [

	^ DescriptionContainerClass := anObject
]

{ #category : #accessing }
RallyObject class >> instanceList [

	^ instanceList ifNil: [ instanceList := OrderedCollection new ]
]

{ #category : #accessing }
RallyObject class >> instanceList: anObject [

	instanceList := anObject
]

{ #category : #accessing }
RallyObject class >> instanceListAdd: anObject [

	self instanceList add: anObject
]

{ #category : #rendering }
RallyObject >> cardParameters [

	self subclassResponsibility
]

{ #category : #voyage }
RallyObject >> descriptionContainer [
	"Return the default description container."
	<magritteContainer>

	^ self class descriptionContainerClass new
		"componentRenderer: MCWCssRenderer;"
		label: self class label;
		propertyAt: #cardWidth ifAbsentPut: [ 600 ];
		yourself
]

{ #category : #rendering }
RallyObject >> listItemParameters [

	self subclassResponsibility
]
