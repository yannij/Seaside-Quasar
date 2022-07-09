Class {
	#name : #QuasarDemoAccountingData,
	#superclass : #Object,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #'class initialization' }
QuasarDemoAccountingData class >> createData [
	"
	self createData
	"

	self createDemoUsers.
	self createDemoCompanies.
	self createDemoAccounts
]

{ #category : #'class initialization' }
QuasarDemoAccountingData class >> createDemoAccounts [
	| modelClass |

	modelClass := QuasarDemoAccountingAccount.
	modelClass instanceList: nil.

	#(
	('1' 'regular' 'Test Account-1-1' '22C-001' 'CDN' 1000.00 'TD Bank')
	('1' 'regular' 'Test Account-1-2' '22C-002' 'CDN' 1100.00 'TD Bank')
	('1' 'regular' 'Test Account-1-3' '22U-001' 'USD' 1200.00 'TD Bank')
	('2' 'regular' 'Test Account-2' '5555-001' 'USD' 2000.00 'CIBC')
	('3' 'non-profit' 'Test Account-3' 'RB-1234-001' 'CDN' 3000.00 'Royal Bank')
	) do: [ :data | | newObject |
		newObject := modelClass new
			companyId: (data at: 1);
			type: (data at: 2);
			name: (data at: 3);
			number: (data at: 4);
			currencyCode: (data at: 5);
			openingBalance: (data at: 6);
			bankName: (data at: 7);
			yourself.
		modelClass instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
QuasarDemoAccountingData class >> createDemoCompanies [
	| modelClass |

	modelClass := QuasarDemoAccountingCompany.
	modelClass instanceList: nil.

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
		modelClass instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
QuasarDemoAccountingData class >> createDemoUsers [
	| modelClass |

	modelClass := QuasarDemoAccountingUser.
	modelClass instanceList: nil.

	#(
	('1' 'Test User1' 'tu1@test.co' 'en_ca')
	('2' 'Test User2' 'tu2@test.co' 'en_ca')
	('3' 'Test User3' 'tu3@test.co' 'en_ca')
	) do: [ :data | | newObject |
		newObject := modelClass new
			"id name email locale"
			id: data first;
			name: data second;
			email: data third;
			locale: data fourth;
			yourself.
		modelClass instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
QuasarDemoAccountingData class >> initialize [

	self createData
]
