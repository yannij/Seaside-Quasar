Class {
	#name : #CraneLodging,
	#superclass : #CraneObject,
	#instVars : [
		'lodgingName',
		'lodgingType',
		'address',
		'city',
		'distance',
		'price'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneLodging >> address [

	^ address
]

{ #category : #accessing }
CraneLodging >> address: anObject [

	address := anObject
]

{ #category : #'accessing-magritte' }
CraneLodging >> addressDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #address;
		label: 'Address';
		priority: 30;
		yourself
]

{ #category : #accessing }
CraneLodging >> city [

	^ city
]

{ #category : #accessing }
CraneLodging >> city: anObject [

	city := anObject
]

{ #category : #'accessing-magritte' }
CraneLodging >> cityDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #city;
		label: 'City';
		classes: {CraneCity};
		priority: 40;
		yourself
]

{ #category : #accessing }
CraneLodging >> distance [

	^ distance
]

{ #category : #accessing }
CraneLodging >> distance: anObject [

	distance := anObject
]

{ #category : #'accessing-magritte' }
CraneLodging >> distanceDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #distance;
		label: 'Distance';
		priority: 50;
		yourself
]

{ #category : #accessing }
CraneLodging >> lodgingName [

	^ lodgingName
]

{ #category : #accessing }
CraneLodging >> lodgingName: anObject [

	lodgingName := anObject
]

{ #category : #'accessing-magritte' }
CraneLodging >> lodgingNameDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #lodgingName;
		label: 'Lodging Name';
		priority: 10;
		yourself
]

{ #category : #accessing }
CraneLodging >> lodgingType [

	^ lodgingType
]

{ #category : #accessing }
CraneLodging >> lodgingType: anObject [

	lodgingType := anObject
]

{ #category : #'accessing-magritte' }
CraneLodging >> lodgingTypeDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #lodgingType;
		label: 'Lodging Type';
		priority: 20;
		options: #('Hotel' 'Apartment');
		yourself
]

{ #category : #accessing }
CraneLodging >> price [

	^ price
]

{ #category : #accessing }
CraneLodging >> price: anObject [

	price := anObject
]

{ #category : #'accessing-magritte' }
CraneLodging >> priceDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #price;
		label: 'Price';
		priority: 60;
		yourself
]
