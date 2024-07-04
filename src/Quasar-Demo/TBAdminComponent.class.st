Class {
	#name : 'TBAdminComponent',
	#superclass : 'TBScreenComponent',
	#instVars : [
		'report'
	],
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'hooks' }
TBAdminComponent >> children [

	^ super children copyWith: self report
]

{ #category : 'initialization' }
TBAdminComponent >> createHeaderComponent [

	^ TBAdminHeaderComponent from: self
]

{ #category : 'rendering' }
TBAdminComponent >> goToPostListView [

	self answer
]

{ #category : 'initialization' }
TBAdminComponent >> initialize [

	super initialize.
	self report: (TBPostsReport from: self blog)
]

{ #category : 'rendering' }
TBAdminComponent >> renderScreenOn: html [

	html heading: 'Blog Admin'.
	html horizontalRule.
	html render: self report
]

{ #category : 'accessing' }
TBAdminComponent >> report [

	^ report
]

{ #category : 'accessing' }
TBAdminComponent >> report: anObject [

	report := anObject
]
