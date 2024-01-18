Extension { #name : #WATagBrush }

{ #category : #'*Quasar-Components' }
WATagBrush >> vBind: key with: anObject [

	self attributes at: ':', key put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vCloak [

	self attributeAt: 'v-cloak' put: true
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vClosePopUp [

	self attributeAt: 'v-close-popup' put: true
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vClosePopUp: anObject [

	self attributeAt: 'v-close-popup' put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vElse: anObject [

	self attributes at: 'v-else' put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vElseIf: anObject [

	self attributes at: 'v-else-if' put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vFor: anObject [

	self attributes at: 'v-for' put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vIf: anObject [

	self attributes at: 'v-if' put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vModel: anObject [

	self attributes at: 'v-model' put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vModel: anObject colon: propertyName [

	self attributes at: 'v-model:', propertyName asString put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vOn: anEventName with: anObject [

	self attributes at: '@', anEventName put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vOnClick: aString [
	
	self attributes at: '@click' put: aString
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vOnClickStop [

	self attributeAt: '@click.stop' put: true
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vShow: anObject [

	self attributes at: 'v-show' put: anObject
]

{ #category : #'*Quasar-Components' }
WATagBrush >> vSlot: key with: anObject [

	self attributes at: 'v-slot:', key put: anObject
]
