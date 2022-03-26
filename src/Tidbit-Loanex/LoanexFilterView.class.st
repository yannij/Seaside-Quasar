Class {
	#name : #LoanexFilterView,
	#superclass : #QuasarComponent,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #rendering }
LoanexFilterView >> renderFieldLabel: aString on: html [

	html div
		class: 'text-subtitle1 q-py-md';
		with: aString
]

{ #category : #rendering }
LoanexFilterView >> renderRefreshOn: html [

	html qBtn round;
		onClick: ((html jQuery ajax)
			"callback: [  ];"
			onComplete: html javascript refresh);
		icon: 'refresh'
]
