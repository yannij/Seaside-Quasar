Class {
	#name : #QuasarDemoAccountingUserView,
	#superclass : #QuasarDemoAccountingView,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #rendering }
QuasarDemoAccountingUserView >> renderDetailsOn: html [

	self renderDetail: self model companies modelClass: QuasarDemoAccountingCompany label: 'Companies' on: html
]
