Class {
	#name : #CraneFlySearch,
	#superclass : #CraneObject,
	#instVars : [
		'adultCount',
		'childrenCount',
		'cabinType',
		'origin',
		'destination',
		'startDate',
		'endDate',
		'priceMax',
		'durationMin',
		'durationMax',
		'stops'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #accessing }
CraneFlySearch >> adultCount [

	^ adultCount
]

{ #category : #accessing }
CraneFlySearch >> adultCount: anObject [

	adultCount := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> adultCountDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #adultCount;
		default: 0;
		label: '# Adults';
		priority: 10;
		beInteger;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> cabinType [

	^ cabinType
]

{ #category : #accessing }
CraneFlySearch >> cabinType: anObject [

	cabinType := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> cabinTypeDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #cabinType;
		label: 'Cabin';
		priority: 30;
		options: #('Economy' 'Business' 'First Class');
		yourself
]

{ #category : #accessing }
CraneFlySearch >> childrenCount [

	^ childrenCount
]

{ #category : #accessing }
CraneFlySearch >> childrenCount: anObject [

	childrenCount := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> childrenCountDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #childrenCount;
		default: 0;
		label: '# Children';
		priority: 20;
		beInteger;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> destination [

	^ destination
]

{ #category : #accessing }
CraneFlySearch >> destination: anObject [

	destination := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> destinationDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #destination;
		label: 'Destination';
		classes: {CraneCity};
		priority: 40;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> durationMax [

	^ durationMax
]

{ #category : #accessing }
CraneFlySearch >> durationMax: anObject [

	durationMax := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> durationMaxDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #durationMax;
		label: 'Max Duration';
		priority: 100;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> durationMin [

	^ durationMin
]

{ #category : #accessing }
CraneFlySearch >> durationMin: anObject [

	durationMin := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> durationMinDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #durationMin;
		label: 'Min Duration';
		priority: 90;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> endDate [

	^ endDate
]

{ #category : #accessing }
CraneFlySearch >> endDate: anObject [

	endDate := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> endDateDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #endDate;
		label: 'End Date';
		priority: 70;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> origin [

	^ origin
]

{ #category : #accessing }
CraneFlySearch >> origin: anObject [

	origin := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> originDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #origin;
		label: 'Origin';
		classes: {CraneCity};
		priority: 40;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> priceMax [

	^ priceMax
]

{ #category : #accessing }
CraneFlySearch >> priceMax: anObject [

	priceMax := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> priceMaxDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #priceMax;
		label: 'Max Price';
		priority: 80;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> startDate [

	^ startDate
]

{ #category : #accessing }
CraneFlySearch >> startDate: anObject [

	startDate := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> startDateDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #startDate;
		label: 'Start Date';
		priority: 60;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> stops [

	^ stops
]

{ #category : #accessing }
CraneFlySearch >> stops: anObject [

	stops := anObject
]

{ #category : #'accessing-magritte' }
CraneFlySearch >> stopsDescription [
	<magritteDescription>

	^ MAMultipleOptionDescription new
		accessor: #stops;
		label: 'Stops';
		priority: 110;
		options: #(#'Nonstop' #'1 Stop' #'2+ Stops' );
		reference: MASymbolDescription new;
		yourself
]

{ #category : #accessing }
CraneFlySearch >> travellerSummary [
	| adultsString childrenString cabinString summary |

	adultsString := self adultCount refValue
		ifNil: [ '' ]
		ifNotNil: [ :value | value greaseString, ' Adults' ].

	childrenString := self childrenCount refValue
		ifNil: [ '' ]
		ifNotNil: [ :value | value greaseString, ' Children' ].

	cabinString := self cabinType refValue
		ifNil: [ '' ]
		ifNotNil: [ :value | value greaseString ].

	summary := OrderedCollection new.
	adultsString ifNotEmpty: [ summary add: adultsString ].
	childrenString ifNotEmpty: [ summary add: childrenString ].
	cabinString ifNotEmpty: [ summary add: cabinString ].

	^ summary
		ifEmpty: [ 'Passengers & Cabin' ]
		ifNotEmpty: [ ', ' join: summary ] 
]
