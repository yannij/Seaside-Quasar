Class {
	#name : #RallyData,
	#superclass : #Object,
	#category : #'Quasar-Demo'
}

{ #category : #'class initialization' }
RallyData class >> createRallyAccounts [

	RallyAccount instanceList: nil.

	1 to: 5 do: [ :index | | newObject |
		newObject := RallyAccount new
				id: ('1234-', (index + 10 printPaddedWith: $0 to: 6));
				description: (#('Checking' 'Home Savings' 'Car Savings' 'Retirement' 'Vacation') at: (index \\ 5 + 1));
				balance: (100000 atRandom asFloat / 100);
			yourself.
		RallyAccount instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
RallyData class >> createRallyAlerts [

	RallyAlert instanceList: nil.

	1 to: 12 do: [ :index | | newObject |
		newObject := RallyAlert new
				id: index printString;
				description: (String loremIpsum truncateTo: 120);
			yourself.
		RallyAlert instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
RallyData class >> createRallyBills [
	| today |

	RallyBill instanceList: nil.

	today := Date today.

	1 to: 12 do: [ :index | | newObject |
		newObject := RallyBill new
				id: index printString;
				description: (#('RedPay Credit' 'Rent' 'TabFine Credit' 'ABC Loans' 'Farmer John''s' 'Pilrose') at: (index \\ 6 + 1));
				amount: (100000 atRandom asFloat / 100);
				dueDate: (today addDays: 60 atRandom - 30);
			yourself.
		RallyBill instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
RallyData class >> createRallyBudgetItems [

	RallyBudgetItem instanceList: nil.

	1 to: 6 do: [ :index | | amount spentPercent newObject |
		amount := 10000 atRandom.
		spentPercent := (100 atRandom min: 25) / 100.
		newObject := RallyBudgetItem new
				id: index printString;
				description: (#('Coffee Shops' 'Groceries' 'Restaurants' 'Clothing' 'Car Loan' 'Rent') at: (index \\ 6 + 1));
				amount: (amount asFloat / 100);
				amountSpent: (amount asFloat * spentPercent asFloat) / 100;
			yourself.
		RallyBudgetItem instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
RallyData class >> createRallyData [
	"
	self createRallyData
	"

	self createRallyAccounts.
	self createRallyBills.
	self createRallyBudgetItems.
	self createRallyAlerts

]

{ #category : #'class initialization' }
RallyData class >> initialize [

	self createRallyData
]
