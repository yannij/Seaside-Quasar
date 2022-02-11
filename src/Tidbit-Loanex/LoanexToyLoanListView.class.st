Class {
	#name : #LoanexToyLoanListView,
	#superclass : #LoanexListView,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #rendering }
LoanexToyLoanListView >> modelClass [

	^ LoanexToyLoan
]

{ #category : #rendering }
LoanexToyLoanListView >> renderInstancesOn: html [
	| app list borrowerName |

	app := self mdqApplicationGet.
	list := app repository selectAll: self modelClass.

	borrowerName := app filterValues toyLoanBorrower.
	(borrowerName notNil and: [ borrowerName notEmpty ]) ifTrue: [
		list := list select: [ :eachInstance | eachInstance borrower username = borrowerName ] ].

	self renderTitle: 'Toy Loans' on: html.
	self renderAsCards: list on: html
]
