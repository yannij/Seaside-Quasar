Class {
	#name : #MDQDensity,
	#superclass : #MDQModel,
	#instVars : [
		'density'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQDensity >> density [
	^ density
]

{ #category : #accessing }
MDQDensity >> density: anObject [
	density := anObject
]

{ #category : #accessing }
MDQDensity >> densityDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #density;
		default: 0;
		label: 'Density';
		priority: 10;
		beInteger;
		min: -3 max: 0;
		"mcwComponentClass: MARangeComponent;"
		yourself
]

{ #category : #initialization }
MDQDensity >> initialize [

	super initialize.
	
	self density: -1
]
