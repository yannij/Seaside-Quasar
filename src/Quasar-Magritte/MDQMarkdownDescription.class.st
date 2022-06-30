Class {
	#name : #MDQMarkdownDescription,
	#superclass : #MAStringDescription,
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQMarkdownDescription class >> label [

	^ 'Markdown'
]

{ #category : #accessing }
MDQMarkdownDescription class >> mdqDefaultComponentClasses [

	^ Array with: MDQMarkdownComponent
]

{ #category : #visiting }
MDQMarkdownDescription >> acceptMagritte: aVisitor [

	aVisitor visitMarkdownDescription: self
]
