Class {
	#name : #RallyBill,
	#superclass : #RallyObject,
	#instVars : [
		'id',
		'description',
		'amount',
		'dueDate'
	],
	#category : #'Quasar-Material-Rally'
}

{ #category : #accessing }
RallyBill >> amount [

	^ amount
]

{ #category : #accessing }
RallyBill >> amount: anObject [

	amount := anObject
]

{ #category : #'accessing-magritte' }
RallyBill >> amountDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #amount;
		default: 0.0;
		label: 'Amount';
		cssClass: 'mcw-textfield';
		priority: 30;
		yourself
]

{ #category : #rendering }
RallyBill >> cardParameters [

	^ Array with: self id with: self description
]

{ #category : #accessing }
RallyBill >> description [

	^ description
]

{ #category : #accessing }
RallyBill >> description: anObject [

	description := anObject
]

{ #category : #'accessing-magritte' }
RallyBill >> descriptionDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #description;
		default: '';
		label: 'Description';
		cssClass: 'mcw-textfield';
		priority: 20;
		yourself
]

{ #category : #accessing }
RallyBill >> dueDate [

	^ dueDate
]

{ #category : #accessing }
RallyBill >> dueDate: anObject [

	dueDate := anObject
]

{ #category : #'accessing-magritte' }
RallyBill >> dueDateDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #dueDate;
		label: 'Due Date';
		cssClass: 'mcw-textfield';
		priority: 40;
		yourself
]

{ #category : #accessing }
RallyBill >> id [

	^ id
]

{ #category : #accessing }
RallyBill >> id: anObject [

	id := anObject
]

{ #category : #'accessing-magritte' }
RallyBill >> idDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #id;
		label: 'ID';
		cssClass: 'mcw-textfield';
		priority: 10;
		beRequired;
		yourself
]

{ #category : #rendering }
RallyBill >> listItemParameters [
	| amountString dueString |

	amountString := '$ ', self amount displayString.
	dueString := 'Due ', self dueDate displayString.

	^ (Array with: self description with: dueString with: amountString with: 'chevron_right')
]
