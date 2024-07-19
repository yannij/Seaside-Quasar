Class {
	#name : 'TB2Model',
	#superclass : 'Object',
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'instance creation' }
TB2Model class >> newUUID [
	"Answer new UUID instance taking into account Pharo version"

	^ SystemVersion current major >= 12
		ifTrue: [ UUID new ]
		ifFalse: [ UUIDGenerator next ]
]

{ #category : 'instance creation' }
TB2Model class >> nextSequenceNumber [
	"Answer next sequence number.
	For now, use the number of model instances, plus 1, as a sequence number.
	If instances are deleted, then duplicates can occur."
	| repository count |

	repository := TB2ApplicationRootComponent tinyBlogRepository.
	count := repository count: TB2Post.
	^ count + 1
]

{ #category : 'accessing-magritte' }
TB2Model >> descriptionContainer [
	<magritteContainer>
	^ super descriptionContainer
		  componentRenderer: MDQCssRenderer;
		  yourself
]
