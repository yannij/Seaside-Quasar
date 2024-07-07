Class {
	#name : 'TB2ScreenComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'header'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'accessing' }
TB2ScreenComponent >> blog [
	"Return the current blog. In the future we will ask the
   session to return the blog of the currently logged in user."

	^ TBBlog current
]

{ #category : 'hooks' }
TB2ScreenComponent >> children [

	^ { header }
]

{ #category : 'initialization' }
TB2ScreenComponent >> createHeaderComponent [

	^ TB2HeaderComponent from: self
]

{ #category : 'initialization' }
TB2ScreenComponent >> initialize [

	super initialize.
	header := self createHeaderComponent
]

{ #category : 'rendering' }
TB2ScreenComponent >> renderContentOn: html [

	html render: header.

	html qPageContainer with: [
		self renderScreenOn: html ]
]

{ #category : 'rendering' }
TB2ScreenComponent >> renderScreenOn: html [

	html text: 'Hello from TB2ScreenComponent'
]
