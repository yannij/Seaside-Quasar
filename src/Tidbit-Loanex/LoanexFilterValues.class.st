Class {
	#name : #LoanexFilterValues,
	#superclass : #Object,
	#instVars : [
		'toyAvailable',
		'toyOwner',
		'toyLoanBorrower'
	],
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #accessing }
LoanexFilterValues >> toyAvailable [

	^ toyAvailable
]

{ #category : #accessing }
LoanexFilterValues >> toyAvailable: anObject [

	toyAvailable := anObject
]

{ #category : #accessing }
LoanexFilterValues >> toyLoanBorrower [

	^ toyLoanBorrower
]

{ #category : #accessing }
LoanexFilterValues >> toyLoanBorrower: anObject [

	toyLoanBorrower := anObject
]

{ #category : #accessing }
LoanexFilterValues >> toyOwner [

	^ toyOwner
]

{ #category : #accessing }
LoanexFilterValues >> toyOwner: anObject [

	toyOwner := anObject
]
