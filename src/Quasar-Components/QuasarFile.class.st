Class {
	#name : #QuasarFile,
	#superclass : #QuasarFormComponent,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarFile >> loading [

	self attributes at: 'label' put: true
]

{ #category : #accessing }
QuasarFile >> tag [

	^ 'q-file'
]

{ #category : #attributes }
QuasarFile >> useChips: anObject [

	self attributes at: 'use-chips' put: anObject
]
