Class {
	#name : #QuasarColor,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarColor >> bordered [

	self attributes at: 'bordered' put: true
]

{ #category : #attributes }
QuasarColor >> dark [

	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarColor >> defaultValue: anObject [

	self attributes at: 'default-value' put: anObject
]

{ #category : #attributes }
QuasarColor >> defaultView: anObject [

	self attributes at: 'default-view' put: anObject
]

{ #category : #attributes }
QuasarColor >> disable [

	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarColor >> flat [

	self attributes at: 'flat' put: true
]

{ #category : #attributes }
QuasarColor >> formatValue: anObject [

	self attributes at: 'format-value' put: anObject
]

{ #category : #attributes }
QuasarColor >> modelValue: aBoolean [

	self vBind: 'model-value' with: aBoolean
]

{ #category : #attributes }
QuasarColor >> name: anObject [

	self attributes at: 'name' put: anObject
]

{ #category : #attributes }
QuasarColor >> noFooter [

	self attributes at: 'no-footer' put: true
]

{ #category : #attributes }
QuasarColor >> noHeader [

	self attributes at: 'no-header' put: true
]

{ #category : #attributes }
QuasarColor >> noHeaderTabs [

	self attributes at: 'no-header-tabs' put: true
]

{ #category : #attributes }
QuasarColor >> palette: anObject [

	self attributes at: 'palette' put: anObject
]

{ #category : #attributes }
QuasarColor >> readonly [

	self attributes at: 'readonly' put: true
]

{ #category : #attributes }
QuasarColor >> square [

	self attributes at: 'square' put: true
]

{ #category : #accessing }
QuasarColor >> tag [

	^ 'q-color'
]
