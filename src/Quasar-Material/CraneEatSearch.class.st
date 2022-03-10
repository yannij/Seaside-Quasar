Class {
	#name : #CraneEatSearch,
	#superclass : #CraneObject,
	#instVars : [
		'dinerCount',
		'diningDate',
		'diningTime',
		'city',
		'cuisine'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneEatSearch >> city [

	^ city
]

{ #category : #accessing }
CraneEatSearch >> city: anObject [

	city := anObject
]

{ #category : #'accessing-magritte' }
CraneEatSearch >> cityDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #city;
		label: 'City';
		classes: {CraneCity};
		priority: 30;
		yourself
]

{ #category : #accessing }
CraneEatSearch >> cuisine [

	^ cuisine
]

{ #category : #accessing }
CraneEatSearch >> cuisine: anObject [

	cuisine := anObject
]

{ #category : #'accessing-magritte' }
CraneEatSearch >> cuisineDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #cuisine;
		label: 'Cuisine';
		priority: 40;
		yourself
]

{ #category : #accessing }
CraneEatSearch >> dinerCount [

	^ dinerCount
]

{ #category : #accessing }
CraneEatSearch >> dinerCount: anObject [

	dinerCount := anObject
]

{ #category : #'accessing-magritte' }
CraneEatSearch >> dinerCountDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #dinerCount;
		default: 0;
		label: '# Diners';
		priority: 10;
		beInteger;
		yourself
]

{ #category : #accessing }
CraneEatSearch >> dinersDisplay [

	^ self dinerCount refValue
		ifNil: [ 'None' ]
		ifNotNil: [ :value | value greaseString, ' Diners' ]
]

{ #category : #'accessing-magritte' }
CraneEatSearch >> dinersDisplayDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #dinersDisplay;
		label: 'Diners Display';
		priority: 11;
		beReadonly;
		yourself
]

{ #category : #accessing }
CraneEatSearch >> diningDate [

	^ diningDate
]

{ #category : #accessing }
CraneEatSearch >> diningDate: anObject [

	diningDate := anObject
]

{ #category : #'accessing-magritte' }
CraneEatSearch >> diningDateDescription [
	<magritteDescription>

	^ MATimeDescription new
		accessor: #diningDate;
		label: 'Dining Date';
		priority: 20;
		yourself
]

{ #category : #accessing }
CraneEatSearch >> diningTime [

	^ diningTime
]

{ #category : #accessing }
CraneEatSearch >> diningTime: anObject [

	diningTime := anObject
]

{ #category : #'accessing-magritte' }
CraneEatSearch >> diningTimeDescription [
	<magritteDescription>

	^ MATimeDescription new
		accessor: #diningTime;
		label: 'Dining Time';
		priority: 25;
		yourself
]

{ #category : #accessing }
CraneEatSearch >> location [

	^ self city refValue
		ifNil: [ '' ]
		ifNotNil: [ :value | value cityName, ', ', value countryName ]
]

{ #category : #'accessing-magritte' }
CraneEatSearch >> locationDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #location;
		label: 'Location';
		priority: 31;
		beReadonly;
		yourself
]
