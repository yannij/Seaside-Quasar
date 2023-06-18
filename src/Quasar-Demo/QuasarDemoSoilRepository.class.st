Class {
	#name : #QuasarDemoSoilRepository,
	#superclass : #QuasarDemoRepository,
	#instVars : [
		'objectMap'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #'demo data' }
QuasarDemoSoilRepository class >> createData [
	"
	self createData
	"

	self createIn: self current
]

{ #category : #initalize }
QuasarDemoSoilRepository class >> soil1Reset [
	"
	self soil1Reset.
	"
	"| newSoil |

	Soil1 ifNotNil: [ :value | value soilDatabase close ].
	newSoil := Soil path: 'accounting'.
	self soil1: (SoilRepository on: newSoil)."
]

{ #category : #initalize }
QuasarDemoSoilRepository class >> soil1Setup [
	"
	self soil1Setup.
	"
	"| newSoil |

	Soil1 ifNotNil: [ :value | value soilDatabase close ].
	newSoil := (Soil path: 'accounting') destroy; initializeFilesystem; yourself.
	self soil1: (SoilRepository on: newSoil).
	self soil1 rootCreate."
]

{ #category : #private }
QuasarDemoSoilRepository >> collectionNameFor: aClass [

	^ aClass name
]

{ #category : #persistence }
QuasarDemoSoilRepository >> count: aClass [

	^ (self listOf: aClass) size
]

{ #category : #persistence }
QuasarDemoSoilRepository >> count: aClass where: condition [

	^ (self selectMany: aClass where: condition) size
]

{ #category : #initialization }
QuasarDemoSoilRepository >> initialize [

	super initialize.

	objectMap := Dictionary new
]

{ #category : #private }
QuasarDemoSoilRepository >> list: aClass [

	^ objectMap 
		at: (self collectionNameFor: aClass) 
		ifAbsentPut: [ Set new ]
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

{ #category : #accessing }
QuasarDemoSoilRepository >> objectMap [

	^ objectMap
]

{ #category : #accessing }
QuasarDemoSoilRepository >> objectMap: anObject [

	objectMap := anObject
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

	objectMap 
		removeKey: (self collectionNameFor: aClass)
		ifAbsent: [ "Do nothing" ]	
]

{ #category : #persistence }
QuasarDemoSoilRepository >> save: anObject [

	(self list: anObject class) add: anObject
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
