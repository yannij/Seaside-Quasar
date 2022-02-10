Extension { #name : #MAReferenceDescription }

{ #category : #'*Quasar-Magritte' }
MAReferenceDescription >> mdqIsReference [
	"Answer ==true== if the receiver is a reference description."

	^ true
]

{ #category : #'*Quasar-Magritte' }
MAReferenceDescription >> mdqIsToMany [
	"Answer ==true== if the receiver is a description for a one to one relationship."

	^ false
]
