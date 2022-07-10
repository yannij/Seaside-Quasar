Class {
	#name : #QuasarDemoAccountingUserCompany,
	#superclass : #QuasarDemoAccountingObject,
	#instVars : [
		'userId',
		'companyId'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #accessing }
QuasarDemoAccountingUserCompany >> companyId [

	^ companyId
]

{ #category : #accessing }
QuasarDemoAccountingUserCompany >> companyId: anObject [

	companyId := anObject
]

{ #category : #accessing }
QuasarDemoAccountingUserCompany >> userId [

	^ userId
]

{ #category : #accessing }
QuasarDemoAccountingUserCompany >> userId: anObject [

	userId := anObject
]
