Class {
	#name : #TidbitUserSettings,
	#superclass : #TidbitRootObject,
	#instVars : [
		'user',
		'layoutDensity'
	],
	#category : #'Tidbit-ToDo-Model'
}

{ #category : #voyage }
TidbitUserSettings class >> descriptionUser [
	"<voyageDescription>"

	^ VOToOneDescription new
		attributeName: 'user';
		accessor: #user;
		beLazy;
		yourself
]

{ #category : #voyage }
TidbitUserSettings class >> isVoyageRoot [

	^ false
]

{ #category : #'instance creation' }
TidbitUserSettings class >> on: aUser [

	^ self new
		user: aUser;
		yourself
]

{ #category : #'accessing-magritte' }
TidbitUserSettings >> descriptionUser [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #user;
		label: 'User';
		classes: {TidbitUser};
		cssClass: 'mcw-textfield';
		priority: 10;
		beRequired;
		yourself
]

{ #category : #initialization }
TidbitUserSettings >> initialize [

	super initialize.

	self layoutDensity: 'Auto'.

]

{ #category : #accessing }
TidbitUserSettings >> layoutDensity [
	^ layoutDensity
]

{ #category : #accessing }
TidbitUserSettings >> layoutDensity: anObject [
	layoutDensity := anObject
]

{ #category : #'accessing-magritte' }
TidbitUserSettings >> layoutDensityDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #layoutDensity;
		label: 'Layout Density';
		options: {'Auto'. 'Normal'. 'Dense'};
		priority: 10;
		yourself
]

{ #category : #printing }
TidbitUserSettings >> mdPrimaryString [

	^ 'User Settings for: ', self user mdPrimaryString
]

{ #category : #printing }
TidbitUserSettings >> mdSecondaryString [

	^ 'Layout Density: ', self layoutDensity greaseString
]

{ #category : #accessing }
TidbitUserSettings >> user [
	^ user
]

{ #category : #accessing }
TidbitUserSettings >> user: anObject [
	"user := anObject"
]
