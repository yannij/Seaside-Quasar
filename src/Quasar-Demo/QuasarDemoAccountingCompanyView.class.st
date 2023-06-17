Class {
	#name : #QuasarDemoAccountingCompanyView,
	#superclass : #QuasarDemoAccountingView,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #rendering }
QuasarDemoAccountingCompanyView >> renderDetailsOn: html [

	self renderDetail: self model accounts modelClass: QuasarDemoAccountingAccount label: 'Accounts' on: html.
	self renderDetail: self model users modelClass: QuasarDemoAccountingUser label: 'Users' on: html
]
