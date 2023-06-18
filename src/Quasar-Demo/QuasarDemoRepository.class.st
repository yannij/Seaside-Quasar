Class {
	#name : #QuasarDemoRepository,
	#superclass : #Object,
	#classInstVars : [
		'current'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #'demo data' }
QuasarDemoRepository class >> createData [

	self subclassResponsibility
]

{ #category : #'demo data' }
QuasarDemoRepository class >> createDemoAccountsIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoAccountingAccount.
	aRepository removeAll: modelClass.

	#(
	('1' '1' 'regular' 'Test Account-1-1' '22C-001' 'CDN' 1000.00 'TD Bank')
	('2' '1' 'regular' 'Test Account-1-2' '22C-002' 'CDN' 1100.00 'TD Bank')
	('3' '1' 'regular' 'Test Account-1-3' '22U-001' 'USD' 1200.00 'TD Bank')
	('4' '1' 'regular' 'CB-1' '7777-001' 'CDN' 1000.00 'CIBC')
	('5' '1' 'regular' 'CB-1' '7777-002' 'CDN' 1000.00 'CIBC')
	('6' '1' 'regular' 'CB-1' '7777-003' 'CDN' 1000.00 'CIBC')
	('7' '1' 'regular' 'CB-1' '7777-004' 'CDN' 1000.00 'CIBC')
	('8' '1' 'regular' 'CB-1' '7777-005' 'CDN' 1000.00 'CIBC')
	('9' '1' 'regular' 'CB-1' '7777-006' 'CDN' 1000.00 'CIBC')
	('10' '1' 'regular' 'CB-1' '7777-007' 'CDN' 1000.00 'CIBC')
	('11' '2' 'regular' 'Test Account-2' '5555-001' 'USD' 2000.00 'CIBC')
	('12' '3' 'non-profit' 'Test Account-3' 'RB-1234-001' 'CDN' 3000.00 'Royal Bank')
	) do: [ :data | | newObject |
		newObject := modelClass new
			id: (data at: 1);
			companyId: (data at: 2);
			type: (data at: 3);
			name: (data at: 4);
			number: (data at: 5);
			currencyCode: (data at: 6);
			openingBalance: (data at: 7);
			bankName: (data at: 8);
			yourself.
		aRepository save: newObject ]
]

{ #category : #'demo data' }
QuasarDemoRepository class >> createDemoCompaniesIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoAccountingCompany.
	aRepository removeAll: modelClass.

	#(
	('1' 'Test Company-1' 'www.company1.biz' '' 'BIZ-0001' 'CA' 'CAD')
	('2' 'Test Company-2' 'www.company2.biz' '' 'BIZ-0002' 'CA' 'USD')
	('3' 'Test Company-3' 'www.company3.org' '' 'ORG-0001' 'CA' 'CAD')
	('4' 'Test Company-4' 'www.company4.org' '' 'ORG-0002' 'CA' 'CAD')
	) do: [ :data | | newObject |
		newObject := modelClass new
			id: (data at: 1);
			name: (data at: 2);
			website: (data at: 3);
			email: (data at: 4);
			taxNumber: (data at: 5);
			country: (data at: 6);
			currency: (data at: 7);
			yourself.
		aRepository save: newObject ]
]

{ #category : #'demo data' }
QuasarDemoRepository class >> createDemoTransactionsIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoAccountingTransaction.
	aRepository removeAll: modelClass
]

{ #category : #'demo data' }
QuasarDemoRepository class >> createDemoUserCompaniesIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoAccountingUserCompany.
	aRepository removeAll: modelClass.

	#(
	('1' '1')
	('1' '2')
	('1' '3')
	('1' '4')
	('2' '2')
	) do: [ :data | | newObject |
		newObject := modelClass new
			userId: (data at: 1);
			companyId: (data at: 2);
			yourself.
		aRepository save: newObject ]
]

{ #category : #'demo data' }
QuasarDemoRepository class >> createDemoUsersIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoAccountingUser.
	aRepository removeAll: modelClass.

	#(
	('1' 'Test User1' 'tu1@test.co' 'en_ca')
	('2' 'Test User2' 'tu2@test.co' 'en_ca')
	('3' 'Test User3' 'tu3@test.co' 'en_ca')
	('4' 'Test User4' 'tu4@test.co' 'en_ca')
	('5' 'Test User5' 'tu5@test.co' 'en_ca')
	('6' 'Test User6' 'tu6@test.co' 'en_ca')
	('7' 'Test User7' 'tu7@test.co' 'en_ca')
	('8' 'Test User8' 'tu8@test.co' 'en_ca')
	) do: [ :data | | newObject |
		newObject := modelClass new
			"id name email locale"
			id: data first;
			name: data second;
			email: data third;
			locale: data fourth;
			yourself.
		aRepository save: newObject ]
]

{ #category : #'demo data' }
QuasarDemoRepository class >> createIn: aRepository [

	self createDemoUsersIn: aRepository.
	self createDemoCompaniesIn: aRepository.
	self createDemoAccountsIn: aRepository.
	self createDemoUserCompaniesIn: aRepository.
	self createDemoTransactionsIn: aRepository
]

{ #category : #accessing }
QuasarDemoRepository class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : #accessing }
QuasarDemoRepository class >> current: anObject [

	current := anObject
]

{ #category : #persistence }
QuasarDemoRepository >> collectionNameFor: aClass [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> commit: aBlock [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> count: aClass [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> count: aClass where: aDictionary [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> remove: anObject [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> removeAll: aClass [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> selectAll: aClass [

	^ self selectAll: aClass sortBy: nil
]

{ #category : #persistence }
QuasarDemoRepository >> selectAll: aClass sortBy: sortBlockOrSymbol [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> selectMany: aClass where: aDictionary [

	^ self selectMany: aClass where: aDictionary limit: nil
]

{ #category : #persistence }
QuasarDemoRepository >> selectMany: aClass where: aDictionary limit: aLimit [

	^ self selectMany: aClass where: aDictionary limit: aLimit offset: 0
]

{ #category : #persistence }
QuasarDemoRepository >> selectMany: aClass where: aDictionary limit: aLimit offset: anOffset [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> selectMany: aClass where: aBlock sortBy: sortBlockOrSymbol [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> selectOne: aClass where: aBlock [

	self subclassResponsibility
]
