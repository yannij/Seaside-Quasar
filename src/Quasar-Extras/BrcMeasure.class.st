Class {
	#name : #BrcMeasure,
	#superclass : #Object,
	#instVars : [
		'cityName',
		'min',
		'max',
		'sum',
		'count'
	],
	#category : #'Quasar-Extras'
}

{ #category : #accessing }
BrcMeasure class >> city: aCityName [

	^ self new cityName: aCityName; yourself
]

{ #category : #accessing }
BrcMeasure >> cityName [

	^ cityName
]

{ #category : #accessing }
BrcMeasure >> cityName: anObject [

	cityName := anObject
]

{ #category : #accessing }
BrcMeasure >> count [

	^ count
]

{ #category : #accessing }
BrcMeasure >> count: anObject [

	count := anObject
]

{ #category : #accessing }
BrcMeasure >> countIncrement [

	count := count + 1
]

{ #category : #initialization }
BrcMeasure >> initialize [

	super initialize.

	min := 100.0.
	max := -100.0.
	sum := 0.0.
	count := 0.

]

{ #category : #accessing }
BrcMeasure >> max [

	^ max
]

{ #category : #accessing }
BrcMeasure >> max: anObject [

	max := anObject
]

{ #category : #accessing }
BrcMeasure >> min [

	^ min
]

{ #category : #accessing }
BrcMeasure >> min: anObject [

	min := anObject
]

{ #category : #accessing }
BrcMeasure >> sum [

	^ sum
]

{ #category : #accessing }
BrcMeasure >> sum: anObject [

	sum := anObject
]

{ #category : #accessing }
BrcMeasure >> sumIncrementBy: anObject [

	sum := sum + anObject
]
