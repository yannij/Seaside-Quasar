Class {
	#name : #QRallyView,
	#superclass : #WAComponent,
	#category : #'Quasar-Material-Rally'
}

{ #category : #rendering }
QRallyView >> goto: aModel [

	self mdqApplicationGet pageComponent: (aModel asComponent addValidatedForm; yourself)
]

{ #category : #rendering }
QRallyView >> instanceList [

	self subclassResponsibility
]

{ #category : #rendering }
QRallyView >> renderAsCard: aModel on: html with: params [

	html qCard "flat;" bordered; class: 'q-mb-md'; style: 'max-width: 300px'; with: [
		html qCardSection with: [
			params first ifNotNil: [ :value |
				html span class: 'text-h6 text-center'; with: value ].
			params second ifNotNil: [ :value |
				html span class: 'text-body2 text-center'; with: value ] ].
		html qCardActions vertical; with: [
			html qBtn 
				type: 'a'; href: (html urlForAction: [ self goto: aModel ]);
				with: 'Open' ] ]
]

{ #category : #rendering }
QRallyView >> renderAsCards: aList on: html [

	html div with: [
		aList do: [ :eachInstance |
			self renderAsCard: eachInstance on: html with: eachInstance cardParameters ] ]
]

{ #category : #rendering }
QRallyView >> renderAsList: aList on: html [

	html qList with: [
		aList do: [ :eachInstance |
			self renderAsListItem: eachInstance on: html ] ]
]

{ #category : #rendering }
QRallyView >> renderAsListItem: aModel on: html [

	self
		renderAsListItem: aModel
		on: html
		with: aModel listItemParameters
]

{ #category : #rendering }
QRallyView >> renderAsListItem: aModel on: html with: params [

	html qItem
		qTag: 'a'; href: (html urlForAction: [ self goto: aModel ]);
		with: [
			html qItemSection noWrap with: [
				html qItemLabel style: 'font-family: Eczar'; with: params first .
				html qItemLabel caption; style: 'font-family: Eczar'; with: params second ].
			params size >= 3 ifTrue: [
				html qItemSection side; with: [
				html span
					class: 'text-h4';
					style: 'font-family: Eczar';
					with: params third ] ].
			params size >= 4 ifTrue: [
				html qItemSection avatar; with: [
					html qIcon name: params fourth ] ] ] 
]

{ #category : #rendering }
QRallyView >> renderContentOn: html [

	self renderInstancesOn: html
]

{ #category : #rendering }
QRallyView >> renderInstancesOn: html [

	self renderAsList: self instanceList on: html
]
