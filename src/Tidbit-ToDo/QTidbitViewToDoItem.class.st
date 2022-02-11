Class {
	#name : #QTidbitViewToDoItem,
	#superclass : #QuasarComponent,
	#instVars : [
		'model',
		'itemComponent',
		'subtasksComponent'
	],
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #'instance creation' }
QTidbitViewToDoItem class >> on: aModel [

	^ self new
		initializeOn: aModel;
		yourself
]

{ #category : #initialization }
QTidbitViewToDoItem >> initializeOn: aModel [
	| theDescription newComponent |

	self model: aModel.
	theDescription := aModel magritteDescription.
	"theDescription componentRenderer: TidbitViewTaskRenderer."
	newComponent := theDescription componentClass memento: (aModel mementoClass model: aModel description: theDescription).
	newComponent addValidatedForm.
	self itemComponent: newComponent
]

{ #category : #accessing }
QTidbitViewToDoItem >> itemComponent [

	^ itemComponent
]

{ #category : #accessing }
QTidbitViewToDoItem >> itemComponent: anObject [

	itemComponent := anObject
]

{ #category : #accessing }
QTidbitViewToDoItem >> model [

	^ model
]

{ #category : #accessing }
QTidbitViewToDoItem >> model: anObject [

	model := anObject
]

{ #category : #rendering }
QTidbitViewToDoItem >> renderContentOn: html [

	html render: self itemComponent
]

{ #category : #accessing }
QTidbitViewToDoItem >> subtasksComponent [

	^ subtasksComponent
]

{ #category : #accessing }
QTidbitViewToDoItem >> subtasksComponent: anObject [

	subtasksComponent := anObject
]
