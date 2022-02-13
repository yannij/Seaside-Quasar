Class {
	#name : #QRallyAlertView,
	#superclass : #QRallyView,
	#category : #'Quasar-Demo-Rally'
}

{ #category : #rendering }
QRallyAlertView >> instanceList [

	^ RallyAlert instanceList
]

{ #category : #rendering }
QRallyAlertView >> renderInstancesOn: html [

	self renderAsCards: self instanceList on: html
]
