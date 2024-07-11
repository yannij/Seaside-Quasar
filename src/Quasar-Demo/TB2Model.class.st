Class {
	#name : 'TB2Model',
	#superclass : 'Object',
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'accessing-magritte' }
TB2Model >> descriptionContainer [
	<magritteContainer>
	^ super descriptionContainer
		  componentRenderer: MDQCssRenderer;
		  yourself
]
