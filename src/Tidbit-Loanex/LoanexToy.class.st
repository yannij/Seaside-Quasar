Class {
	#name : #LoanexToy,
	#superclass : #LoanexRootObject,
	#instVars : [
		'summary',
		'description',
		'available',
		'dateAdded',
		'owner'
	],
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #voyage }
LoanexToy class >> descriptionContainer [
	<voyageContainer>

	^ VOContainer new
		collectionName: 'LonexToy'
		yourself
]

{ #category : #voyage }
LoanexToy class >> isVoyageRoot [

	^ true
]

{ #category : #voyage }
LoanexToy class >> mongoDateAdded [
	<voyageDescription>

	^ VOToOneDescription new
		attributeName: 'dateAdded';
		accessor: (MAPluggableAccessor
			read: [ :model | model dateAdded ]
			write: [ :model :value | model dateAdded: value asDate ]);
		yourself
]

{ #category : #accessing }
LoanexToy >> available [

	^ available
]

{ #category : #accessing }
LoanexToy >> available: anObject [

	available := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> availableDescription [
	<magritteDescription>

	^ MABooleanDescription new
		accessor: #available;
		label: 'Available';
		priority: 10;
		default: false;
		yourself
]

{ #category : #rendering }
LoanexToy >> cardParameters [

	^ Array with: self summaryLine with: self description with: self owner username
]

{ #category : #accessing }
LoanexToy >> dateAdded [

	^ dateAdded
]

{ #category : #accessing }
LoanexToy >> dateAdded: anObject [

	dateAdded := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> dateAddedDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #dateAdded;
		default: Date today;
		label: 'Date Added';
		priority: 30;
		yourself
]

{ #category : #accessing }
LoanexToy >> description [
	^ description
]

{ #category : #accessing }
LoanexToy >> description: anObject [
	description := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> descriptionDescription [
	<magritteDescription>

	^ MAMemoDescription new
		accessor: #description;
		default: '';
		label: 'Description';
		priority: 20;
		yourself
]

{ #category : #initialization }
LoanexToy >> initialize [

	super initialize.

	self available: true.
	self summary: String new.
	self description: String new
]

{ #category : #'accessing-magritte' }
LoanexToy >> isVoyageRoot [
	^ true
]

{ #category : #rendering }
LoanexToy >> listItemParameters [

	^ Array with: self summaryLine with: self description with: nil with: 'chevron_right'
]

{ #category : #printing }
LoanexToy >> mdPrimaryString [

	^ self summary
]

{ #category : #printing }
LoanexToy >> mdSecondaryString [

	^ self description
]

{ #category : #accessing }
LoanexToy >> owner [

	^ owner
]

{ #category : #accessing }
LoanexToy >> owner: anObject [

	owner := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> ownerDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #owner;
		label: 'Owner';
		classes: {LoanexUser};
		priority: 50;
		beRequired;
		yourself
]

{ #category : #accessing }
LoanexToy >> summary [
	^ summary
]

{ #category : #accessing }
LoanexToy >> summary: anObject [
	summary := anObject
]

{ #category : #'accessing-magritte' }
LoanexToy >> summaryDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #summary;
		default: '';
		label: 'Summary';
		priority: 15;
		beRequired;
		yourself
]

{ #category : #accessing }
LoanexToy >> summaryLine [

	^ (self available ifTrue: [''] ifFalse: ['* ']), self summary
]
