Class {
	#name : #LoanexToyLoadFilterView,
	#superclass : #LoanexFilterView,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #rendering }
LoanexToyLoadFilterView >> renderContentOn: html [

	self renderRefreshOn: html.
	self renderFilterBorrowerOn: html
]

{ #category : #rendering }
LoanexToyLoadFilterView >> renderFilterBorrowerOn: html [

	self renderFieldLabel: 'Borrower' on: html.

	html textInput
		onBlur: ((html jQuery ajax) callback: [ :value | self toyLoanBorrower: value ] value: (html jQuery this value));
		with: self toyLoanBorrower
]

{ #category : #accessing }
LoanexToyLoadFilterView >> toyLoanBorrower [

	^ self mdqApplicationGet filterValues toyLoanBorrower
]

{ #category : #accessing }
LoanexToyLoadFilterView >> toyLoanBorrower: anObject [

	self mdqApplicationGet filterValues toyLoanBorrower: anObject
]
