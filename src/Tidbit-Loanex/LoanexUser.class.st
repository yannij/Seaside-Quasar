Class {
	#name : #LoanexUser,
	#superclass : #LoanexRootObject,
	#instVars : [
		'dateCreated',
		'username',
		'passwordHash',
		'fullName',
		'email'
	],
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #voyage }
LoanexUser class >> descriptionContainer [
	<voyageContainer>

	^ VOContainer new
		collectionName: 'LonexUser'
		yourself
]

{ #category : #voyage }
LoanexUser class >> isVoyageRoot [

	^ true
]

{ #category : #rendering }
LoanexUser >> cardParameters [

	^ Array with: self username with: self fullName
]

{ #category : #accessing }
LoanexUser >> dateCreated [
	^ dateCreated
]

{ #category : #accessing }
LoanexUser >> dateCreated: anObject [
	dateCreated := anObject
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionDateCreated [
	<magritteDescription>

	^ MADateAndTimeDescription new
		"accessor: #dateCreated;"
		accessor: (MAPluggableAccessor 
			read: [ :item | item dateCreated ]
			write: [ :item :value | value ifNotNil: [ :arg | item dateCreated: value ] ]);
		default: DateAndTime now printString;
		label: 'Date Created';
		cssClass: 'mcw-textfield';
		priority: 17;
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionEmail [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #email;
		default: '';
		label: 'Email';
		cssClass: 'mcw-textfield';
		priority: 30;
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionFullName [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #fullName;
		default: '';
		label: 'Full Name';
		cssClass: 'mcw-textfield';
		priority: 20;
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionPasswordHash [
	<magritteDescription>

	^ MAPasswordDescription new
		accessor: #passwordHash;
		default: '';
		label: 'Password';
		cssClass: 'mcw-textfield';
		priority: 15;
		beHidden;
		yourself
]

{ #category : #'accessing-magritte' }
LoanexUser >> descriptionUsername [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #username;
		default: '';
		label: 'Username';
		cssClass: 'mcw-textfield';
		priority: 10;
		yourself
]

{ #category : #accessing }
LoanexUser >> email [
	^ email
]

{ #category : #accessing }
LoanexUser >> email: anObject [
	email := anObject
]

{ #category : #accessing }
LoanexUser >> fullName [
	^ fullName
]

{ #category : #accessing }
LoanexUser >> fullName: anObject [
	fullName := anObject
]

{ #category : #initialization }
LoanexUser >> initialize [

	super initialize.

	self username: String new.
	self passwordHash: String new.
	self dateCreated: DateAndTime now.
	self fullName: String new.
	self email: String new
]

{ #category : #rendering }
LoanexUser >> listItemParameters [

	^ Array with: self username with: self fullName
]

{ #category : #printing }
LoanexUser >> mdPrimaryString [

	^ self username
]

{ #category : #printing }
LoanexUser >> mdSecondaryString [ 

	^ self fullName
]

{ #category : #accessing }
LoanexUser >> passwordHash [
	^ passwordHash
]

{ #category : #accessing }
LoanexUser >> passwordHash: anObject [
	passwordHash := anObject
]

{ #category : #accessing }
LoanexUser >> username [
	^ username
]

{ #category : #accessing }
LoanexUser >> username: anObject [
	username := anObject
]
