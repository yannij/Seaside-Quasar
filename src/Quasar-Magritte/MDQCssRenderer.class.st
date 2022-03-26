Class {
	#name : #MDQCssRenderer,
	#superclass : #MAComponentRenderer,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQCssRenderer >> renderContainer: aDescription [ 

	html div class: 'row'; class: 'q-col-gutter-md'; with: [
		super renderContainer: aDescription ]
]

{ #category : #rendering }
MDQCssRenderer >> renderControl: aDescription [

	html div class: 'col-4'; with: [
		super renderControl: aDescription ]
]

{ #category : #rendering }
MDQCssRenderer >> renderLabel: aDescription [
	"Do nothing. #renderElementOn: also does the label"
]
