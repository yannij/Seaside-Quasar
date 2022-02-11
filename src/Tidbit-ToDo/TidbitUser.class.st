Class {
	#name : #TidbitUser,
	#superclass : #TidbitRootObject,
	#instVars : [
		'dateCreated',
		'dateInactive',
		'username',
		'passwordHash',
		'fullName',
		'email',
		'userSettings',
		'toDoItems',
		'website'
	],
	#category : #'Tidbit-ToDo-Model'
}

{ #category : #voyage }
TidbitUser class >> descriptionToDoItems [
	<voyageDescription>

	^ VOToManyDescription new
		attributeName: 'toDoItems';
		accessor: #toDoItems;
		beLazy;
		yourself
]

{ #category : #voyage }
TidbitUser class >> descriptionUserSettings [
	"<voyageDescription>"

	^ VOToOneDescription new
		attributeName: 'userSettings';
		accessor: #userSettings;
		beLazy;
		yourself
]

{ #category : #voyage }
TidbitUser class >> isVoyageRoot [

	^ true
]

{ #category : #accessing }
TidbitUser >> dateCreated [
	^ dateCreated
]

{ #category : #accessing }
TidbitUser >> dateCreated: anObject [
	dateCreated := anObject
]

{ #category : #accessing }
TidbitUser >> dateInactive [

	^ dateInactive
]

{ #category : #accessing }
TidbitUser >> dateInactive: anObject [

	dateInactive := anObject
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionDateCreated [
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
		beReadonly;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionDateInactive [
	<magritteDescription>

	^ MADateAndTimeDescription new
		"accessor: #dateInactive;"
		accessor: (MAPluggableAccessor 
			read: [ :item | item dateInactive ]
			write: [ :item :value | value ifNotNil: [ :arg | item dateInactive: value ] ]);
		default: DateAndTime now printString;
		label: 'Date Inactive';
		cssClass: 'mcw-textfield';
		priority: 18;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionEmail [
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
TidbitUser >> descriptionFullName [
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
TidbitUser >> descriptionPasswordHash [
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
TidbitUser >> descriptionToDoItems [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #toDoItems;
		classes: (Array with: TidbitToDoItem);
		default: OrderedCollection new;
		label: 'ToDo Items';
		cssClass: 'mcw-textfield';
		priority: 45;
		"beOrdered;"
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionToDoItemsCount [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #toDoItemsCount;
		default: 0;
		label: 'ToDo Count';
		cssClass: 'mcw-textfield';
		priority: 40;
		beInteger;
		beReadonly;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionUserSettings [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #userSettings;
		label: 'User Settings';
		classes: {TidbitUserSettings};
		cssClass: 'mcw-textfield';
		priority: 35;
		beRequired;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionUsername [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #username;
		default: '';
		label: 'Username';
		cssClass: 'mcw-textfield';
		priority: 10;
		beReadonly;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUser >> descriptionWebSite [
	<magritteDescription>

	^ MAUrlDescription new
		accessor: #website;
		default: '';
		label: 'Website';
		cssClass: 'mcw-textfield';
		priority: 35;
		yourself
]

{ #category : #accessing }
TidbitUser >> email [
	^ email
]

{ #category : #accessing }
TidbitUser >> email: anObject [
	email := anObject
]

{ #category : #accessing }
TidbitUser >> fullName [
	^ fullName
]

{ #category : #accessing }
TidbitUser >> fullName: anObject [
	fullName := anObject
]

{ #category : #initialization }
TidbitUser >> initialize [

	super initialize.

	self username: String new.
	self passwordHash: String new.
	self dateCreated: DateAndTime now.
	self fullName: String new.
	self email: String new.
	self website: String new.

	self userSettings: (TidbitUserSettings on: self).
	self toDoItems: OrderedCollection new.

]

{ #category : #printing }
TidbitUser >> mdPrimaryString [

	^ self username
]

{ #category : #accessing }
TidbitUser >> passwordHash [
	^ passwordHash
]

{ #category : #accessing }
TidbitUser >> passwordHash: anObject [
	passwordHash := anObject
]

{ #category : #accessing }
TidbitUser >> toDoItems [
	^ toDoItems
]

{ #category : #accessing }
TidbitUser >> toDoItems: anObject [
	toDoItems := anObject
]

{ #category : #accessing }
TidbitUser >> toDoItemsAdd: anItem [

	self toDoItems add: anItem
]

{ #category : #accessing }
TidbitUser >> toDoItemsCount [

	^ toDoItems size
]

{ #category : #accessing }
TidbitUser >> userSettings [
	^ userSettings
]

{ #category : #accessing }
TidbitUser >> userSettings: anObject [
	userSettings := anObject
]

{ #category : #accessing }
TidbitUser >> username [
	^ username
]

{ #category : #accessing }
TidbitUser >> username: anObject [
	username := anObject
]

{ #category : #accessing }
TidbitUser >> website [
	^ website
]

{ #category : #accessing }
TidbitUser >> website: anObject [
	website := anObject
]
