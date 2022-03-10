Class {
	#name : #CraneFlyBooking,
	#superclass : #CraneObject,
	#instVars : [
		'id',
		'flights',
		'travellers',
		'cabinType',
		'tripInsurance'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneFlyBooking >> cabinType [

	^ cabinType
]

{ #category : #accessing }
CraneFlyBooking >> cabinType: anObject [

	cabinType := anObject
]

{ #category : #'accessing-magritte' }
CraneFlyBooking >> cabinTypeDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #cabinType;
		label: 'Cabin';
		priority: 40;
		options: #('Economy' 'Business' 'First Class');
		yourself
]

{ #category : #accessing }
CraneFlyBooking >> flights [

	^ flights
]

{ #category : #accessing }
CraneFlyBooking >> flights: anObject [

	flights := anObject
]

{ #category : #'accessing-magritte' }
CraneFlyBooking >> flightsDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #flights;
		label: 'Flights';
		priority: 20;
		classes: (Array with: CraneAirlineFlight);
		yourself
]

{ #category : #accessing }
CraneFlyBooking >> id [

	^ id
]

{ #category : #accessing }
CraneFlyBooking >> id: anObject [

	id := anObject
]

{ #category : #'accessing-magritte' }
CraneFlyBooking >> idDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #id;
		label: 'ID';
		priority: 5;
		beRequired;
		yourself
]

{ #category : #accessing }
CraneFlyBooking >> travellers [

	^ travellers
]

{ #category : #accessing }
CraneFlyBooking >> travellers: anObject [

	travellers := anObject
]

{ #category : #'accessing-magritte' }
CraneFlyBooking >> travellersDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #travellers;
		label: 'Travellers';
		priority: 0;
		classes: (Array with: CraneTraveller);
		yourself
]

{ #category : #accessing }
CraneFlyBooking >> tripInsurance [

	^ tripInsurance
]

{ #category : #accessing }
CraneFlyBooking >> tripInsurance: anObject [

	tripInsurance := anObject
]

{ #category : #accessing }
CraneFlyBooking >> tripInsuranceDescription [
	<magritteDescription>

	^ MABooleanDescription new
		accessor: #tripInsurance;
		label: 'Trip Insurance';
		priority: 50;
		default: false;
		yourself
]
