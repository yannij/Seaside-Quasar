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
MDQCssRenderer >> renderElement: aDescription [

	"html mdlCell
		style: 'margin: 0';
		size: 12;
		tabletSize: 8;
		phoneSize: 4;
		stretch;
		with: [ super renderElement: aDescription ]."

	"html div class: 'mdc-form-field'; with: [
		super renderElement: aDescription]"
	super renderElement: aDescription

]

{ #category : #rendering }
MDQCssRenderer >> renderGroup: aDescription [

	super renderGroup: aDescription.

	"group isNil ifTrue: [ ^ self ].
	html definitionTerm
		class: 'group';
		with: group"
]

{ #category : #rendering }
MDQCssRenderer >> renderLabel: aDescription [
	"Do nothing. #renderElementOn: also does the label"
]

{ #category : #visiting }
MDQCssRenderer >> visitAll: aCollection [

	"super visitAll: aCollection"
	aCollection do: [ :each | self visit: each ] separatedBy: [ self visitDivider ]
]

{ #category : #visiting }
MDQCssRenderer >> visitDivider [

	"html html: '<hr class=""mdc-list-divider"">'"
	"html div
		style: 'line-height: 8px';
		with: [html space]"
]
