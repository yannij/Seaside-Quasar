Class {
	#name : 'QuasarMarkdown',
	#superclass : 'QuasarFormComponent',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'as yet unclassified' }
QuasarMarkdown >> noHeadingAnchorLinks [
	
	self attributes at: 'no-heading-anchor-links' put: true
]

{ #category : 'accessing' }
QuasarMarkdown >> tag [

	^ 'q-markdown'
]
