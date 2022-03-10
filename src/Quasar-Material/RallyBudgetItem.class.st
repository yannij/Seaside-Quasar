Class {
	#name : #RallyBudgetItem,
	#superclass : #RallyObject,
	#instVars : [
		'id',
		'description',
		'amount',
		'amountSpent'
	],
	#category : #'Quasar-Material-Rally'
}

{ #category : #accessing }
RallyBudgetItem >> amount [

	^ amount
]

{ #category : #accessing }
RallyBudgetItem >> amount: anObject [

	amount := anObject
]

{ #category : #'accessing-magritte' }
RallyBudgetItem >> amountDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #amount;
		default: 0.0;
		label: 'Amount';
		priority: 30;
		yourself
]

{ #category : #accessing }
RallyBudgetItem >> amountSpent [

	^ amountSpent
]

{ #category : #accessing }
RallyBudgetItem >> amountSpent: anObject [

	amountSpent := anObject
]

{ #category : #'accessing-magritte' }
RallyBudgetItem >> amountSpentDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #amountSpent;
		default: 0.0;
		label: 'Amount Spent';
		priority: 40;
		yourself
]

{ #category : #rendering }
RallyBudgetItem >> cardParameters [

	^ Array with: self id with: self description
]

{ #category : #accessing }
RallyBudgetItem >> description [

	^ description
]

{ #category : #accessing }
RallyBudgetItem >> description: anObject [

	description := anObject
]

{ #category : #'accessing-magritte' }
RallyBudgetItem >> descriptionDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #description;
		default: '';
		label: 'Description';
		priority: 20;
		yourself
]

{ #category : #accessing }
RallyBudgetItem >> id [

	^ id
]

{ #category : #accessing }
RallyBudgetItem >> id: anObject [

	id := anObject
]

{ #category : #'accessing-magritte' }
RallyBudgetItem >> idDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #id;
		label: 'ID';
		priority: 10;
		beRequired;
		yourself
]

{ #category : #rendering }
RallyBudgetItem >> listItemParameters [

	^ (Array with: self description with: self spentRatio)
]

{ #category : #'accessing-magritte' }
RallyBudgetItem >> spentRatio [

	^ '{1} / {2}' format: (Array
		with: amountSpent displayString
		with: amount displayString)
]

{ #category : #'accessing-magritte' }
RallyBudgetItem >> spentRatioDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #spentRatio;
		label: 'Spent Ratio';
		priority: 50;
		beReadonly;
		yourself
]
