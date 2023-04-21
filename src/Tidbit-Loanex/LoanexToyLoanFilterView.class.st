Class {
	#name : #LoanexToyLoanFilterView,
	#superclass : #LoanexFilterView,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #rendering }
LoanexToyLoanFilterView >> renderContentOn: html [

	self renderRefreshOn: html.
	self renderFilterBorrowerOn: html
]

{ #category : #rendering }
LoanexToyLoanFilterView >> renderFilterBorrowerOn: html [
	| callbackRef |

	"self renderFieldLabel: 'Borrower' on: html."

	callbackRef := self app reactiveObjectsAt: 'filterBorrower' ifAbsentPut: [
		(QuasarRefCallback name: 'filterBorrower' value: nil)
			callbackBlock: [ :ref :ajaxArg | self toyLoanBorrower refValue: ajaxArg. self toyLoanBorrower refValue ];
			emitRefreshOn;
			yourself ].
	self toyLoanBorrower: callbackRef.

	html qInput
		label: 'Borrower';
		vModel: self toyLoanBorrower refName;
		vOn: 'change' with: self toyLoanBorrower functionName, '(', self toyLoanBorrower refName, ')';
		yourself
]

{ #category : #accessing }
LoanexToyLoanFilterView >> toyLoanBorrower [

	^ self app filterValues toyLoanBorrower
]

{ #category : #accessing }
LoanexToyLoanFilterView >> toyLoanBorrower: anObject [

	self app filterValues toyLoanBorrower: anObject
]
