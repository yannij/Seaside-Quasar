Class {
	#name : 'TB2Blog',
	#superclass : 'Object',
	#instVars : [
		'adminUser'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'tests' }
TB2Blog class >> createDemoPosts [
	"TBBlog createDemoPosts"

	self current
		writeBlogPost: ((TBPost
				  title: 'Welcome in TinyBlog'
				  text: 'TinyBlog is a small blog engine made with Pharo.'
				  category: 'TinyBlog') visible: true);
		writeBlogPost: ((TBPost
				  title: 'Report Pharo Sprint'
				  text: 'Friday, June 12 there was a Pharo sprint / Moose dojo. It was a nice event with more than 15 motivated sprinters. With the help of candies, cakes and chocolate, huge work has been done'
				  category: 'Pharo') visible: true);
		writeBlogPost: ((TBPost
				  title: 'Brick on top of Bloc - Preview'
				  text: 'We are happy to announce the first preview version of Brick, a new widget set created from scratch on top of Bloc. Brick is being developed primarily by Alex Syrel (together with Alain Plantec, Andrei Chis and myself), and the work is sponsored by ESUG. Brick is part of the Glamorous Toolkit effort and will provide the basis for the new versions of the development tools.'
				  category: 'Pharo') visible: true);
		writeBlogPost: ((TBPost
				  title: 'The sad story of unclassified blog posts'
				  text: 'So sad that I can read this.') visible: true);
		writeBlogPost: ((TBPost
				  title: 'Working with Pharo on the Raspberry Pi'
				  text: 'Hardware is getting cheaper and many new small devices like the famous Raspberry Pi provide new computation power that was one once only available on regular desktop computers.'
				  category: 'Pharo') visible: true)
]

{ #category : 'initialization' }
TB2Blog class >> current [
	"answer the instance of the TBRepository"

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'defaults' }
TB2Blog class >> defaultAdminLogin [

	^ 'admin'
]

{ #category : 'defaults' }
TB2Blog class >> defaultAdminPassword [

	^ 'topsecret'
]

{ #category : 'initialization' }
TB2Blog class >> initialize [

	self reset
]

{ #category : 'initialization' }
TB2Blog class >> reset [

	uniqueInstance := nil
]

{ #category : 'accessing' }
TB2Blog >> administrator [

	^ adminUser
]

{ #category : 'accessing' }
TB2Blog >> allBlogPosts [

	^ TB2ApplicationRootComponent tinyBlogRepository selectAll: TB2Post
]

{ #category : 'accessing' }
TB2Blog >> allBlogPostsFromCategory: aCategory [

	^ self allBlogPosts select: [ :p | p category = aCategory ]
]

{ #category : 'accessing' }
TB2Blog >> allCategories [

	^ (self allBlogPosts collect: [ :p | p category ]) asSet
]

{ #category : 'accessing' }
TB2Blog >> allVisibleBlogPosts [

	^ self allBlogPosts select: [ :p | p isVisible ]
]

{ #category : 'accessing' }
TB2Blog >> allVisibleBlogPostsFromCategory: aCategory [

	^ self allBlogPosts select: [ :p | p category = aCategory and: [ p isVisible ] ]
]

{ #category : 'initialization' }
TB2Blog >> createAdministrator [

	^ TBAdministrator
		  login: self class defaultAdminLogin
		  password: self class defaultAdminPassword
]

{ #category : 'initialization' }
TB2Blog >> initialize [

	super initialize.
	adminUser := self createAdministrator
]

{ #category : 'removing' }
TB2Blog >> removeAllPosts [

	"posts := OrderedCollection new"
]

{ #category : 'removing' }
TB2Blog >> removeBlogPost: aPost [

	"posts remove: aPost ifAbsent: [  ]."
	"self save"
]

{ #category : 'accessing' }
TB2Blog >> size [

	^ (TB2ApplicationRootComponent tinyBlogRepository count: TB2Post)
]

{ #category : 'writing' }
TB2Blog >> writeBlogPost: aPost [
	"Add the blog post to the list of posts."

	self posts add: aPost
]
