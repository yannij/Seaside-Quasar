Class {
	#name : 'TBPostsListComponent',
	#superclass : 'TBScreenComponent',
	#instVars : [
		'currentCategory',
		'showLoginError'
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

{ #category : 'actions' }
TBPostsListComponent >> goToAdministrationView [

	self call: TBAdminComponent new
]

{ #category : 'testing' }
TBPostsListComponent >> hasLoginError [

	^ showLoginError ifNil: [ false ]
]

{ #category : 'accessing' }
TBPostsListComponent >> loginErrorMessage [

	^ 'Incorrect login and/or password'
]

{ #category : 'actions' }
TBPostsListComponent >> loginErrorOccurred [

	showLoginError := true
]

{ #category : 'accessing' }
TBPostsListComponent >> readSelectedPosts [

	^ self currentCategory
		ifNil: [ self blog allVisibleBlogPosts ]
		ifNotNil: [
			self blog allVisibleBlogPostsFromCategory: self currentCategory ]
]

{ #category : 'rendering' }
TBPostsListComponent >> renderLoginErrorMessageIfAnyOn: html [

	self hasLoginError ifTrue: [
		showLoginError := false.
		html qBanner
			class: 'bg-negative';
			with: self loginErrorMessage ]
]

{ #category : 'rendering' }
TBPostsListComponent >> renderScreenOn: html [

	html div class: 'row'; with: [
		html div class: 'col-xs-12 col-sm-2 col-md-4'; with: [
			html render: (TBCategoriesComponent
					 categories: self blog allCategories
					 postsList: self) ].

		html div class: 'col-xs-12 col-sm-10 col-md-8'; with: [
			self renderLoginErrorMessageIfAnyOn: html.
			html div class: 'row'; class: 'items-start q-pa-md q-gutter-md'; with: [
				self readSelectedPosts do: [ :p |
					html render: (TBPostComponent new post: p) ] ] ] ]
]

{ #category : 'actions' }
TBPostsListComponent >> tryConnectionWithLogin: login andPassword: password [

	(login = self blog administrator login and: [
		 (SHA256 hashMessage: password) = self blog administrator password ])
		ifTrue: [
			self session currentAdmin: self blog administrator.
			self goToAdministrationView ]
		ifFalse: [ self loginErrorOccurred ]
]
