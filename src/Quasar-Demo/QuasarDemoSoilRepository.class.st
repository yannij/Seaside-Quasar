Class {
	#name : #QuasarDemoSoilRepository,
	#superclass : #QuasarDemoRepository,
	#instVars : [
		'objectMap',
		'path',
		'soil'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #'demo data' }
QuasarDemoSoilRepository class >> createData [
	"
	self createData
	"

	current ifNotNil: [ :value | value close ].
	self current: (self path: 'soil-demo-acct').
	self current create.
	self current open.
	self createIn: self current.
	self current close
]

{ #category : #'instance creation' }
QuasarDemoSoilRepository class >> path: aString [

	^ self new
		path: aString;
		yourself
]

{ #category : #'demo data' }
QuasarDemoSoilRepository class >> soilCleanup [
	"
	self soilCleanup.
	QuasarDemoSoilRepository allInstances.
	QuasarDemoSoilRepository allInstances first pointersTo.
	"

	WAAdmin clearSessions.
	current ifNotNil: [ :value | value close ].
	self current: nil.
	self allInstances do: [ :value | value close ].
	Smalltalk garbageCollect; garbageCollect; garbageCollect
]

{ #category : #files }
QuasarDemoSoilRepository >> close [ 

	soil ifNotNil: [
		soil close ]
]

{ #category : #private }
QuasarDemoSoilRepository >> collectionNameFor: aClass [

	^ aClass name
]

{ #category : #persistence }
QuasarDemoSoilRepository >> commit: aBlock [

	#todo
]

{ #category : #persistence }
QuasarDemoSoilRepository >> count: aClass [

	^ (self listOf: aClass) size
]

{ #category : #persistence }
QuasarDemoSoilRepository >> count: aClass where: condition [

	^ (self selectMany: aClass where: condition) size
]

{ #category : #files }
QuasarDemoSoilRepository >> create [
	| tx dict |

	soil := (Soil path: self path)
		destroy;
		initializeFilesystem.

	tx := soil newTransaction.
	dict := SoilPersistentDictionary new.
	tx makeRoot: dict.
	tx root: dict.
	"tx markDirty: dict."
	tx commit.

	soil close
]

{ #category : #files }
QuasarDemoSoilRepository >> destroy [

	soil ifNotNil: [
		soil destroy ]
]

{ #category : #initialization }
QuasarDemoSoilRepository >> initialize [

	super initialize.

	"objectMap := Dictionary new"
]

{ #category : #private }
QuasarDemoSoilRepository >> list: aClass [
	| tx list |

	tx := self soil newTransaction.
	list := tx root at: (self collectionNameFor: aClass) ifAbsentPut: [ Set new ].
	"tx commit."

	list ifNil: [
		self crTrace: 'list not found for: ', aClass printString ].

	^ list
]

{ #category : #private }
QuasarDemoSoilRepository >> listOf: aClass [
	| objectSet |

	objectSet := self list: aClass.

	"^ aClass = aClass persistentClass 
		ifTrue: [ objectSet ]
		ifFalse: [ objectSet select: [ :each | each isKindOf: aClass] ]"
	^ objectSet
]

{ #category : #files }
QuasarDemoSoilRepository >> open [

	soil := (Soil path: self path) open; yourself
]

{ #category : #accessing }
QuasarDemoSoilRepository >> path [

	^ path
]

{ #category : #accessing }
QuasarDemoSoilRepository >> path: anObject [

	path := anObject
]

{ #category : #persistence }
QuasarDemoSoilRepository >> remove: anObject [

	^ (self list: anObject class)
		remove: anObject
		ifAbsent: [ "Do nothing" ]
]

{ #category : #persistence }
QuasarDemoSoilRepository >> removeAll: aClass [ 

	self removeCollection: aClass
]

{ #category : #persistence }
QuasarDemoSoilRepository >> removeCollection: aClass [ 

	#todo
	"objectMap 
		removeKey: (self collectionNameFor: aClass)
		ifAbsent: [ ""Do nothing"" ]"
]

{ #category : #persistence }
QuasarDemoSoilRepository >> save: anObject [
	| tx theRoot list |

	tx := self soil newTransaction.
	theRoot := tx root.
	list := tx root
		at: (self collectionNameFor: anObject class)
		ifAbsentPut: [
			| newList |
			newList := Set new.
			tx markDirty: theRoot.
			tx makeRoot: newList.
			newList ].
	tx markDirty: list.
	tx markDirty: theRoot.
	tx makeRoot: anObject.
	list add: anObject.
	tx commit
]

{ #category : #persistence }
QuasarDemoSoilRepository >> selectAll: aClass [

	^ self listOf: aClass
]

{ #category : #persistence }
QuasarDemoSoilRepository >> selectAll: aClass sortBy: sortBlock [

	^ sortBlock
		ifNotNil: [ (self listOf: aClass) sortedBy: sortBlock ]
		ifNil: [ self listOf: aClass ]
]

{ #category : #persistence }
QuasarDemoSoilRepository >> selectMany: aClass where: aBlock [

	aBlock ifNil: [ ^ self selectAll: aClass ].
	^ (self listOf: aClass) select: aBlock
]

{ #category : #persistence }
QuasarDemoSoilRepository >> selectMany: aClass where: aBlock limit: aLimit offset: anOffset [
	| list |

	list := self selectMany: aClass where: aBlock.
	(anOffset > list size) ifTrue: [ ^ {  } ].
	^ list asOrderedCollection
		copyFrom: anOffset + 1
		to: (anOffset + aLimit min: list size)
]

{ #category : #persistence }
QuasarDemoSoilRepository >> selectMany: aClass where: aBlock sortBy: sortBlock [

	^ sortBlock
		ifNotNil: [ (((self listOf: aClass) select: aBlock) asSortedCollection: sortBlock) asOrderedCollection ]
		ifNil: [ (self listOf: aClass) select: aBlock ]
]

{ #category : #persistence }
QuasarDemoSoilRepository >> selectOne: aClass where: aBlock [

	^ (self listOf: aClass) detect: aBlock ifNone: [ nil ]
]

{ #category : #accessing }
QuasarDemoSoilRepository >> soil [

	^ soil
]

{ #category : #accessing }
QuasarDemoSoilRepository >> soil: anObject [

	soil := anObject
]
