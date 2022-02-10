Class {
	#name : #QuasarCardSection,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarCardSection >> horizontal [
	
	self attributes at: 'horizontal' put: true
]

{ #category : #accessing }
QuasarCardSection >> tag [

	^ 'q-card-section'
]
