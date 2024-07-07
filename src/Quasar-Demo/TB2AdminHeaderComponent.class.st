Class {
	#name : 'TB2AdminHeaderComponent',
	#superclass : 'TB2HeaderComponent',
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'rendering' }
TB2AdminHeaderComponent >> renderButtonsOn: html [

	self renderDisconnectButtonOn: html.
	self renderPublicViewButtonOn: html
]

{ #category : 'rendering' }
TB2AdminHeaderComponent >> renderDisconnectButtonOn: html [

	html qBtn
		href: (html urlForAction: [ self session reset ]);
		icon: 'logout';
		label: 'Disconnect '
]

{ #category : 'rendering' }
TB2AdminHeaderComponent >> renderPublicViewButtonOn: html [

	self session isLogged ifTrue: [
		html qBtn
			href: (html urlForAction: [ component goToPostListView ]);
			icon: 'visibility';
			label: 'Public View' ]
]
