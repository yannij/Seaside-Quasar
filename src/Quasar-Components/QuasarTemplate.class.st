Class {
	#name : #QuasarTemplate,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarTemplate >> tag [

	^ 'template'
]

{ #category : #attributes }
QuasarTemplate >> vSlot: aString [

	self attributes at: 'v-slot:', aString put: true
]
