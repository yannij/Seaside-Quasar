Class {
	#name : 'QuasarDemoAccountingAccount',
	#superclass : 'QuasarDemoAccountingObject',
	#instVars : [
		'id',
		'companyId',
		'type',
		'name',
		'number',
		'currencyCode',
		'openingBalance',
		'bankName',
		'bankPhone',
		'bankAddress'
	],
	#category : 'Quasar-Demo-Accounting',
	#package : 'Quasar-Demo',
	#tag : 'Accounting'
}

{ #category : 'printing' }
QuasarDemoAccountingAccount class >> attributeData [

	^ #(id companyId type name number currencyCode openingBalance bankName bankPhone bankAddress)
]

{ #category : 'printing' }
QuasarDemoAccountingAccount class >> modelName [

	^ 'Account'
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount class >> viewClass [

	^ QuasarDemoAccountingAccountView
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> bankAddress [

	^ bankAddress
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> bankAddress: anObject [

	bankAddress := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> bankName [

	^ bankName
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> bankName: anObject [

	bankName := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> bankPhone [

	^ bankPhone
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> bankPhone: anObject [

	bankPhone := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> companyId [

	^ companyId
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> companyId: anObject [

	companyId := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> companyIn: aRepo [

	^ aRepo
		selectOne: QuasarDemoAccountingCompany
		where: [ :each | each id = self companyId ]
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> currencyCode [

	^ currencyCode
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> currencyCode: anObject [

	currencyCode := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> id [

	^ id
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> id: anObject [

	id := anObject
]

{ #category : 'actions' }
QuasarDemoAccountingAccount >> makeExampleTransactions: aCount in: aRepo [

	aCount timesRepeat: [
		aRepo save: (QuasarDemoAccountingTransaction randomOnAccount: self in: aRepo) ]
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> name [

	^ name
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> number [

	^ number
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> number: anObject [

	number := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> openingBalance [

	^ openingBalance
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> openingBalance: anObject [

	openingBalance := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> transactionsIn: aRepo [

	^ aRepo
		selectMany: QuasarDemoAccountingTransaction
		where: [ :each | each accountId = self id ]
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> type [

	^ type
]

{ #category : 'accessing' }
QuasarDemoAccountingAccount >> type: anObject [

	type := anObject
]
