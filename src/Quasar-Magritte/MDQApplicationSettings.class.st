Class {
	#name : 'MDQApplicationSettings',
	#superclass : 'MDQModel',
	#instVars : [
		'mdqDensity',
		'mdqTheme',
		'mdqTypography',
		'fontFamily'
	],
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'accessing - magritte' }
MDQApplicationSettings >> densityDescription [
	<magritteDescription>

	^ MANumberDescription new
		accessor: #mdqDensity;
		default: 0;
		label: 'Density';
		priority: 10;
		beInteger;
		min: -3 max: 0;
		"mcwComponentClass: MARangeComponent;"
		yourself
]

{ #category : 'accessing' }
MDQApplicationSettings >> fontFamily [

	^ fontFamily
]

{ #category : 'accessing' }
MDQApplicationSettings >> fontFamily: anObject [

	fontFamily := anObject
]

{ #category : 'accessing - magritte' }
MDQApplicationSettings >> fontFamilyDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #fontFamily;
		default: '';
		label: 'FontFamily';
		options: MDQTypography availableFonts;
		priority: 10;
		yourself
]

{ #category : 'initialization' }
MDQApplicationSettings >> initialize [

	super initialize.

	self mdqTheme: MDQTheme new.
	self mdqDensity: -1.
	self fontFamily: MDQTypography fontFamilyDefault.
	"self mdqDensity: MDQDensity new."
	self mdqTypography: MDQTypography new
]

{ #category : 'accessing' }
MDQApplicationSettings >> mdqDensity [
	^ mdqDensity
]

{ #category : 'accessing' }
MDQApplicationSettings >> mdqDensity: anObject [
	mdqDensity := anObject
]

{ #category : 'accessing' }
MDQApplicationSettings >> mdqTheme [
	^ mdqTheme
]

{ #category : 'accessing' }
MDQApplicationSettings >> mdqTheme: anObject [
	mdqTheme := anObject
]

{ #category : 'accessing' }
MDQApplicationSettings >> mdqTypography [
	^ mdqTypography
]

{ #category : 'accessing' }
MDQApplicationSettings >> mdqTypography: anObject [
	mdqTypography := anObject
]

{ #category : 'accessing' }
MDQApplicationSettings >> toggleDenseView [

	self mdqDensity density < 0
		ifTrue: [ self mdqDensity density: 0 ]
		ifFalse: [ self mdqDensity density: -1 ]
]
