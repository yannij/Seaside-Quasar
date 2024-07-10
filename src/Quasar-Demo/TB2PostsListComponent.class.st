Class {
	#name : 'TB2PostsListComponent',
	#superclass : 'TB2ScreenComponent',
	#instVars : [
		'showLoginError'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

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
TB2PostsListComponent >> pageNumber [

	^ self session pageNumberGet
]

{ #category : 'accessing' }
TB2PostsListComponent >> postsPerPage [

	^ self session postsPerPageGet
]

{ #category : 'accessing' }
TB2PostsListComponent >> postsPerPageRefName [

	^ self session postsPerPageRef refName
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
TB2PostsListComponent >> renderMakeDemoPostsOn: html with: postsCount [
	| max |

	"self session isLogged ifFalse: [ ^ self ]."

	max := 5000.
	html text: 'Add demo posts: '.
	0 to: 6 do: [ :x | | n  flag hint |
		n := 10 raisedTo: x.
		flag := postsCount + n > max.
		hint := flag
			ifTrue: [ 'Disabled: max # posts is ', max printString ]
			ifFalse: [ 'Add ', n asStringWithCommas, ' demo posts' ].
		html qBtn
			href: (html urlForAction: [ TB2ApplicationRootComponent createTinyBlogPosts: n ]);
			disable: flag;
			icon: 'add';
			label: n asStringWithCommas;
			with: [
				html qTooltip with: hint ] ]
]

{ #category : 'rendering' }
TB2PostsListComponent >> renderPaginationOf: posts on: html [

	html qPagination
		vModel: self session pageNumberRef refName;
		max: ((posts size + self postsPerPage - 1) // self postsPerPage);
		maxPages: 9; directionLinks; boundaryLinks;
		vOnUpdateModelValue: self session pageNumberRef functionName, '(pageNumber)'
]

{ #category : 'rendering' }
TB2PostsListComponent >> renderPostsOn: html [
	| posts |

	posts := self readSelectedPosts.
	self renderMakeDemoPostsOn: html with: posts size.
	self renderPostsPerPageSelectOn: html.
	html break; text: 'Posts per page: ', self postsPerPage printString.
	html break; text: 'Selected posts count: ', posts size asStringWithCommas.
	html break; text: 'Total posts count: ', self blog allBlogPosts size asStringWithCommas.
	html div class: 'q-pa-lg flex flex-center'; with: [
		self renderPaginationOf: posts on: html ].
	html div class: 'row'; class: 'items-start q-pa-md q-gutter-md'; with: [
		self renderSelectedPosts: posts on: html ]
]

{ #category : 'rendering' }
TB2PostsListComponent >> renderPostsPerPageSelectOn: html [

	html qSelect
		vModel: self postsPerPageRefName;
		vOnUpdateModelValue: self session postsPerPageRef functionName, '(', self postsPerPageRefName, ')';
		options: '[ 5, 10, 50, 100, 1000 ]';
		style: 'width: 250px';
		label: 'Rows Per Page'
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

{ #category : 'rendering' }
TB2PostsListComponent >> renderSelectedPosts: posts on: html [
	| postsOnPage offset end |

	offset := (self pageNumber - 1) * self postsPerPage + 1.
	end := (offset + self postsPerPage - 1) min: posts size.
	postsOnPage := posts copyFrom: offset to: end.

	postsOnPage do: [ :p | html render: (TBPostComponent new post: p) ]
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
