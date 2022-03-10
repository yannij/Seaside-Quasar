Class {
	#name : #CraneAirTrip,
	#superclass : #CraneObject,
	#instVars : [
		'departFlight',
		'returnFlight',
		'price'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneAirTrip >> departFlight [

	^ departFlight
]

{ #category : #accessing }
CraneAirTrip >> departFlight: anObject [

	departFlight := anObject
]

{ #category : #'accessing-magritte' }
CraneAirTrip >> departFlightDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #departFlight;
		label: 'Depart Flight';
		classes: {CraneAirlineFlight};
		priority: 10;
		yourself
]

{ #category : #accessing }
CraneAirTrip >> price [

	^ price
]

{ #category : #accessing }
CraneAirTrip >> price: anObject [

	price := anObject
]

{ #category : #'accessing-magritte' }
CraneAirTrip >> priceDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #price;
		label: 'Price';
		priority: 30;
		yourself
]

{ #category : #accessing }
CraneAirTrip >> returnFlight [

	^ returnFlight
]

{ #category : #accessing }
CraneAirTrip >> returnFlight: anObject [

	returnFlight := anObject
]

{ #category : #'accessing-magritte' }
CraneAirTrip >> returnFlightDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #returnFlight;
		label: 'Return Flight';
		classes: {CraneAirlineFlight};
		priority: 20;
		yourself
]
