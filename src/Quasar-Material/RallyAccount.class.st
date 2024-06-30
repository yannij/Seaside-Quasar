Class {
	#name : 'RallyAccount',
	#superclass : 'RallyObject',
	#instVars : [
		'id',
		'description',
		'balance'
	],
	#category : 'Quasar-Material-Rally',
	#package : 'Quasar-Material',
	#tag : 'Rally'
}

{ #category : 'accessing' }
RallyAccount >> balance [

	^ balance
]

{ #category : 'accessing' }
RallyAccount >> balance: anObject [

	balance := anObject
]

{ #category : 'accessing-magritte' }
RallyAccount >> balanceDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #balance;
		default: 0.0;
		label: 'Balance';
		priority: 30;
		yourself
]

{ #category : 'rendering' }
RallyAccount >> cardParameters [

	^ Array with: self id with: self description
]

{ #category : 'accessing' }
RallyAccount >> description [

	^ description
]

{ #category : 'accessing' }
RallyAccount >> description: anObject [

	description := anObject
]

{ #category : 'accessing-magritte' }
RallyAccount >> descriptionDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #description;
		default: '';
		label: 'Description';
		priority: 20;
		yourself
]

{ #category : 'accessing' }
RallyAccount >> id [

	^ id
]

{ #category : 'accessing' }
RallyAccount >> id: anObject [

	id := anObject
]

{ #category : 'accessing-magritte' }
RallyAccount >> idDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #id;
		label: 'ID';
		priority: 10;
		beRequired;
		yourself
]

{ #category : 'rendering' }
RallyAccount >> listItemParameters [
	| amountString |

	amountString := '$ ', self balance displayString.

	^ (Array with: self description with: self id with: amountString with: 'chevron_right')
]
