Class {
	#name : 'QuasarDemoSoilCheckpointRepository',
	#superclass : 'QuasarDemoSoilRepository',
	#instVars : [
		'txn'
	],
	#category : 'Quasar-Demo-Common',
	#package : 'Quasar-Demo',
	#tag : 'Common'
}

{ #category : 'api' }
QuasarDemoSoilCheckpointRepository >> close [

	(txn notNil and: [ txn isAborted not ]) ifTrue: [
		txn abort.
		txn := nil ].

	super close
]

{ #category : 'private' }
QuasarDemoSoilCheckpointRepository >> list: aClass [
	| tx list |

	tx := self txnLazy.

	list := self list: aClass transaction: tx.

	^ list
]

{ #category : 'persistence' }
QuasarDemoSoilCheckpointRepository >> save: anObject [
	| tx |

	tx := self txnLazy.
	self save: anObject transaction: tx.
	tx commitAndContinue
]

{ #category : 'accessing' }
QuasarDemoSoilCheckpointRepository >> txn [

	^ txn
]

{ #category : 'accessing' }
QuasarDemoSoilCheckpointRepository >> txn: anObject [

	txn := anObject
]

{ #category : 'accessing' }
QuasarDemoSoilCheckpointRepository >> txnLazy [

	txn ifNil: [ txn := soil newTransaction ].
	^ txn
]

{ #category : 'persistence' }
QuasarDemoSoilCheckpointRepository >> updateData: data class: aClass [
	| tx |

	tx := self txnLazy.
	self updateData: data class: aClass transaction: tx.
	tx commitAndContinue
]
