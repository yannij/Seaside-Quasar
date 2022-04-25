Class {
	#name : #QuasarRouterTemplate,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #accessing }
QuasarRouterTemplate >> tag [

	^ 'script'
]

{ #category : #'*Quasar-Components' }
QuasarRouterTemplate >> vRouterTemplateType [

	self attributeAt: 'type' put: 'text/x-template'
]
