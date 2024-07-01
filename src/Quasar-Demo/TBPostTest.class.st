Class {
	#name : 'TBPostTest',
	#superclass : 'TestCase',
	#category : 'Quasar-Demo-TinyBlog',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog'
}

{ #category : 'tests' }
TBPostTest >> testPostIsCreatedCorrectly [

	| post |
	post := TBPost
		        title: 'Welcome to TinyBlog'
		        text: 'TinyBlog is a small blog engine made with Pharo.'
		        category: 'TinyBlog'.
	self assert: post title equals: 'Welcome to TinyBlog'.
	self assert: post text equals: 'TinyBlog is a small blog engine made with Pharo.'
]

{ #category : 'tests' }
TBPostTest >> testWithoutCategoryIsUnclassified [

	| post |
	post := TBPost
		        title: 'Welcome to TinyBlog'
		        text: 'TinyBlog is a small blog engine made with Pharo.'.
	self assert: post title equals: 'Welcome to TinyBlog'.
	self assert: post isUnclassified.
	self deny: post isVisible
]
