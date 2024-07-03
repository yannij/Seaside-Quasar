Class {
	#name : 'TBAdminComponent',
	#superclass : 'TBScreenComponent',
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'initialization' }
TBAdminComponent >> createHeaderComponent [

	^ TBAdminHeaderComponent from: self
]

{ #category : 'rendering' }
TBAdminComponent >> goToPostListView [

	self answer
]

{ #category : 'rendering' }
TBAdminComponent >> renderScreenOn: html [

	html heading: 'Blog Admin'.
	html horizontalRule
]
