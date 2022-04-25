Extension { #name : #QuasarRouterTemplate }

{ #category : #'*Quasar-Components' }
QuasarRouterTemplate >> vRouterTemplateType [

	self attributeAt: 'type' put: 'text/x-template'
]
