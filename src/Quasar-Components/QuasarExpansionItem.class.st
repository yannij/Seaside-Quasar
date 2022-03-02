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
QuasarExpansionItem >> dense [

	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarExpansionItem >> denseToggle [

	self attributes at: 'dense-toggle' put: true
]

{ #category : #attributes }
QuasarExpansionItem >> expandIcon: anObject [

	self attributes at: 'expand-icon' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> expandedIcon: anObject [

	self attributes at: 'expanded-icon' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> icon: anObject [

	self attributes at: 'icon' put: anObject
]

{ #category : #attributes }
QuasarExpansionItem >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : #accessing }
QuasarExpansionItem >> tag [

	^ 'q-expansion-item'
]

{ #category : #attributes }
QuasarExpansionItem >> vModel: anObject [

	self attributes at: 'v-model' put: anObject
]
