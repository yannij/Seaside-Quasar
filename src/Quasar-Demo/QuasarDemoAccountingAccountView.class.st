Class {
	#name : #QuasarDemoAccountingAccountView,
	#superclass : #QuasarDemoAccountingView,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #rendering }
QuasarDemoAccountingAccountView >> renderDetailsOn: html [
	| companies transactions |

	companies := self model companyIn: self repositoryToUse.
	self renderModelLink: companies name: 'Company' on: html.

	html div with: [
		self renderMakeTransactions: html ].

	transactions := self model transactionsIn: self repositoryToUse.
	self renderDetail: transactions modelClass: QuasarDemoAccountingTransaction label: 'Transactions' on: html.
]

{ #category : #rendering }
QuasarDemoAccountingAccountView >> renderMakeTransactions: html [

	html text: 'Make example transactions: '.
	html qBtn label: '1'; type: 'a'; href: (html urlForAction: [
		self model makeExampleTransactions: 1 in: self repositoryToUse ]).
	html qBtn label: '10'; type: 'a'; href: (html urlForAction: [
		self model makeExampleTransactions: 10 in: self repositoryToUse ]).
	html qBtn label: '100'; type: 'a'; href: (html urlForAction: [
		self model makeExampleTransactions: 100 in: self repositoryToUse ]).
	html qBtn label: '1000'; type: 'a'; href: (html urlForAction: [
		self model makeExampleTransactions: 1000 in: self repositoryToUse ])
]
