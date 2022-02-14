Class {
	#name : #MDQApplicationSettings,
	#superclass : #MDQModel,
	#instVars : [
		'mdcDensity',
		'mdcTheme',
		'mdcTypography',
		'autoResponsive'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQApplicationSettings >> autoResponsive [

	^ autoResponsive
]

{ #category : #accessing }
MDQApplicationSettings >> autoResponsive: anObject [

	autoResponsive := anObject
]

{ #category : #accessing }
MDQApplicationSettings >> autoResponsiveOff [

	self autoResponsive: false
]

{ #category : #accessing }
MDQApplicationSettings >> autoResponsiveOn [

	self autoResponsive: true
]

{ #category : #accessing }
MDQApplicationSettings >> colorTheme [

	^ self mdcTheme
]

{ #category : #initialization }
MDQApplicationSettings >> initialize [

	super initialize.

	self autoResponsive: true.
	self mdcDensity: MDQDensity new.
	self mdcTheme: MDQTheme new.
	self mdcTypography: MDQTypography new
]

{ #category : #accessing }
MDQApplicationSettings >> mdcDensity [
	^ mdcDensity
]

{ #category : #accessing }
MDQApplicationSettings >> mdcDensity: anObject [
	mdcDensity := anObject
]

{ #category : #accessing }
MDQApplicationSettings >> mdcTheme [
	^ mdcTheme
]

{ #category : #accessing }
MDQApplicationSettings >> mdcTheme: anObject [
	mdcTheme := anObject
]

{ #category : #accessing }
MDQApplicationSettings >> mdcTypography [
	^ mdcTypography
]

{ #category : #accessing }
MDQApplicationSettings >> mdcTypography: anObject [
	mdcTypography := anObject
]

{ #category : #accessing }
MDQApplicationSettings >> toggleAutoResponsive [

	self autoResponsive: self autoResponsive not
]

{ #category : #accessing }
MDQApplicationSettings >> toggleDenseView [

	self mdcDensity density < 0
		ifTrue: [ self mdcDensity density: 0 ]
		ifFalse: [ self mdcDensity density: -1 ]
]
