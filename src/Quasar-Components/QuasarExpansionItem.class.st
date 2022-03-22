Class {
	#name : #QuasarExpansionItem,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarExpansionItem >> caption: anObject [

	self attributes at: 'caption' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> dark [

	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarExpansionItem >> defaultOpened [

	self attributes at: 'default-opened' put: true
]

{ #category : #attributes }
QuasarExpansionItem >> dense [

	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarExpansionItem >> denseToggle [

	self attributes at: 'dense-toggle' put: true
]

{ #category : #attributes }
QuasarExpansionItem >> duration: anObject [

	self attributes at: 'duration' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> expandIcon: anObject [

	self attributes at: 'expand-icon' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> expandIconClass: anObject [

	self attributes at: 'expand-icon-class' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> expandIconToggle [

	self attributes at: 'expand-icon-toggle' put: true
]

{ #category : #attributes }
QuasarExpansionItem >> expandedIcon: anObject [

	self attributes at: 'expanded-icon' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> headerClass: anObject [

	self attributes at: 'header-class' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> headerStyle: anObject [

	self attributes at: 'header-style' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> icon: anObject [

	self attributes at: 'icon' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> switchToggleSide [

	self attributes at: 'switch-toggle-side' put: true
]

{ #category : #accessing }
QuasarExpansionItem >> tag [

	^ 'q-expansion-item'
]
