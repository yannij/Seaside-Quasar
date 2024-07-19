"
I am a demo application originating from the TinyBlog tutorial  at https://github.com/SquareBracketAssociates/TinyBlog-EN. Here, the Seaside-Quasar version of TinyBlog is further adjusted to use additional features of Seaside-Quasar.
"
Class {
	#name : 'TB2ApplicationRootComponent',
	#superclass : 'QuasarApplication',
	#instVars : [
		'main'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'class initialization' }
TB2ApplicationRootComponent class >> applicationPath [

	^ 'tb2'
]

{ #category : 'testing' }
TB2ApplicationRootComponent class >> canBeRoot [

	^ true
]

{ #category : 'accessing' }
TB2ApplicationRootComponent class >> categoryName [

	^ #demo
]

{ #category : 'demo data' }
TB2ApplicationRootComponent class >> createData [
	"
	self createData.
	"

	self repositoryClass mapReset.
	self repositoryClass mapCreateAt: self databasePath.

	self createTinyBlogPosts: 9
]

{ #category : 'demo data' }
TB2ApplicationRootComponent class >> createTinyBlogPosts: aNumber [

	self createTinyBlogPosts: aNumber in: self tinyBlogRepository
]

{ #category : 'demo data' }
TB2ApplicationRootComponent class >> createTinyBlogPosts: aNumber in: aRepository [
	| start tmpBlog |

	tmpBlog := TB2Blog new.
	start := aRepository count: TB2Post.
	start + 1 to: start + aNumber do: [ :i | | newPost |
		newPost := TB2Post new
			title: 'Post', i printString;
			text: 'Text of post ', i printString;
			category: 'Category', (i \\ 10) printString;
			visible: true;
			yourself.
		tmpBlog writeBlogPost: newPost ]
]

{ #category : 'demo data' }
TB2ApplicationRootComponent class >> databasePath [

	^ 'tinyblog2'
]

{ #category : 'class initialization' }
TB2ApplicationRootComponent class >> initialize [
	"self initialize"

	| app |
	app := WAAdmin register: self asApplicationAt: self applicationPath.
	app preferenceAt: #sessionClass put: TB2Session
]

{ #category : 'initialization' }
TB2ApplicationRootComponent class >> repositoryClass [
	"
	self createData
	"

	^ QuasarDemoSoilRepository
]

{ #category : 'demo data' }
TB2ApplicationRootComponent class >> tinyBlogRepository [

	^ self repositoryClass
		mapAt: self databasePath
		ifAbsent: [ (self repositoryClass onPath: self databasePath) open; yourself ]
]

{ #category : 'accessing' }
TB2ApplicationRootComponent >> applicationTitle [

	^ 'Blog2'
]

{ #category : 'hooks' }
TB2ApplicationRootComponent >> children [

	^ { main }
]

{ #category : 'initialization' }
TB2ApplicationRootComponent >> initialize [

	super initialize.

	self reactiveObjectsAddIfAbsent: self session currentCategoryRef.
	self reactiveObjectsAddIfAbsent: self session pageNumberRef.
	self reactiveObjectsAddIfAbsent: self session postsPerPageRef.

	main := TB2PostsListComponent new
]

{ #category : 'accessing' }
TB2ApplicationRootComponent >> main: aComponent [

	main := aComponent
]

{ #category : 'rendering - quasar hooks' }
TB2ApplicationRootComponent >> quasarSetupReturnCustomList: aList with: anAjaxFactory [
	
	aList add: '
account: ref(null),
password: ref(null),
myAuthDialog: ref(false)'
]

{ #category : 'rendering' }
TB2ApplicationRootComponent >> renderLayoutOn: html [

	html qApp
		id: self appId;
		with: [
			html qLayout
				view: 'hHh lpR fFf';
				vCloak;
				with: [ html render: main ] ]
]
