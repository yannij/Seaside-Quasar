Class {
	#name : #MDQCssRenderer,
	#superclass : #MAComponentRenderer,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQCssRenderer >> renderContainer: aDescription [ 

	html div
		class: 'row';
		vBind: 'class' with: '$q.screen.gt.xs ? ''q-col-gutter-md'' : ''q-col-gutter-xs''';
		with: [
			super renderContainer: aDescription ]
]

{ #category : #rendering }
MDQCssRenderer >> renderControl: aDescription [

	html div
		"vBind: 'class' with: '$q.screen.gt.md ? ($q.screen.gt.lg ? ''col-2'' : ''col-3'') : ($q.screen.gt.xs ? ($q.screen.gt.sm ? ''col-4'' : ''col-6'') : ''col-12'')';"
		class: 'col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-2';
		with: [
			super renderControl: aDescription ]
]

{ #category : #rendering }
MDQCssRenderer >> renderLabel: aDescription [
	"Do nothing. #renderElementOn: also does the label"
]
