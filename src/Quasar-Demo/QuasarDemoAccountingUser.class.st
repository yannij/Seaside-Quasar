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

{ #category : #printing }
QuasarDemoAccountingUser class >> attributeData [

	^ #(id name email locale)
]

{ #category : #printing }
QuasarDemoAccountingUser class >> modelName [

	^ 'User'
]

{ #category : #accessing }
QuasarDemoAccountingUser class >> viewClass [

	^ QuasarDemoAccountingUserView
]

{ #category : #accessing }
QuasarDemoAccountingUser >> companies [
	| userCompanyList companyIdList |

	userCompanyList := QuasarDemoMemoryRepository current
		selectMany: QuasarDemoAccountingUserCompany
		where: [ :each | each userId = self id ].

	companyIdList := (userCompanyList collect: [ :each | each companyId ]) asSet.

	^ QuasarDemoMemoryRepository current
		selectMany: QuasarDemoAccountingCompany
		where: [ :each | companyIdList includes: each id ]
]

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
