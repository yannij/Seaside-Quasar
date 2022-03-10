Class {
	#name : #CraneEatBooking,
	#superclass : #CraneObject,
	#instVars : [
		'id',
		'restaurant',
		'dinerCount',
		'diningDate',
		'diningTime'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneEatBooking >> dinerCount [

	^ dinerCount
]

{ #category : #accessing }
CraneEatBooking >> dinerCount: anObject [

	dinerCount := anObject
]

{ #category : #'accessing-magritte' }
CraneEatBooking >> dinerCountDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #dinerCount;
		default: 0;
		label: '# diners';
		priority: 30;
		beInteger;
		yourself
]

{ #category : #accessing }
CraneEatBooking >> diningDate [

	^ diningDate
]

{ #category : #accessing }
CraneEatBooking >> diningDate: anObject [

	diningDate := anObject
]

{ #category : #'accessing-magritte' }
CraneEatBooking >> diningDateDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #diningDate;
		default: Date today;
		label: 'Dining Date';
		priority: 40;
		yourself
]

{ #category : #accessing }
CraneEatBooking >> diningTime [

	^ diningTime
]

{ #category : #accessing }
CraneEatBooking >> diningTime: anObject [

	diningTime := anObject
]

{ #category : #'accessing-magritte' }
CraneEatBooking >> diningTimeDescription [
	<magritteDescription>

	^ MATimeDescription new
		accessor: #diningTime;
		label: 'Dining Time';
		priority: 50;
		yourself
]

{ #category : #accessing }
CraneEatBooking >> id [

	^ id
]

{ #category : #accessing }
CraneEatBooking >> id: anObject [

	id := anObject
]

{ #category : #'accessing-magritte' }
CraneEatBooking >> idDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #id;
		label: 'ID';
		priority: 5;
		beRequired;
		yourself
]

{ #category : #accessing }
CraneEatBooking >> restaurant [

	^ restaurant
]

{ #category : #accessing }
CraneEatBooking >> restaurant: anObject [

	restaurant := anObject
]

{ #category : #'accessing-magritte' }
CraneEatBooking >> restaurantDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #restaurant;
		label: 'Restaurant';
		classes: {CraneRestaurant};
		priority: 20;
		yourself
]
