Class {
	#name : 'QuasarBreadcrumbsEl',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> activeClass [

	self attributes at: 'active-class' put: true
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> disable [

	self attributes at: 'disable' put: true
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> exact [

	self attributes at: 'exact' put: true
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> exactActiveClass [

	self attributes at: 'exact-active-class' put: true
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> href: anObject [

	self attributes at: 'href' put: anObject
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> icon: anObject [

	self attributes at: 'icon' put: anObject
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> replace [

	self attributes at: 'replace' put: true
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> ripple [

	self attributes at: 'ripple' put: true
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> ripple: anObject [

	self attributes at: 'ripple' put: anObject
]

{ #category : 'accessing' }
QuasarBreadcrumbsEl >> tag [

	^ 'q-breadcrumbs-el'
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> tag: anObject [

	self attributes at: 'tag' put: anObject
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> target: anObject [

	self attributes at: 'target' put: anObject
]

{ #category : 'attributes' }
QuasarBreadcrumbsEl >> to: anObject [

	self attributes at: 'to' put: anObject
]
