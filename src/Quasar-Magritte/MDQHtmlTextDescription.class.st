Class {
	#name : #MDQHtmlTextDescription,
	#superclass : #MAStringDescription,
	#category : #'Quasar-Magritte'
}

{ #category : #'accessing-defaults' }
MDQHtmlTextDescription class >> defaultMaxHeight [

	^ '40rem'
]

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

{ #category : #accessing }
MDQHtmlTextDescription >> height [

	^ self propertyAt: #height ifAbsent: [ nil ]
]

{ #category : #accessing }
MDQHtmlTextDescription >> maxHeight [

	^ self propertyAt: #maxHeight ifAbsent: [ self class defaultMaxHeight ]
]

{ #category : #accessing }
MDQHtmlTextDescription >> maxHeight: aMagnitude [

	self propertyAt: #maxHeight put: aMagnitude
]

{ #category : #accessing }
MDQHtmlTextDescription >> minHeight [

	^ self propertyAt: #minHeight ifAbsent: [ nil ]
]
