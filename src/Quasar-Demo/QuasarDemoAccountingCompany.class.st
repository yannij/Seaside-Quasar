Class {
	#name : #QuasarDemoAccountingCompany,
	#superclass : #QuasarDemoAccountingObject,
	#instVars : [
		'id',
		'name',
		'website',
		'email',
		'taxNumber',
		'country',
		'currency'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #printing }
QuasarDemoAccountingCompany >> attributeData [

	^ #(id name website email taxNumber country currency)
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> country [

	^ country
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> country: anObject [

	country := anObject
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> currency [

	^ currency
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> currency: anObject [

	currency := anObject
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> email [

	^ email
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> email: anObject [

	email := anObject
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> id [

	^ id
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> id: anObject [

	id := anObject
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> name [

	^ name
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> name: anObject [

	name := anObject
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> taxNumber [

	^ taxNumber
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> taxNumber: anObject [

	taxNumber := anObject
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> viewClass [

	^ QuasarDemoAccountingCompanyView
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> website [

	^ website
]

{ #category : #accessing }
QuasarDemoAccountingCompany >> website: anObject [

	website := anObject
]
