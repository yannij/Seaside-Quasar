Class {
	#name : 'QuasarExpansionItem',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarExpansionItem >> activeClass: anObject [

	self attributes at: 'active-class' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> caption: anObject [

	self attributes at: 'caption' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> captionLines: anObject [

	self attributes at: 'caption-lines' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> contentInsetLevel: anObject [

	self attributes at: 'content-inset-level' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> dark [

	self attributes at: 'dark' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> defaultOpened [

	self attributes at: 'default-opened' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> dense [

	self attributes at: 'dense' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> denseToggle [

	self attributes at: 'dense-toggle' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> disable [

	self attributes at: 'disable' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> duration: anObject [

	self attributes at: 'duration' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> exact [

	self attributes at: 'exact' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> exactActiveClass: anObject [

	self attributes at: 'active-class' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> expandIcon: anObject [

	self attributes at: 'expand-icon' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> expandIconClass: anObject [

	self attributes at: 'expand-icon-class' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> expandIconToggle [

	self attributes at: 'expand-icon-toggle' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> expandedIcon: anObject [

	self attributes at: 'expanded-icon' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> group: anObject [

	self attributes at: 'group' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> headerClass: anObject [

	self attributes at: 'header-class' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> headerInsetLevel: anObject [

	self attributes at: 'header-inset-level' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> headerStyle: anObject [

	self attributes at: 'header-style' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> hideExpandIcon [

	self attributes at: 'hide-expand-icon' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> href: anObject [

	self attributes at: 'href' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> icon: anObject [

	self attributes at: 'icon' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> labelLines: anObject [

	self attributes at: 'label-lines' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> popup [

	self attributes at: 'popup' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> replace [

	self attributes at: 'replace' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> switchToggleSide [

	self attributes at: 'switch-toggle-side' put: true
]

{ #category : 'attributes' }
QuasarExpansionItem >> switchToggleSide: anObject [

	self attributes at: 'switch-toggle-side' put: anObject
]

{ #category : 'accessing' }
QuasarExpansionItem >> tag [

	^ 'q-expansion-item'
]

{ #category : 'attributes' }
QuasarExpansionItem >> target: anObject [

	self attributes at: 'target' put: anObject
]

{ #category : 'attributes' }
QuasarExpansionItem >> to: anObject [

	self attributes at: 'to' put: anObject
]
