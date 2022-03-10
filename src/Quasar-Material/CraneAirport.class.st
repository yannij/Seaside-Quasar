Class {
	#name : #CraneAirport,
	#superclass : #CraneObject,
	#instVars : [
		'airportIATA',
		'airportName',
		'city'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneAirport >> airportIATA [

	^ airportIATA
]

{ #category : #accessing }
CraneAirport >> airportIATA: anObject [

	airportIATA := anObject
]

{ #category : #'accessing-magritte' }
CraneAirport >> airportIATADescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #airportIATA;
		label: 'IATA';
		priority: 10;
		yourself
]

{ #category : #accessing }
CraneAirport >> airportName [

	^ airportName
]

{ #category : #accessing }
CraneAirport >> airportName: anObject [

	airportName := anObject
]

{ #category : #'accessing-magritte' }
CraneAirport >> airportNameDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #airportName;
		label: 'Airport Name';
		priority: 20;
		yourself
]

{ #category : #accessing }
CraneAirport >> city [

	^ city
]

{ #category : #accessing }
CraneAirport >> city: anObject [

	city := anObject
]

{ #category : #'accessing-magritte' }
CraneAirport >> cityDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #city;
		label: 'City';
		classes: {CraneCity};
		priority: 30;
		yourself
]
