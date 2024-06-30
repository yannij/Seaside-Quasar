Class {
	#name : 'CraneSleepSearch',
	#superclass : 'CraneObject',
	#instVars : [
		'adultCount',
		'childrenCount',
		'checkInDate',
		'checkOutDate',
		'city'
	],
	#category : 'Quasar-Material-Crane',
	#package : 'Quasar-Material',
	#tag : 'Crane'
}

{ #category : 'accessing' }
CraneSleepSearch >> adultCount [

	^ adultCount
]

{ #category : 'accessing' }
CraneSleepSearch >> adultCount: anObject [

	adultCount := anObject
]

{ #category : 'accessing-magritte' }
CraneSleepSearch >> adultCountDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #adultCount;
		default: 0;
		label: '# Adults';
		priority: 10;
		beInteger;
		yourself
]

{ #category : 'accessing' }
CraneSleepSearch >> checkInDate [

	^ checkInDate
]

{ #category : 'accessing' }
CraneSleepSearch >> checkInDate: anObject [

	checkInDate := anObject
]

{ #category : 'accessing-magritte' }
CraneSleepSearch >> checkInDateDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #checkInDate;
		label: 'Check-in Date';
		priority: 30;
		yourself
]

{ #category : 'accessing' }
CraneSleepSearch >> checkOutDate [

	^ checkOutDate
]

{ #category : 'accessing' }
CraneSleepSearch >> checkOutDate: anObject [

	checkOutDate := anObject
]

{ #category : 'accessing-magritte' }
CraneSleepSearch >> checkOutDateDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #checkOutDate;
		label: 'Check-out Date';
		priority: 40;
		yourself
]

{ #category : 'accessing' }
CraneSleepSearch >> childrenCount [

	^ childrenCount
]

{ #category : 'accessing' }
CraneSleepSearch >> childrenCount: anObject [

	childrenCount := anObject
]

{ #category : 'accessing-magritte' }
CraneSleepSearch >> childrenCountDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #childrenCount;
		default: 0;
		label: '# Children';
		priority: 20;
		beInteger;
		yourself
]

{ #category : 'accessing' }
CraneSleepSearch >> city [

	^ city
]

{ #category : 'accessing' }
CraneSleepSearch >> city: anObject [

	city := anObject
]

{ #category : 'accessing-magritte' }
CraneSleepSearch >> cityDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #city;
		label: 'City';
		classes: {CraneCity};
		priority: 50;
		yourself
]

{ #category : 'accessing' }
CraneSleepSearch >> guestsDisplay [
	| adultsString childrenString summary |

	adultsString := self adultCount refValue
		ifNil: [ '' ]
		ifNotNil: [ :value | value greaseString, ' Adults' ].

	childrenString := self childrenCount refValue
		ifNil: [ '' ]
		ifNotNil: [ :value | value greaseString, ' Children' ].

	summary := OrderedCollection new.
	adultsString ifNotEmpty: [ summary add: adultsString ].
	childrenString ifNotEmpty: [ summary add: childrenString ].

	^ summary
		ifEmpty: [ 'None' ]
		ifNotEmpty: [ ', ' join: summary ] 
]
