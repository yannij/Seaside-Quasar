Class {
	#name : #CraneCity,
	#superclass : #CraneObject,
	#instVars : [
		'cityName',
		'countryName'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneCity >> cityName [

	^ cityName
]

{ #category : #accessing }
CraneCity >> cityName: anObject [

	cityName := anObject
]

{ #category : #'accessing-magritte' }
CraneCity >> cityNameDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #cityName;
		label: 'City Name';
		priority: 10;
		yourself
]

{ #category : #accessing }
CraneCity >> countryName [

	^ countryName
]

{ #category : #accessing }
CraneCity >> countryName: anObject [

	countryName := anObject
]

{ #category : #'accessing-magritte' }
CraneCity >> countryNameDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #countryName;
		label: 'Country Name';
		priority: 20;
		yourself
]
