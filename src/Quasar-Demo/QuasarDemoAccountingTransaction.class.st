Class {
	#name : #QuasarDemoAccountingTransaction,
	#superclass : #QuasarDemoAccountingObject,
	#instVars : [
		'id',
		'companyId',
		'number',
		'accountId',
		'amount'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #printing }
QuasarDemoAccountingTransaction class >> attributeData [

	^ #(number amount id companyId accountId)
]

{ #category : #printing }
QuasarDemoAccountingTransaction class >> modelName [

	^ 'Transaction'
]

{ #category : #'instance creation' }
QuasarDemoAccountingTransaction class >> randomOnAccount: anAccount in: aRepo [
	| numberOfAccountTxns |

	numberOfAccountTxns := (aRepo
		selectMany: self
		where: [ :each | each accountId = anAccount id ]) size.

	^ self new
		id: UUIDGenerator next;
		accountId: anAccount id;
		companyId: anAccount companyId;
		amount: 1000 atRandom;
		number: numberOfAccountTxns;
		yourself
]

{ #category : #accessing }
QuasarDemoAccountingTransaction class >> viewClass [

	^ QuasarDemoAccountingTransactionView
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> accountId [

	^ accountId
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> accountId: anObject [

	accountId := anObject
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> amount [

	^ amount
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> amount: anObject [

	amount := anObject
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> companiesIn: aRepo [
	| userCompanyList companyIdList |

	userCompanyList := aRepo
		selectMany: QuasarDemoAccountingUserCompany
		where: [ :each | each userId = self id ].

	companyIdList := (userCompanyList collect: [ :each | each companyId ]) asSet.

	^ aRepo
		selectMany: QuasarDemoAccountingCompany
		where: [ :each | companyIdList includes: each id ]
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> companyId [

	^ companyId
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> companyId: anObject [

	companyId := anObject
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> id [

	^ id
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> id: anObject [

	id := anObject
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> number [

	^ number
]

{ #category : #accessing }
QuasarDemoAccountingTransaction >> number: anObject [

	number := anObject
]
