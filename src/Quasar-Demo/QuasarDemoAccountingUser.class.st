Class {
	#name : #QuasarDemoAccountingUser,
	#superclass : #QuasarDemoAccountingObject,
	#instVars : [
		'id',
		'name',
		'email',
		'locale'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #accessing }
QuasarDemoAccountingUser >> email [

	^ email
]

{ #category : #accessing }
QuasarDemoAccountingUser >> email: anObject [

	email := anObject
]

{ #category : #accessing }
QuasarDemoAccountingUser >> id [

	^ id
]

{ #category : #accessing }
QuasarDemoAccountingUser >> id: anObject [

	id := anObject
]

{ #category : #accessing }
QuasarDemoAccountingUser >> locale [

	^ locale
]

{ #category : #accessing }
QuasarDemoAccountingUser >> locale: anObject [

	locale := anObject
]

{ #category : #accessing }
QuasarDemoAccountingUser >> name [

	^ name
]

{ #category : #accessing }
QuasarDemoAccountingUser >> name: anObject [

	name := anObject
]

{ #category : #printing }
QuasarDemoAccountingUser >> summaryAttributes [

	^ #(id name email locale)
]
