Class {
	#name : 'TBPost',
	#superclass : 'Object',
	#instVars : [
		'title',
		'text',
		'date',
		'category',
		'visible'
	],
	#category : 'Quasar-Demo-TinyBlog',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog'
}

{ #category : 'instance creation' }
TBPost class >> title: aTitle text: aText [

	^ self new
		title: aTitle;
		text: aText;
		yourself
]

{ #category : 'instance creation' }
TBPost class >> title: aTitle text: aText category: aCategory [

	^ (self title: aTitle text: aText)
		category: aCategory;
		yourself
]

{ #category : 'accessing' }
TBPost class >> unclassifiedTag [

	^ 'Unclassified'
]

{ #category : 'actions' }
TBPost >> beVisible [

	self visible: true
]

{ #category : 'accessing' }
TBPost >> category [

	^ category
]

{ #category : 'accessing' }
TBPost >> category: anObject [

	category := anObject
]

{ #category : 'accessing' }
TBPost >> date [

	^ date
]

{ #category : 'accessing' }
TBPost >> date: anObject [

	date := anObject
]

{ #category : 'accessing-magritte' }
TBPost >> descriptionCategory [
	<magritteDescription>
	^ MAStringDescription new
		  label: 'Category';
		  priority: 300;
		  accessor: #category;
		  yourself
]

{ #category : 'accessing-magritte' }
TBPost >> descriptionDate [
	<magritteDescription>
	^ MADateDescription new
		  label: 'Date';
		  priority: 400;
		  accessor: #date;
		  beRequired;
		  yourself
]

{ #category : 'accessing-magritte' }
TBPost >> descriptionText [
	<magritteDescription>
	^ MAMemoDescription new
		  label: 'Text';
		  priority: 200;
		  accessor: #text;
		  beRequired;
		  yourself
]

{ #category : 'accessing-magritte' }
TBPost >> descriptionTitle [
	<magritteDescription>
	^ MAStringDescription new
		  label: 'Title';
		  priority: 100;
		  accessor: #title;
		  beRequired;
		  yourself
]

{ #category : 'accessing-magritte' }
TBPost >> descriptionVisible [
	<magritteDescription>
	^ MABooleanDescription new
		  label: 'Visible';
		  priority: 500;
		  accessor: #visible;
		  beRequired;
		  yourself
]

{ #category : 'initialization' }
TBPost >> initialize [

	super initialize.
	self category: self class unclassifiedTag.
	self date: Date today.
	self notVisible
]

{ #category : 'testing' }
TBPost >> isUnclassified [

	^ self category = self class unclassifiedTag
]

{ #category : 'testing' }
TBPost >> isVisible [

	^ self visible
]

{ #category : 'actions' }
TBPost >> notVisible [

	self visible: false
]

{ #category : 'accessing' }
TBPost >> text [

	^ text
]

{ #category : 'accessing' }
TBPost >> text: anObject [

	text := anObject
]

{ #category : 'accessing' }
TBPost >> title [

	^ title
]

{ #category : 'accessing' }
TBPost >> title: anObject [

	title := anObject
]

{ #category : 'accessing' }
TBPost >> visible [

	^ visible
]

{ #category : 'accessing' }
TBPost >> visible: anObject [

	visible := anObject
]
