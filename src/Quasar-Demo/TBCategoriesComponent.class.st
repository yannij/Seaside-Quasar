Class {
	#name : 'TBCategoriesComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'categories',
		'postsList'
	],
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'instance creation' }
TBCategoriesComponent class >> categories: categories postsList: aTBScreen [

	^ self new
		  categories: categories;
		  postsList: aTBScreen
]

{ #category : 'accessing' }
TBCategoriesComponent >> categories [

	^ categories
]

{ #category : 'accessing' }
TBCategoriesComponent >> categories: aCollection [

	categories := aCollection asSortedCollection
]

{ #category : 'accessing' }
TBCategoriesComponent >> postsList [

	^ postsList
]

{ #category : 'accessing' }
TBCategoriesComponent >> postsList: aComponent [

	postsList := aComponent
]

{ #category : 'actions' }
TBCategoriesComponent >> renderCategoryLinkOn: html with: aCategory [

	html qItem
		clickable; vRipple;
		href: (html urlForAction: [ self selectCategory: aCategory ]);
		with: [
			html qItemSection with: [
				html qItemLabel
					with: (aCategory ifNil: [ '*All*' ] ifNotNil: [ :value | value ]) ] ]
]

{ #category : 'actions' }
TBCategoriesComponent >> renderContentOn: html [

	html qList with: [
		html qItemLabel header; with: 'Categories'.
		categories do: [ :cat | self renderCategoryLinkOn: html with: cat ].
		self renderCategoryLinkOn: html with: nil ]
]

{ #category : 'actions' }
TBCategoriesComponent >> selectCategory: aCategory [

	postsList currentCategory: aCategory
]
