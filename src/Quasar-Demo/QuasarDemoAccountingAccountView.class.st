Class {
	#name : #QuasarDemoAccountingAccountView,
	#superclass : #QuasarDemoAccountingView,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #rendering }
QuasarDemoAccountingAccountView >> renderDetailsOn: html [

	self renderFieldsOf: self model company name: 'Company' on: html
]
