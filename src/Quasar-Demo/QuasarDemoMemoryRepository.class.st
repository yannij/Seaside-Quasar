Class {
	#name : 'QuasarDemoMemoryRepository',
	#superclass : 'QuasarDemoRepository',
	#instVars : [
		'objectMap'
	],
	#category : 'Quasar-Demo-Common',
	#package : 'Quasar-Demo',
	#tag : 'Common'
}

{ #category : 'accessing' }
QuasarDemoMemoryRepository class >> cleanup [
	"
	self cleanup.
	"

	self mapReset
]

{ #category : 'private' }
QuasarDemoMemoryRepository >> collectionNameFor: aClass [

	^ aClass name
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> commit: aBlock [

	#todo
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> count: aClass [

	^ (self listOf: aClass) size
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> count: aClass where: condition [

	^ (self selectMany: aClass where: condition) size
]

{ #category : 'initialization' }
QuasarDemoMemoryRepository >> initialize [

	super initialize.

	objectMap := Dictionary new
]

{ #category : 'private' }
QuasarDemoMemoryRepository >> list: aClass [

	^ objectMap 
		at: (self collectionNameFor: aClass) 
		ifAbsentPut: [ Set new ]
]

{ #category : 'private' }
QuasarDemoMemoryRepository >> listOf: aClass [
	| objectSet |

	objectSet := self list: aClass.

	"^ aClass = aClass persistentClass 
		ifTrue: [ objectSet ]
		ifFalse: [ objectSet select: [ :each | each isKindOf: aClass] ]"
	^ objectSet
]

{ #category : 'accessing' }
QuasarDemoMemoryRepository >> objectMap [

	^ objectMap
]

{ #category : 'accessing' }
QuasarDemoMemoryRepository >> objectMap: anObject [

	objectMap := anObject
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> remove: anObject [

	^ (self list: anObject class)
		remove: anObject
		ifAbsent: [ "Do nothing" ]
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> removeAll: aClass [ 

	self removeCollection: aClass
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> removeCollection: aClass [ 

	objectMap 
		removeKey: (self collectionNameFor: aClass)
		ifAbsent: [ "Do nothing" ]	
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> save: anObject [

	(self list: anObject class) add: anObject
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> selectAll: aClass [

	^ self listOf: aClass
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> selectAll: aClass sortBy: sortBlock [

	^ sortBlock
		ifNotNil: [ (self listOf: aClass) sortedBy: sortBlock ]
		ifNil: [ self listOf: aClass ]
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> selectMany: aClass where: aBlock [

	aBlock ifNil: [ ^ self selectAll: aClass ].
	^ (self listOf: aClass) select: aBlock
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> selectMany: aClass where: aBlock limit: aLimit offset: anOffset [
	| list |

	list := self selectMany: aClass where: aBlock.
	(anOffset > list size) ifTrue: [ ^ {  } ].
	^ list asOrderedCollection
		copyFrom: anOffset + 1
		to: (anOffset + aLimit min: list size)
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> selectMany: aClass where: aBlock sortBy: sortBlock [

	^ sortBlock
		ifNotNil: [ (((self listOf: aClass) select: aBlock) asSortedCollection: sortBlock) asOrderedCollection ]
		ifNil: [ (self listOf: aClass) select: aBlock ]
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> selectOne: aClass where: aBlock [

	^ (self listOf: aClass) detect: aBlock ifNone: [ nil ]
]

{ #category : 'persistence' }
QuasarDemoMemoryRepository >> updateData: data class: aClass [
	"Do nothing for memory persistence"
]
