Class {
	#name : 'TB2PostsListComponent',
	#superclass : 'TB2ScreenComponent',
	#instVars : [
		'currentCategory',
		'showLoginError'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'as yet unclassified' }
TB2PostsListComponent class >> createDemoPosts: aNumber [

	1 to: aNumber do: [ :i | | newPost |
		newPost := (TBPost
			            title: 'Post', i printString
			            text: 'Text of post ', i printString
			            category: 'Category', (i \\ 5) printString)
			           visible: true;
			           yourself.
		TBBlog current writeBlogPost: newPost ]
]

{ #category : 'accessing' }
TB2PostsListComponent >> currentCategory [

	^ currentCategory
]

{ #category : 'accessing' }
TB2PostsListComponent >> currentCategory: anObject [

	currentCategory := anObject
]

{ #category : 'actions' }
TB2PostsListComponent >> goToAdministrationView [

	self call: TB2AdminComponent new
]

{ #category : 'testing' }
TB2PostsListComponent >> hasLoginError [

	^ showLoginError ifNil: [ false ]
]

{ #category : 'accessing' }
TB2PostsListComponent >> loginErrorMessage [

	^ 'Incorrect login and/or password'
]

{ #category : 'actions' }
TB2PostsListComponent >> loginErrorOccurred [

	showLoginError := true
]

{ #category : 'accessing' }
TB2PostsListComponent >> readSelectedPosts [

	^ self session currentCategoryGet
		ifNil: [ self blog allVisibleBlogPosts ]
		ifNotNil: [ :value | self blog allVisibleBlogPostsFromCategory: value ]
]

{ #category : 'rendering' }
TB2PostsListComponent >> renderCategoriesOn: html [

	html qList with: [
		html qItemLabel header; with: 'Categories'.
		self blog allCategories do: [ :cat | self renderCategoryLinkOn: html with: cat ].
		self renderCategoryLinkOn: html with: nil ]
]

{ #category : 'rendering' }
TB2PostsListComponent >> renderCategoryLinkOn: html with: aCategory [

	html qItem
		clickable; vRipple;
		vModel: 'currentCategory';
		vOnClick: self session currentCategoryRef functionName, '(', (aCategory ifNil: [ 'null' ] ifNotNil: [ :value | '"', value, '"' ]), ')';
		with: [
			html qItemSection with: [
				html qItemLabel
					with: (aCategory ifNil: [ '*All*' ] ifNotNil: [ :value | value ]) ] ]
]

{ #category : 'rendering' }
TB2PostsListComponent >> renderLoginErrorMessageIfAnyOn: html [

	self hasLoginError ifTrue: [
		showLoginError := false.
		html qBanner
			class: 'bg-negative';
			with: self loginErrorMessage ]
]

{ #category : 'rendering' }
TB2PostsListComponent >> renderPostsOn: html [
	| posts postsOnPage postsPerPage offset |

	postsPerPage := 3.
	posts := self readSelectedPosts.
	offset := (self session pageNumberRef refValue - 1) * postsPerPage + 1.
	postsOnPage := posts copyFrom: offset to: ((offset + postsPerPage - 1) min: posts size).

	html qPagination
		vModel: self session pageNumberRef refName;
		max: ((posts size + postsPerPage) // postsPerPage);
		vOnUpdateModelValue: self session pageNumberRef functionName, '(pageNumber)'.

	html div class: 'row'; class: 'items-start q-pa-md q-gutter-md'; with: [
		postsOnPage do: [ :p |
			html render: (TBPostComponent new post: p) ] ] 
]

{ #category : 'rendering' }
TB2PostsListComponent >> renderScreenOn: html [

	html div class: 'row'; with: [
		html div class: 'col-xs-12 col-sm-2 col-md-4'; with: [
			self renderCategoriesOn: html ].

		html div class: 'col-xs-12 col-sm-10 col-md-8'; with: [
			self renderLoginErrorMessageIfAnyOn: html.
			self renderPostsOn: html ] ]
]

{ #category : 'actions' }
TB2PostsListComponent >> tryConnectionWithLogin: login andPassword: password [

	(login = self blog administrator login and: [
		 (SHA256 hashMessage: password) = self blog administrator password ])
		ifTrue: [
			self session currentAdmin: self blog administrator.
			self goToAdministrationView ]
		ifFalse: [ self loginErrorOccurred ]
]
