Class {
	#name : #SoilRepository,
	#superclass : #Object,
	#instVars : [
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

{ #category : #initialization }
SoilRepository >> rootCreate [
	| tx theRoot |

	tx := self soilDatabase newTransaction.
	theRoot := Dictionary new.
	"tx makeRoot: theRoot."
	tx root: theRoot.
	tx commit
]

{ #category : #actions }
SoilRepository >> save: anObject [
	| tx theRoot list |

	tx := self soilDatabase newTransaction.
	theRoot := tx root.
	list := theRoot
		at: anObject class name
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
SoilRepository >> selectAll: aClass [
	| tx list |

	tx := self soilDatabase newTransaction.
	list := tx root at: aClass name asSymbol ifAbsent: [ nil ].
	^ list
]

{ #category : #accessing }
SoilRepository >> soilDatabase [

	^ soilDatabase
]

{ #category : #accessing }
SoilRepository >> soilDatabase: anObject [

	soilDatabase := anObject
]
