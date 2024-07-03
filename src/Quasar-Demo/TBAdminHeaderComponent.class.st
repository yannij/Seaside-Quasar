Class {
	#name : 'TBAdminHeaderComponent',
	#superclass : 'TBHeaderComponent',
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'rendering' }
TBAdminHeaderComponent >> renderButtonsOn: html [

	self renderDisconnectButtonOn: html.
	self renderPublicViewButtonOn: html
]

{ #category : 'rendering' }
TBAdminHeaderComponent >> renderDisconnectButtonOn: html [

	html qBtn
		href: (html urlForAction: [ self session reset ]);
		icon: 'logout';
		label: 'Disconnect '
]

{ #category : 'rendering' }
TBAdminHeaderComponent >> renderPublicViewButtonOn: html [

	self session isLogged ifTrue: [
		html qBtn
			href: (html urlForAction: [ component goToPostListView ]);
			icon: 'visibility';
			label: 'Public View' ]
]
