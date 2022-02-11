Class {
	#name : #TidbitExampleDatabase,
	#superclass : #Object,
	#classVars : [
		'Memory1',
		'Mongo1'
	],
	#category : #'Tidbit-ToDo-Model'
}

{ #category : #initalize }
TidbitExampleDatabase class >> buildUser: aUsername [

	self buildUser: aUsername repository: self memory1
]

{ #category : #initalize }
TidbitExampleDatabase class >> buildUser: aUsername repository: aRepository [
	| userModel itemCount today importance |

	importance := TidbitToDoItem importanceValues.

	userModel := TidbitUser new
		username: aUsername;
		fullName: aUsername capitalized, ' Test';
		email: aUsername, '@foo.com';
		website: 'http://foo.com/', aUsername;
		passwordHash: (MDQLogin passwordHashFor: 'secret');
		yourself.

	today := Date today.
	itemCount := 25 atRandom.
	1 to: itemCount do: [ :index |
		| priority todoItem |
		priority := 100 atRandom.
		todoItem := TidbitToDoItem new
			summary: 'task ', index printString;
			priority: priority;
			importance: (importance at: (priority \\ 3) + 1);
			completeByDate: (today addDays: priority - 30);
			completeByTime: (Time fromSeconds: (17 + 16 atRandom) * 60 * 30);
			estimatedDuration: (Duration minutes: ((12 atRandom) * 15));
			colorCode: (Color indexedColors at: 256 atRandom);
			yourself.
		(priority \\ 2) isZero ifTrue: [ todoItem done: true ].
		(priority \\ 5) isZero ifTrue: [
			todoItem description: (String loremIpsum truncateTo: 123) ].
		aRepository save: todoItem.
		userModel toDoItemsAdd: todoItem ].

	aRepository save: userModel.

	^ userModel

]

{ #category : #'class initialization' }
TidbitExampleDatabase class >> initialize [

	self repositorySetUpMemory1
	"self repositorySetUpMemorySingleton"
]

{ #category : #accessing }
TidbitExampleDatabase class >> memory1 [
	^ Memory1
]

{ #category : #accessing }
TidbitExampleDatabase class >> memory1: anObject [
	Memory1 := anObject
]

{ #category : #accessing }
TidbitExampleDatabase class >> memory1Clear [

	Memory1 ifNotNil: [ :value | value reset ].
	Memory1 := nil
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongo1 [
	^ Mongo1
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongo1: anObject [
	Mongo1 := anObject
]

{ #category : #initalize }
TidbitExampleDatabase class >> mongo1RecreateTestData [
	"
	self mongo1ResetConnection; mongo1RecreateTestData
	"

	self mongo1 ifNil: [
		"TODO: log an error"
		^ self ].

	self mongoRepositorySetUp: self mongo1
]

{ #category : #initalize }
TidbitExampleDatabase class >> mongo1ResetConnection [

	Mongo1 := self mongoRepositoryBuild
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongoDatabase [

	^ DockerDeploy current mongoDatabaseDefault
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongoHost [

	^ DockerDeploy current mongoHostDefault
		ifNotNil: [ :value | value ]
		ifNil: [ VOMongoRepository defaultHost ]
]

{ #category : #accessing }
TidbitExampleDatabase class >> mongoPort [

	^ DockerDeploy current mongoPortDefault
		ifNotNil: [ :value | value ]
		ifNil: [ VOMongoRepository defaultPort ]
]

{ #category : #initalize }
TidbitExampleDatabase class >> mongoRepositoryBuild [
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
TidbitExampleDatabase class >> mongoRepositorySetUp: aMongoRepository [
	"
	self mongo1Clear.
	self mongoRepositorySetUp: self mongoRepositoryBuild.
	"

	aMongoRepository removeAll: TidbitUser.
	aMongoRepository removeAll: TidbitToDoItem.

	1 to: 10 do: [ :index | self buildUser: 'mongo', index printString repository: aMongoRepository ]
]

{ #category : #initalize }
TidbitExampleDatabase class >> repositorySetUpMemory1 [
	"
	self memory1Clear.
	self repositorySetUpMemory1.
	"

	self memory1Clear.
	self memory1: VOMemoryRepository new.

	self buildUser: 'demo' repository: self memory1.
	self buildUser: 'guest' repository: self memory1.
	1 to: 10 do: [ :index |
		self buildUser: 'user', index printString repository: self memory1 ]
]

{ #category : #initalize }
TidbitExampleDatabase class >> repositorySetUpMemorySingleton [
	"
	self repositorySetUpMemorySingleton
	"
	| repository |

	VORepository current ifNotNil: [ :value | value reset ].
	repository := VOMemoryRepository new.
	repository enableSingleton.

	self buildUser: 'demo' repository: VORepository current.
	self buildUser: 'guest' repository: VORepository current.
	1 to: 10 do: [ :index |
		self buildUser: 'user', index printString repository: VORepository current ]
]
