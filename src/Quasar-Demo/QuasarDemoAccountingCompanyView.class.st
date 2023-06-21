Class {
	#name : #QuasarDemoAccountingCompanyView,
	#superclass : #QuasarDemoAccountingView,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #rendering }
QuasarDemoAccountingCompanyView >> renderDetailsOn: html [
	| accounts users |

	accounts := self model accountsIn: self repositoryToUse.
	self renderDetail: accounts modelClass: QuasarDemoAccountingAccount label: 'Accounts' on: html.

	users := self model usersIn: self repositoryToUse.
	self renderDetail: users modelClass: QuasarDemoAccountingUser label: 'Users' on: html
]
