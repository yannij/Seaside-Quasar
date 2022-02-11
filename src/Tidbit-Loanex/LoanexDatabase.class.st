Class {
	#name : #LoanexDatabase,
	#superclass : #Object,
	#classVars : [
		'Memory1',
		'Mongo1'
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

{ #category : #accessing }
LoanexDatabase class >> mongo1 [
	^ Mongo1
]

{ #category : #accessing }
LoanexDatabase class >> mongo1: anObject [
	Mongo1 := anObject
]

{ #category : #initalize }
LoanexDatabase class >> mongo1RecreateTestData [
	"
	self mongo1ResetConnection; mongo1RecreateTestData
	"

	self mongo1 ifNil: [
		"TODO: log an error"
		^ self ].

	self mongoRepositorySetUp: self mongo1
]

{ #category : #initalize }
LoanexDatabase class >> mongo1ResetConnection [

	Mongo1 := self mongoRepositoryBuild
]

{ #category : #accessing }
LoanexDatabase class >> mongoDatabase [

	^ DockerDeploy current mongoDatabaseDefault
]

{ #category : #accessing }
LoanexDatabase class >> mongoHost [

	^ DockerDeploy current mongoHostDefault
		ifNotNil: [ :value | value ]
		ifNil: [ VOMongoRepository defaultHost ]
]

{ #category : #accessing }
LoanexDatabase class >> mongoPort [

	^ DockerDeploy current mongoPortDefault
		ifNotNil: [ :value | value ]
		ifNil: [ VOMongoRepository defaultPort ]
]

{ #category : #initalize }
LoanexDatabase class >> mongoRepositoryBuild [
	| mongo username pwd |

	"
	To set up config values, run:
		DockerDeploy current runStartup
	"
	username := DockerDeploy current secretsAt: DockerDeploy defaultMongoSecretName atKey: 'mongo-username'.
	(username isNil or: [ username isEmpty ]) ifTrue: [
		^ self error: 'mongo-username is nil or empty' ].
	pwd := DockerDeploy current secretsAt: DockerDeploy defaultMongoSecretName atKey: 'mongo-password'.
	(pwd isNil or: [ pwd isEmpty ]) ifTrue: [
		^ self error: 'mongo-password is nil or empty' ].

	mongo := VOMongoRepository
		host: self mongoHost
		port: self mongoPort
		database: self mongoDatabase
		username: username
		password: pwd.

	^ mongo
]

{ #category : #initalize }
LoanexDatabase class >> mongoRepositorySetUp: aMongoRepository [
	"
	self mongo1Clear.
	self mongoRepositorySetUp: self mongoRepositoryBuild.
	"

	aMongoRepository removeAll: LoanexToyLoan.
	aMongoRepository removeAll: LoanexToy.
	aMongoRepository removeAll: LoanexUser.

	#('demo' 'guest' 'u1' 'u2' 'u3' 'u4' 'u5') do: [ :eachName |
		self buildUser: eachName repository: aMongoRepository ].
	self buildToys: 25 repository: aMongoRepository.
	self buildToyLoans: 9 repository: aMongoRepository
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

{ #category : #initalize }
LoanexDatabase class >> repositorySetUpMemorySingleton [
	"
	self repositorySetUpMemorySingleton
	"
	| repository |

	VORepository current ifNotNil: [ :value | value reset ].
	repository := VOMemoryRepository new.
	repository enableSingleton.

	#('demo' 'guest' 'u1' 'u2' 'u3' 'u4' 'u5') do: [ :eachName |
		self buildUser: eachName repository: repository ].
	self buildToys: 25 repository: repository.
	self buildToyLoans: 9 repository: repository
]
