Class {
	#name : 'RallyAlert',
	#superclass : 'RallyObject',
	#instVars : [
		'id',
		'description'
	],
	#category : 'Quasar-Material-Rally',
	#package : 'Quasar-Material',
	#tag : 'Rally'
}

{ #category : 'rendering' }
RallyAlert >> cardParameters [

	^ Array with: nil with: self description
]

{ #category : 'accessing' }
RallyAlert >> description [

	^ description
]

{ #category : 'accessing' }
RallyAlert >> description: anObject [

	description := anObject
]

{ #category : 'accessing-magritte' }
RallyAlert >> descriptionDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #description;
		default: '';
		label: 'Description';
		priority: 20;
		yourself
]

{ #category : 'accessing' }
RallyAlert >> id [

	^ id
]

{ #category : 'accessing' }
RallyAlert >> id: anObject [

	id := anObject
]

{ #category : 'accessing-magritte' }
RallyAlert >> idDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #id;
		label: 'ID';
		priority: 10;
		beRequired;
		yourself
]

{ #category : 'rendering' }
RallyAlert >> listItemParameters [

	^ (Array with: self id with: (self description truncateWithElipsisTo: 80))
]
