Class {
	#name : #TidbitOneToManyComponent,
	#superclass : #MAOneToManyComponent,
	#instVars : [
		'expanded'
	],
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #private }
TidbitOneToManyComponent >> buildReport [

	^ (MDQReport rows: self value description: self reference)
		showHeader: true;
		showFooter: true;
		"addColumn: (MCWActionColumn new
			commandBlock: (MessageSend receiver: self selector: #navTo:);
			yourself);"
		yourself
]

{ #category : #rendering }
TidbitOneToManyComponent >> renderAddButtonOn: html [

	html qBtn
		type: 'a'; href: (html urlForAction: [ self add ]);
		tabIndex: 0;
		"onClick: ((html jQuery ajax)
			callback: [ self add ];
			onComplete: html javascript refresh);"
		icon: 'add'
]

{ #category : #'rendering-buttons' }
TidbitOneToManyComponent >> renderSelectButtonOn: html [

	"Place the add button elsewhere"
	"html submitButton on: #add of: self"
]

{ #category : #rendering }
TidbitOneToManyComponent >> renderViewerOn: html [

	html text: self magritteDescription label.
	self renderAddButtonOn: html.
	html break.
	super renderViewerOn: html
]
