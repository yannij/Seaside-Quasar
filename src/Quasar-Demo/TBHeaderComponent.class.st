Class {
	#name : 'TBHeaderComponent',
	#superclass : 'WAComponent',
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'rendering' }
TBHeaderComponent >> renderContentOn: html [

	html qHeader
		elevated;
		heightHint: 98;
		class: 'bg-primary text-white';
		with: [
			html qToolbar with: [
					html qToolbarTitle with: [ html text: 'TinyBlog' ] ] ]
]
