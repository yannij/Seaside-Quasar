Class {
	#name : 'TB2Post',
	#superclass : 'TB2Model',
	#instVars : [
		'title',
		'text',
		'date',
		'category',
		'visible',
		'id'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'instance creation' }
TB2Post class >> title: aTitle text: aText [

	^ self new
		title: aTitle;
		text: aText;
		yourself
]

{ #category : 'instance creation' }
TB2Post class >> title: aTitle text: aText category: aCategory [

	^ (self title: aTitle text: aText)
		category: aCategory;
		yourself
]

{ #category : 'accessing' }
TB2Post class >> unclassifiedTag [

	^ 'Unclassified'
]

{ #category : 'actions' }
TB2Post >> assignId [
	| newId |

	newId := true ifTrue: [ self class newUUID ] ifFalse: [ self class nextSequenceNumber ].
	self id: newId
]

{ #category : 'actions' }
TB2Post >> beVisible [

	self visible: true
]

{ #category : 'accessing' }
TB2Post >> category [

	^ category
]

{ #category : 'accessing' }
TB2Post >> category: anObject [

	category := anObject
]

{ #category : 'accessing' }
TB2Post >> date [

	^ date
]

{ #category : 'accessing' }
TB2Post >> date: anObject [

	date := anObject
]

{ #category : 'accessing-magritte' }
TB2Post >> descriptionCategory [
	<magritteDescription>
	^ MAStringDescription new
		  label: 'Category';
		  priority: 300;
		  accessor: #category;
		  comment: 'Unclassified if empty';
		  componentClass: MDQTextInputComponent;
		  yourself
]

{ #category : 'accessing-magritte' }
TB2Post >> descriptionDate [
	<magritteDescription>
	^ MADateDescription new
		  label: 'Date';
		  priority: 400;
		  accessor: #date;
		  beRequired;
		  componentClass: MDQDateComponent;
		  yourself
]

{ #category : 'accessing-magritte' }
TB2Post >> descriptionText [
	<magritteDescription>
	^ MAMemoDescription new
		  label: 'Text';
		  priority: 200;
		  accessor: #text;
		  beRequired;
		  requiredErrorMessage: 'A blog post must contain a text.';
		  comment: 'Please enter a text';
		  componentClass: MDQTextAreaComponent;
		  yourself
]

{ #category : 'accessing-magritte' }
TB2Post >> descriptionTitle [
	<magritteDescription>
	^ MAStringDescription new
		  label: 'Title';
		  priority: 100;
		  accessor: #title;
		  requiredErrorMessage: 'A blog post must have a title.';
		  comment: 'Please enter a title';
		  componentClass: MDQTextInputComponent;
		  beRequired;
		  yourself
]

{ #category : 'accessing-magritte' }
TB2Post >> descriptionVisible [
	<magritteDescription>
	^ MABooleanDescription new
		  checkboxLabel: 'Visible';
		  priority: 500;
		  accessor: #visible;
		  componentClass: MDQCheckboxComponent;
		  beRequired;
		  yourself
]

{ #category : 'accessing' }
TB2Post >> id [

	^ id
]

{ #category : 'accessing' }
TB2Post >> id: anObject [

	id := anObject
]

{ #category : 'initialization' }
TB2Post >> initialize [

	super initialize.
	self category: self class unclassifiedTag.
	self date: Date today.
	self notVisible
]

{ #category : 'testing' }
TB2Post >> isUnclassified [

	^ self category = self class unclassifiedTag
]

{ #category : 'testing' }
TB2Post >> isVisible [

	^ self visible
]

{ #category : 'actions' }
TB2Post >> notVisible [

	self visible: false
]

{ #category : 'accessing' }
TB2Post >> text [

	^ text
]

{ #category : 'accessing' }
TB2Post >> text: anObject [

	text := anObject
]

{ #category : 'accessing' }
TB2Post >> title [

	^ title
]

{ #category : 'accessing' }
TB2Post >> title: anObject [

	title := anObject
]

{ #category : 'accessing' }
TB2Post >> visible [

	^ visible
]

{ #category : 'accessing' }
TB2Post >> visible: anObject [

	visible := anObject
]
