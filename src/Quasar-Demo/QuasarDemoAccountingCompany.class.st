Class {
	#name : 'QuasarDemoAccountingCompany',
	#superclass : 'QuasarDemoAccountingObject',
	#instVars : [
		'id',
		'name',
		'website',
		'email',
		'taxNumber',
		'country',
		'currency'
	],
	#category : 'Quasar-Demo-Accounting',
	#package : 'Quasar-Demo',
	#tag : 'Accounting'
}

{ #category : 'printing' }
QuasarDemoAccountingCompany class >> attributeData [

	^ #(id name website email taxNumber country currency)
]

{ #category : 'printing' }
QuasarDemoAccountingCompany class >> modelName [

	^ 'Company'
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany class >> viewClass [

	^ QuasarDemoAccountingCompanyView
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> accountsIn: aRepo [

	^ aRepo
		selectMany: QuasarDemoAccountingAccount
		where: [ :each | each companyId = self id ]
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> country [

	^ country
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> country: anObject [

	country := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> currency [

	^ currency
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> currency: anObject [

	currency := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> email [

	^ email
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> email: anObject [

	email := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> id [

	^ id
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> id: anObject [

	id := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> name [

	^ name
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> taxNumber [

	^ taxNumber
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> taxNumber: anObject [

	taxNumber := anObject
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> usersIn: aRepo [
	| userCompanyList userIdList |

	userCompanyList := aRepo 
		selectMany: QuasarDemoAccountingUserCompany
		where: [ :each | each companyId = self id ].

	userIdList := (userCompanyList collect: [ :each | each userId ]) asSet.

	^ aRepo
		selectMany: QuasarDemoAccountingUser
		where: [ :each | userIdList includes: each id ]
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> website [

	^ website
]

{ #category : 'accessing' }
QuasarDemoAccountingCompany >> website: anObject [

	website := anObject
]
