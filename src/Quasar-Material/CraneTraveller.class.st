Class {
	#name : 'CraneTraveller',
	#superclass : 'CraneObject',
	#instVars : [
		'dateOfBirth',
		'fullName',
		'email',
		'phone',
		'gender',
		'frequentFlyerNumber',
		'receiveMarketing'
	],
	#category : 'Quasar-Material-Crane',
	#package : 'Quasar-Material',
	#tag : 'Crane'
}

{ #category : 'accessing' }
CraneTraveller >> dateOfBirth [

	^ dateOfBirth
]

{ #category : 'accessing' }
CraneTraveller >> dateOfBirth: anObject [

	dateOfBirth := anObject
]

{ #category : 'accessing-magritte' }
CraneTraveller >> dateOfBirthDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #dateOfBirth;
		label: 'Date of Birth';
		priority: 10;
		yourself
]

{ #category : 'accessing' }
CraneTraveller >> email [

	^ email
]

{ #category : 'accessing' }
CraneTraveller >> email: anObject [

	email := anObject
]

{ #category : 'accessing-magritte' }
CraneTraveller >> emailDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #email;
		label: 'Email';
		priority: 30;
		yourself
]

{ #category : 'accessing' }
CraneTraveller >> frequentFlyerNumber [

	^ frequentFlyerNumber
]

{ #category : 'accessing' }
CraneTraveller >> frequentFlyerNumber: anObject [

	frequentFlyerNumber := anObject
]

{ #category : 'accessing-magritte' }
CraneTraveller >> frequentFlyerNumberDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #frequentFlyerNumber;
		label: 'Frequent Flyer Number';
		priority: 60;
		yourself
]

{ #category : 'accessing' }
CraneTraveller >> fullName [

	^ fullName
]

{ #category : 'accessing' }
CraneTraveller >> fullName: anObject [

	fullName := anObject
]

{ #category : 'accessing-magritte' }
CraneTraveller >> fullNameDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #fullName;
		label: 'Full Name';
		priority: 20;
		yourself
]

{ #category : 'accessing' }
CraneTraveller >> gender [

	^ gender
]

{ #category : 'accessing' }
CraneTraveller >> gender: anObject [

	gender := anObject
]

{ #category : 'accessing-magritte' }
CraneTraveller >> genderDescription [
	<magritteDescription>

	^ MAMultipleOptionDescription new
		accessor: #gender;
		label: 'Gender';
		priority: 50;
		options: #(M F);
		reference: MASymbolDescription new;
		yourself
]

{ #category : 'accessing' }
CraneTraveller >> phone [

	^ phone
]

{ #category : 'accessing' }
CraneTraveller >> phone: anObject [

	phone := anObject
]

{ #category : 'accessing-magritte' }
CraneTraveller >> phoneDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #phone;
		label: 'Phone';
		priority: 40;
		yourself
]

{ #category : 'accessing' }
CraneTraveller >> receiveMarketing [

	^ receiveMarketing
]

{ #category : 'accessing' }
CraneTraveller >> receiveMarketing: anObject [

	receiveMarketing := anObject
]

{ #category : 'accessing' }
CraneTraveller >> receiveMarketingDescription [
	<magritteDescription>

	^ MABooleanDescription new
		accessor: #receiveMarketing;
		label: 'Receive Marketing';
		priority: 70;
		default: false;
		yourself
]
