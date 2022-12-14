Class {
	#name : #LoanexDatabase,
	#superclass : #Object,
	#classVars : [
		'Memory1',
		'Soil1'
	],
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #initalize }
LoanexDatabase class >> buildToyLoans: itemCount repository: aRepository [
	| today allUsers allToys |

	allUsers := (aRepository selectAll: LoanexUser) asOrderedCollection.
	allToys := (aRepository selectAll: LoanexToy) asOrderedCollection.
	today := Date today.
	1 to: itemCount do: [ :index |
		| newObject |
		newObject := LoanexToyLoan new
			toy: (allToys at: index);
			borrower: allUsers atRandom;
			dateBorrowed: (today addDays: index negated);
			dateDue: (today addDays: index negated + 21);
			yourself.
		aRepository save: newObject.

		newObject toy available: false.
		aRepository save: newObject toy ]
]

{ #category : #initalize }
LoanexDatabase class >> buildToys: itemCount repository: aRepository [
	| today allUsers |

	allUsers := (aRepository selectAll: LoanexUser) asOrderedCollection.
	today := Date today.
	1 to: itemCount do: [ :index |
		| newObject |
		newObject := LoanexToy new
			"available: (index \\ 5) isZero not;"
			summary: 'toy ', index printString;
			dateAdded: (today addDays: index negated);
			owner: allUsers atRandom;
			yourself.
		100 atRandom even ifTrue: [
			newObject description: (String loremIpsum truncateTo: 123) ].
		aRepository save: newObject ]
]

{ #category : #initalize }
LoanexDatabase class >> buildUser: aUsername repository: aRepository [
	| userModel |

	userModel := LoanexUser new
		username: aUsername;
		fullName: aUsername capitalized, ' Test';
		email: aUsername, '@foo.com';
		passwordHash: (MDQLogin passwordHashFor: 'secret');
		yourself.

	aRepository save: userModel.

	^ userModel

]

{ #category : #'class initialization' }
LoanexDatabase class >> initialize [

	self repositorySetUpMemory1
	"self repositorySetUpMemorySingleton"
]

{ #category : #accessing }
LoanexDatabase class >> memory1 [
	^ Memory1
]

{ #category : #accessing }
LoanexDatabase class >> memory1: anObject [
	Memory1 := anObject
]

{ #category : #accessing }
LoanexDatabase class >> memory1Clear [

	Memory1 ifNotNil: [ :value | value reset ].
	Memory1 := nil
]

{ #category : #initalize }
LoanexDatabase class >> repositorySetUpMemory1 [
	"
	self memory1Clear.
	self repositorySetUpMemory1.
	"

	self memory1Clear.
	self memory1: VOMemoryRepository new.

	#('demo' 'guest' 'u1' 'u2' 'u3' 'u4' 'u5') do: [ :eachName |
		self buildUser: eachName repository: self memory1 ].
	self buildToys: 25 repository: self memory1.
	self buildToyLoans: 9 repository: self memory1
]

{ #category : #accessing }
LoanexDatabase class >> soil1 [

	^ Soil1
]

{ #category : #accessing }
LoanexDatabase class >> soil1: anObject [

	Soil1 := anObject
]

{ #category : #initalize }
LoanexDatabase class >> soil1Reset [
	"
	self soil1Reset.
	"
	| newSoil |

	Soil1 ifNotNil: [ :value | value soilDatabase close ].
	newSoil := Soil path: 'loanex'.
	self soil1: (SoilRepository on: newSoil).
]

{ #category : #initalize }
LoanexDatabase class >> soil1Setup [
	"
	self soil1Setup.
	"
	| newSoil |

	Soil1 ifNotNil: [ :value | value soilDatabase close ].
	newSoil := (Soil path: 'loanex') destroy; initializeFilesystem; yourself.
	self soil1: (SoilRepository on: newSoil).
	self soil1 rootCreate.

	#('demo' 'guest' 'u1' 'u2' 'u3' 'u4' 'u5') do: [ :eachName |
		self buildUser: eachName repository: self soil1 ].
	self buildToys: 25 repository: self soil1.
	self buildToyLoans: 9 repository: self soil1
]
