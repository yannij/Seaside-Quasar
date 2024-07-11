Class {
	#name : 'TB2AdminComponent',
	#superclass : 'TB2ScreenComponent',
	#instVars : [
		'report'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'hooks' }
TB2AdminComponent >> children [

	^ super children copyWith: self report
]

{ #category : 'initialization' }
TB2AdminComponent >> createHeaderComponent [

	^ TB2AdminHeaderComponent from: self
]

{ #category : 'rendering' }
TB2AdminComponent >> goToPostListView [

	self answer
]

{ #category : 'initialization' }
TB2AdminComponent >> initialize [

	super initialize.
	self report: (TB2PostsReport from: self blog)
]

{ #category : 'rendering' }
TB2AdminComponent >> renderScreenOn: html [

	html div class: 'q-pa-md'; with: [
		html div class: 'text-h3'; with: 'Blog Admin'.
		html horizontalRule.
		html render: self report ]
]

{ #category : 'accessing' }
TB2AdminComponent >> report [

	^ report
]

{ #category : 'accessing' }
TB2AdminComponent >> report: anObject [

	report := anObject
]
