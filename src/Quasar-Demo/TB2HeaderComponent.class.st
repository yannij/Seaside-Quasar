Class {
	#name : 'TB2HeaderComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'component'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'instance creation' }
TB2HeaderComponent class >> from: aComponent [

	^ self new
		  component: aComponent;
		  yourself
]

{ #category : 'accessing' }
TB2HeaderComponent >> component [

	^ component
]

{ #category : 'accessing' }
TB2HeaderComponent >> component: anObject [

	component := anObject
]

{ #category : 'rendering' }
TB2HeaderComponent >> renderButtonsOn: html [
	"Subclasses may extend"
]

{ #category : 'rendering' }
TB2HeaderComponent >> renderContentOn: html [

	html qHeader
		elevated;
		heightHint: 98;
		class: 'bg-primary text-white';
		with: [
			html qToolbar with: [
					html qToolbarTitle with: [ html text: 'Blog2' ].
					self renderButtonsOn: html ] ]
]
