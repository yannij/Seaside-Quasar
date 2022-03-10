Class {
	#name : #CraneAirlineFlight,
	#superclass : #CraneObject,
	#instVars : [
		'id',
		'airline',
		'origin',
		'destination',
		'departureDateTimeUTC',
		'arrivalDateTimeUTC',
		'price'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneAirlineFlight >> airline [

	^ airline
]

{ #category : #accessing }
CraneAirlineFlight >> airline: anObject [

	airline := anObject
]

{ #category : #'accessing-magritte' }
CraneAirlineFlight >> airlineDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #airline;
		label: 'Airline';
		priority: 20;
		beRequired;
		yourself
]

{ #category : #accessing }
CraneAirlineFlight >> arrivalDateTimeUTC [

	^ arrivalDateTimeUTC
]

{ #category : #accessing }
CraneAirlineFlight >> arrivalDateTimeUTC: anObject [

	arrivalDateTimeUTC := anObject
]

{ #category : #'accessing-magritte' }
CraneAirlineFlight >> arrivalDateTimeUTCDescription [
	<magritteDescription>

	^ MADateAndTimeDescription new
		accessor: #arrivalDateTimeUTC;
		label: 'Arrival UTC';
		priority: 60;
		yourself
]

{ #category : #accessing }
CraneAirlineFlight >> departureDateTimeUTC [

	^ departureDateTimeUTC
]

{ #category : #accessing }
CraneAirlineFlight >> departureDateTimeUTC: anObject [

	departureDateTimeUTC := anObject
]

{ #category : #'accessing-magritte' }
CraneAirlineFlight >> departureDateTimeUTCDescription [
	<magritteDescription>

	^ MADateAndTimeDescription new
		accessor: #departureDateTimeUTC;
		label: 'Departure UTC';
		priority: 50;
		yourself
]

{ #category : #accessing }
CraneAirlineFlight >> destination [

	^ destination
]

{ #category : #accessing }
CraneAirlineFlight >> destination: anObject [

	destination := anObject
]

{ #category : #'accessing-magritte' }
CraneAirlineFlight >> destinationDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #destination;
		label: 'Destination';
		classes: {CraneAirport};
		priority: 40;
		yourself
]

{ #category : #accessing }
CraneAirlineFlight >> id [

	^ id
]

{ #category : #accessing }
CraneAirlineFlight >> id: anObject [

	id := anObject
]

{ #category : #'accessing-magritte' }
CraneAirlineFlight >> idDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #id;
		label: 'ID';
		priority: 10;
		beRequired;
		yourself
]

{ #category : #accessing }
CraneAirlineFlight >> origin [

	^ origin
]

{ #category : #accessing }
CraneAirlineFlight >> origin: anObject [

	origin := anObject
]

{ #category : #'accessing-magritte' }
CraneAirlineFlight >> originDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #origin;
		label: 'Origin';
		classes: {CraneAirport};
		priority: 30;
		yourself
]

{ #category : #accessing }
CraneAirlineFlight >> price [

	^ price
]

{ #category : #accessing }
CraneAirlineFlight >> price: anObject [

	price := anObject
]

{ #category : #'accessing-magritte' }
CraneAirlineFlight >> priceDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #price;
		label: 'Price';
		priority: 70;
		yourself
]
