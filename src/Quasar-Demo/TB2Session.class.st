Class {
	#name : 'TB2Session',
	#superclass : 'WASession',
	#instVars : [
		'currentAdmin',
		'currentCategoryRef',
		'pageNumberRef',
		'postsPerPageRef'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'accessing' }
TB2Session >> currentAdmin [

	^ currentAdmin
]

{ #category : 'accessing' }
TB2Session >> currentAdmin: anObject [

	currentAdmin := anObject
]

{ #category : 'accessing' }
TB2Session >> currentCategoryGet [

	^ self currentCategoryRef refValue
]

{ #category : 'accessing' }
TB2Session >> currentCategoryRef [

	^ currentCategoryRef
]

{ #category : 'accessing' }
TB2Session >> currentCategoryRef: anObject [

	currentCategoryRef := anObject
]

{ #category : 'accessing' }
TB2Session >> currentCategorySet: anObject [

	self currentCategoryRef refValue: anObject.
	self pageNumberSet: 1.
]

{ #category : 'initialization' }
TB2Session >> initialize [

	super initialize.

	self currentCategoryRef: ((QuasarRefCallback name: 'currentCategory' value: nil)
		callbackBlock: [ :ref :value | self currentCategorySet: value ];
		emitRefreshOn;
		yourself).

	self pageNumberRef: ((QuasarRefCallback name: 'pageNumber' value: 1)
		callbackBlock: [ :ref :value | ref refValue: value ];
		emitRefreshOn;
		yourself).

	self postsPerPageRef: ((QuasarRefCallback name: 'postsPerPage' value: 10)
		callbackBlock: [ :ref :value | self postsPerPageSet: value ];
		emitRefreshOn;
		yourself)
]

{ #category : 'testing' }
TB2Session >> isLogged [

	^ self currentAdmin notNil
]

{ #category : 'accessing' }
TB2Session >> pageNumberGet [

	^ self pageNumberRef refValue
]

{ #category : 'accessing' }
TB2Session >> pageNumberRef [

	^ pageNumberRef
]

{ #category : 'accessing' }
TB2Session >> pageNumberRef: anObject [

	pageNumberRef := anObject
]

{ #category : 'accessing' }
TB2Session >> pageNumberSet: anObject [

	self pageNumberRef refValue: anObject
]

{ #category : 'accessing' }
TB2Session >> postsPerPageGet [

	^ self postsPerPageRef refValue
]

{ #category : 'accessing' }
TB2Session >> postsPerPageRef [

	^ postsPerPageRef
]

{ #category : 'accessing' }
TB2Session >> postsPerPageRef: anObject [

	postsPerPageRef := anObject
]

{ #category : 'accessing' }
TB2Session >> postsPerPageSet: anObject [

	self postsPerPageRef refValue: anObject.
	self pageNumberSet: 1.
]

{ #category : 'initialization' }
TB2Session >> reset [

	currentAdmin := nil.
	self requestContext redirectTo: self application url.
	self unregister
]
