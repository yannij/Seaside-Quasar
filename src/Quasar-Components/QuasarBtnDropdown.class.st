Class {
	#name : #QuasarBtnDropdown,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarBtnDropdown >> color: anObject [

	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarBtnDropdown >> flat [

	self attributes at: 'flat' put: true
]

{ #category : #attributes }
QuasarBtnDropdown >> glossy [

	self attributes at: 'glossy' put: true
]

{ #category : #attributes }
QuasarBtnDropdown >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : #attributes }
QuasarBtnDropdown >> rounded [

	self attributes at: 'rounded' put: true
]

{ #category : #accessing }
QuasarBtnDropdown >> tag [

	^ 'q-btn-dropdown'
]
