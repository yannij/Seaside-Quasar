Class {
	#name : #QuasarDemoAccountingAccount,
	#superclass : #QuasarDemoAccountingObject,
	#instVars : [
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
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #printing }
QuasarDemoAccountingAccount class >> attributeData [

	^ #(companyId type name number currencyCode openingBalance bankName bankPhone bankAddress)
]

{ #category : #printing }
QuasarDemoAccountingAccount class >> modelName [

	^ 'Account'
]

{ #category : #accessing }
QuasarDemoAccountingAccount class >> viewClass [

	^ QuasarDemoAccountingAccountView
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> bankAddress [

	^ bankAddress
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> bankAddress: anObject [

	bankAddress := anObject
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> bankName [

	^ bankName
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> bankName: anObject [

	bankName := anObject
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> bankPhone [

	^ bankPhone
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> bankPhone: anObject [

	bankPhone := anObject
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> company [

	^ QuasarDemoAccountingCompany instanceList
		detect: [ :each | each id = self companyId ]
		ifNone: [ nil ]
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> companyId [

	^ companyId
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> companyId: anObject [

	companyId := anObject
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> currencyCode [

	^ currencyCode
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> currencyCode: anObject [

	currencyCode := anObject
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> name [

	^ name
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> name: anObject [

	name := anObject
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> number [

	^ number
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> number: anObject [

	number := anObject
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> openingBalance [

	^ openingBalance
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> openingBalance: anObject [

	openingBalance := anObject
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> type [

	^ type
]

{ #category : #accessing }
QuasarDemoAccountingAccount >> type: anObject [

	type := anObject
]
