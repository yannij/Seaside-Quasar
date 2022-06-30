Extension { #name : #MAVisitor }

{ #category : #'*Quasar-Magritte' }
MAVisitor >> visitHexColorDescription: anObject [

	self visitElementDescription: anObject
]

{ #category : #'*Quasar-Magritte' }
MAVisitor >> visitHtmlTextDescription: anObject [

	self visitStringDescription: anObject
]

{ #category : #'*Quasar-Magritte' }
MAVisitor >> visitMarkdownDescription: anObject [

	self visitStringDescription: anObject
]
