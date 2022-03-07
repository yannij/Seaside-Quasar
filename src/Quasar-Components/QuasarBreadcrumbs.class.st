Class {
	#name : #QuasarBreadcrumbs,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarBreadcrumbs >> activeColor: anObject [

	self attributes at: 'active-color' put: anObject
]

{ #category : #attributes }
QuasarBreadcrumbs >> align: anObject [

	self attributes at: 'align' put: anObject
]

{ #category : #attributes }
QuasarBreadcrumbs >> gutter: anObject [

	self attributes at: 'gutter' put: anObject
]

{ #category : #attributes }
QuasarBreadcrumbs >> separator: anObject [

	self attributes at: 'separator' put: anObject
]

{ #category : #attributes }
QuasarBreadcrumbs >> separatorColor: anObject [

	self attributes at: 'separator-color' put: anObject
]

{ #category : #accessing }
QuasarBreadcrumbs >> tag [

	^ 'q-breadcrumbs'
]
