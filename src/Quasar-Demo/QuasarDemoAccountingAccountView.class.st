Class {
	#name : #QuasarDemoAccountingAccountView,
	#superclass : #QuasarDemoAccountingView,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #rendering }
QuasarDemoAccountingAccountView >> renderDetailsOn: html [

	self renderModelLink: self model company name: 'Company' on: html.

	html div with: [
		self renderMakeTransactions: html ].

	self renderDetail: self model transactions modelClass: QuasarDemoAccountingTransaction label: 'Transactions' on: html.
]

{ #category : #rendering }
QuasarDemoAccountingAccountView >> renderMakeTransactions: html [

	html text: 'Make example transactions: '.
	html qBtn label: '1'; type: 'a'; href: (html urlForAction: [ self model make1 ]).
	html qBtn label: '10'; type: 'a'; href: (html urlForAction: [ self model make10 ]).
	html qBtn label: '100'; type: 'a'; href: (html urlForAction: [ self model make100 ]).
	html qBtn label: '1000'; type: 'a'; href: (html urlForAction: [ self model make1000 ])
]
