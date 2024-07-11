Class {
	#name : 'TB2PostsReport',
	#superclass : 'MDQMarkupTable',
	#instVars : [
		'blog'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'instance creation' }
TB2PostsReport class >> filteredDescriptionsFrom: aBlogPost [
	"Filter only some descriptions for the report columns."

	^ aBlogPost magritteDescription select: [ :each |
		  #( title category date ) includes: each accessor selector ]
]

{ #category : 'instance creation' }
TB2PostsReport class >> from: aBlog [
	| report blogPosts |

	blogPosts := aBlog allBlogPosts.
	report := self rows: blogPosts description: (self filteredDescriptionsFrom: blogPosts anyOne).
	report blog: aBlog.
	report addColumn: (MACommandColumn new
			 addCommandOn: report selector: #viewPost: text: 'View';
			 yourself;
			 addCommandOn: report selector: #editPost: text: 'Edit';
			 yourself;
			 addCommandOn: report selector: #deletePost: text: 'Delete';
			 yourself).
	^ report
]

{ #category : 'actions' }
TB2PostsReport >> addPost [

	| post |
	post := self call: (self renderAddPostForm: TB2Post new).
	post ifNotNil: [
		blog writeBlogPost: post.
		self refreshReport ]
]

{ #category : 'accessing' }
TB2PostsReport >> blog [

	^ blog
]

{ #category : 'accessing' }
TB2PostsReport >> blog: anObject [

	blog := anObject
]

{ #category : 'actions' }
TB2PostsReport >> deletePost: aPost [

	(self confirm: 'Do you want remove this post ?') ifTrue: [
		blog removeBlogPost: aPost.
		self refreshReport ]
]

{ #category : 'actions' }
TB2PostsReport >> editPost: aPost [

	| post |
	post := self call: (self renderEditPostForm: aPost).
	post ifNotNil: [ "blog save" ]
]

{ #category : 'actions' }
TB2PostsReport >> refreshReport [

	self rows: blog allBlogPosts.
	self refresh
]

{ #category : 'rendering' }
TB2PostsReport >> renderAddPostForm: aPost [

	^ aPost asComponent
		  addDecoration: (MDQFormDecoration buttons: {
						   (#save -> 'Add post').
						   (#cancel -> 'Cancel') });
		  yourself
]

{ #category : 'rendering' }
TB2PostsReport >> renderContentOn: html [

	html qBtn
		href: (html urlForAction: [ self addPost ]);
		icon: 'add';
		label: 'Add post '.

	super renderContentOn: html
]

{ #category : 'rendering' }
TB2PostsReport >> renderEditPostForm: aPost [

	^ aPost asComponent
		  addDecoration: (MDQFormDecoration buttons: {
						   (#save -> 'Save post').
						   (#cancel -> 'Cancel') });
		  yourself
]

{ #category : 'rendering' }
TB2PostsReport >> renderViewPostForm: aPost [

	^ aPost asComponent
		  addDecoration:
			  (MDQFormDecoration buttons: { (#cancel -> 'Back') });
		  readonly: true;
		  yourself
]

{ #category : 'actions' }
TB2PostsReport >> viewPost: aPost [

	self call: (self renderViewPostForm: aPost)
]
