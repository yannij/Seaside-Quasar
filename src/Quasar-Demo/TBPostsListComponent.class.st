Class {
	#name : 'TBPostsListComponent',
	#superclass : 'TBScreenComponent',
	#instVars : [
		'currentCategory'
	],
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'accessing' }
TBPostsListComponent >> currentCategory [

	^ currentCategory
]

{ #category : 'accessing' }
TBPostsListComponent >> currentCategory: anObject [

	currentCategory := anObject
]

{ #category : 'accessing' }
TBPostsListComponent >> readSelectedPosts [

	^ self currentCategory
		ifNil: [ self blog allVisibleBlogPosts ]
		ifNotNil: [
			self blog allVisibleBlogPostsFromCategory: self currentCategory ]
]

{ #category : 'rendering' }
TBPostsListComponent >> renderScreenOn: html [

	html div class: 'row'; with: [
		html div class: 'col-xs-12 col-sm-2 col-md-4'; with: [
			html render: (TBCategoriesComponent
					 categories: self blog allCategories
					 postsList: self) ].

		html div class: 'col-xs-12 col-sm-10 col-md-8'; with: [
			html div class: 'row'; class: 'items-start q-pa-md q-gutter-md'; with: [
				self readSelectedPosts do: [ :p |
					html render: (TBPostComponent new post: p) ] ] ] ]
]
