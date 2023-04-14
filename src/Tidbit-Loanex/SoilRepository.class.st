Class {
	#name : #SoilRepository,
	#superclass : #Object,
	#instVars : [
		'root',
		'soilDatabase'
	],
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #'instance creation' }
SoilRepository class >> on: aSoil [

	^ self new
		soilDatabase: aSoil;
		yourself
]

{ #category : #accessing }
SoilRepository >> root [

	"root ifNil: [ root := self rootGet ]."
	^ root
]

{ #category : #accessing }
SoilRepository >> root: anObject [

	root := anObject
]

{ #category : #initialization }
SoilRepository >> rootCreate [
	| tx |

	root := IdentityDictionary new.
	tx := self soilDatabase newTransaction.
	tx root: root.
	tx commit
]

{ #category : #initialization }
SoilRepository >> rootGet [
	| tx |

	tx := self soilDatabase newTransaction.
	root := tx root.
	tx commit.
	^ root
]

{ #category : #actions }
SoilRepository >> save: anObject [
	| tx list |

	tx := self soilDatabase newTransaction.
	list := tx root at: anObject class name asSymbol ifAbsentPut: [ Set new ].
	list add: anObject.
	"tx makeRoot: anObject."
	"tx root: root."
	tx commit
]

{ #category : #persistence }
SoilRepository >> selectAll: aClass [

	^ self root at: aClass name asSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
SoilRepository >> soilDatabase [

	^ soilDatabase
]

{ #category : #accessing }
SoilRepository >> soilDatabase: anObject [

	soilDatabase := anObject
]
