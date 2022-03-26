Class {
	#name : #MDQApplicationSettings,
	#superclass : #MDQModel,
	#instVars : [
		'mdqDensity',
		'mdqTheme',
		'mdqTypography'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQApplicationSettings >> colorTheme [

	^ self mdqTheme
]

{ #category : #initialization }
MDQApplicationSettings >> initialize [

	super initialize.

	self mdqDensity: MDQDensity new.
	self mdqTheme: MDQTheme new.
	self mdqTypography: MDQTypography new
]

{ #category : #accessing }
MDQApplicationSettings >> mdqDensity [
	^ mdqDensity
]

{ #category : #accessing }
MDQApplicationSettings >> mdqDensity: anObject [
	mdqDensity := anObject
]

{ #category : #accessing }
MDQApplicationSettings >> mdqTheme [
	^ mdqTheme
]

{ #category : #accessing }
MDQApplicationSettings >> mdqTheme: anObject [
	mdqTheme := anObject
]

{ #category : #accessing }
MDQApplicationSettings >> mdqTypography [
	^ mdqTypography
]

{ #category : #accessing }
MDQApplicationSettings >> mdqTypography: anObject [
	mdqTypography := anObject
]

{ #category : #accessing }
MDQApplicationSettings >> toggleDenseView [

	self mdqDensity density < 0
		ifTrue: [ self mdqDensity density: 0 ]
		ifFalse: [ self mdqDensity density: -1 ]
]
