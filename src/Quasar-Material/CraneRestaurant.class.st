Class {
	#name : 'CraneRestaurant',
	#superclass : 'CraneObject',
	#instVars : [
		'restaurantName',
		'cuisine',
		'address',
		'city'
	],
	#category : 'Quasar-Material-Crane',
	#package : 'Quasar-Material',
	#tag : 'Crane'
}

{ #category : 'accessing' }
CraneRestaurant >> address [

	^ address
]

{ #category : 'accessing' }
CraneRestaurant >> address: anObject [

	address := anObject
]

{ #category : 'accessing-magritte' }
CraneRestaurant >> addressDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #address;
		label: 'Address';
		priority: 30;
		yourself
]

{ #category : 'accessing' }
CraneRestaurant >> city [

	^ city
]

{ #category : 'accessing' }
CraneRestaurant >> city: anObject [

	city := anObject
]

{ #category : 'accessing-magritte' }
CraneRestaurant >> cityDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #city;
		label: 'City';
		classes: {CraneCity};
		priority: 40;
		yourself
]

{ #category : 'accessing' }
CraneRestaurant >> cuisine [

	^ cuisine
]

{ #category : 'accessing' }
CraneRestaurant >> cuisine: anObject [

	cuisine := anObject
]

{ #category : 'accessing-magritte' }
CraneRestaurant >> cuisineDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #cuisine;
		label: 'Cuisine';
		priority: 20;
		yourself
]

{ #category : 'accessing' }
CraneRestaurant >> restaurantName [

	^ restaurantName
]

{ #category : 'accessing' }
CraneRestaurant >> restaurantName: anObject [

	restaurantName := anObject
]

{ #category : 'accessing-magritte' }
CraneRestaurant >> restaurantNameDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #restaurantName;
		label: 'Restaurant Name';
		priority: 10;
		yourself
]
