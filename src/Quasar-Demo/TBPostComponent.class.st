Class {
	#name : 'TBPostComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'post'
	],
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'accessing' }
TBPostComponent >> date [

	^ post date
]

{ #category : 'initialization' }
TBPostComponent >> initialize [

	super initialize.
	post := TBPost new
]

{ #category : 'accessing' }
TBPostComponent >> post: aPost [

	post := aPost
]

{ #category : 'rendering' }
TBPostComponent >> renderContentOn: html [

	html qCard
		style: 'width: 100%; max-width: 250px';
		with: [
			html qCardSection with: [
				html div class: 'text-h6'; with: self title.
				html div class: 'text-subtitle2'; with: self date ].
			html qCardSection with: self text ]
]

{ #category : 'accessing' }
TBPostComponent >> text [

	^ post text
]

{ #category : 'accessing' }
TBPostComponent >> title [

	^ post title
]
