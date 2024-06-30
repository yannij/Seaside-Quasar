Class {
	#name : 'CraneSleepBooking',
	#superclass : 'CraneObject',
	#instVars : [
		'id',
		'travellers',
		'lodging'
	],
	#category : 'Quasar-Material-Crane',
	#package : 'Quasar-Material',
	#tag : 'Crane'
}

{ #category : 'accessing' }
CraneSleepBooking >> id [

	^ id
]

{ #category : 'accessing' }
CraneSleepBooking >> id: anObject [

	id := anObject
]

{ #category : 'accessing-magritte' }
CraneSleepBooking >> idDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #id;
		label: 'ID';
		priority: 5;
		beRequired;
		yourself
]

{ #category : 'accessing' }
CraneSleepBooking >> lodging [

	^ lodging
]

{ #category : 'accessing' }
CraneSleepBooking >> lodging: anObject [

	lodging := anObject
]

{ #category : 'accessing-magritte' }
CraneSleepBooking >> lodgingDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #lodging;
		label: 'Lodging';
		classes: {CraneLodging};
		priority: 20;
		yourself
]

{ #category : 'accessing' }
CraneSleepBooking >> travellers [

	^ travellers
]

{ #category : 'accessing' }
CraneSleepBooking >> travellers: anObject [

	travellers := anObject
]

{ #category : 'accessing-magritte' }
CraneSleepBooking >> travellersDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #travellers;
		label: 'Travellers';
		priority: 30;
		classes: (Array with: CraneTraveller);
		yourself
]
