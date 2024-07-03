Class {
	#name : 'QuasarRouterTemplate',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'accessing' }
QuasarRouterTemplate >> tag [

	^ 'script'
]

{ #category : 'attributes' }
QuasarRouterTemplate >> vRouterTemplateType [

	self attributeAt: 'type' put: 'text/x-template'
]
