Class {
	#name : #MDQHtmlTextDescription,
	#superclass : #MAStringDescription,
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQHtmlTextDescription class >> label [

	^ 'Html Text'
]

{ #category : #accessing }
MDQHtmlTextDescription class >> mdqDefaultComponentClasses [

	^ Array with: MDQTextEditorComponent
]

{ #category : #visiting }
MDQHtmlTextDescription >> acceptMagritte: aVisitor [

	aVisitor visitHtmlTextDescription: self
]
