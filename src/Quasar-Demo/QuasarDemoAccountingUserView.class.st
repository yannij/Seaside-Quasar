Class {
	#name : 'QuasarDemoAccountingUserView',
	#superclass : 'QuasarDemoAccountingView',
	#category : 'Quasar-Demo-Accounting',
	#package : 'Quasar-Demo',
	#tag : 'Accounting'
}

{ #category : 'rendering' }
QuasarDemoAccountingUserView >> renderDetailsOn: html [
	| companies |

	companies := self model companiesIn: self repositoryToUse.
	self renderDetail: companies modelClass: QuasarDemoAccountingCompany label: 'Companies' on: html
]
