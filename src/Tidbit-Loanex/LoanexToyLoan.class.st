Class {
	#name : #LoanexToyLoan,
	#superclass : #LoanexRootObject,
	#instVars : [
		'toy',
		'borrower',
		'dateBorrowed',
		'dateDue'
	],
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #voyage }
LoanexToyLoan class >> descriptionContainer [
	<voyageContainer>

	^ VOContainer new
		collectionName: 'LonexToyLoan'
		yourself
]

{ #category : #voyage }
LoanexToyLoan class >> isVoyageRoot [

	^ true
]

{ #category : #voyage }
LoanexToyLoan class >> mongoDateBorrowed [
	<voyageDescription>

	^ VOToOneDescription new
		attributeName: 'dateBorrowed';
		accessor: (MAPluggableAccessor
			read: [ :model | model dateBorrowed ]
			write: [ :model :value | model dateBorrowed: value asDate ]);
		yourself
]

{ #category : #voyage }
LoanexToyLoan class >> mongoDateDue [
	<voyageDescription>

	^ VOToOneDescription new
		attributeName: 'dateDue';
		accessor: (MAPluggableAccessor
			read: [ :model | model dateDue ]
			write: [ :model :value | model dateDue: value asDate ]);
		yourself
]

{ #category : #accessing }
LoanexToyLoan >> borrower [

	^ borrower
]

{ #category : #accessing }
LoanexToyLoan >> borrower: anObject [

	borrower := anObject
]

{ #category : #'accessing-magritte' }
LoanexToyLoan >> borrowerDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #borrower;
		label: 'Borrower';
		classes: {LoanexUser};
		cssClass: 'mcw-textfield';
		priority: 20;
		beRequired;
		yourself
]

{ #category : #accessing }
LoanexToyLoan >> dateBorrowed [

	^ dateBorrowed
]

{ #category : #accessing }
LoanexToyLoan >> dateBorrowed: anObject [

	dateBorrowed := anObject
]

{ #category : #'accessing-magritte' }
LoanexToyLoan >> dateBorrowedDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #dateBorrowed;
		default: Date today;
		label: 'Date Borrowed';
		cssClass: 'mcw-textfield';
		priority: 40;
		yourself
]

{ #category : #accessing }
LoanexToyLoan >> dateDue [

	^ dateDue
]

{ #category : #accessing }
LoanexToyLoan >> dateDue: anObject [

	dateDue := anObject
]

{ #category : #'accessing-magritte' }
LoanexToyLoan >> dateDueDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #dateDue;
		"default: Date today;"
		label: 'Date Due';
		cssClass: 'mcw-textfield';
		priority: 30;
		yourself
]

{ #category : #initialization }
LoanexToyLoan >> initialize [
	| today |

	super initialize.

	today := Date today.
	self dateBorrowed: today.
	self dateDue: (today addDays: 21)
]

{ #category : #accessing }
LoanexToyLoan >> mdPrimaryString [

	^ self toy mdPrimaryString
]

{ #category : #accessing }
LoanexToyLoan >> mdSecondaryString [

	^ 'Due ', self dateDue yyyymmdd, ', borrowed by ', self borrower mdPrimaryString
]

{ #category : #accessing }
LoanexToyLoan >> toy [

	^ toy
]

{ #category : #accessing }
LoanexToyLoan >> toy: anObject [

	toy := anObject
]

{ #category : #'accessing-magritte' }
LoanexToyLoan >> toyDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #toy;
		label: 'Toy';
		classes: {LoanexToy};
		cssClass: 'mcw-textfield';
		priority: 10;
		beRequired;
		yourself
]
