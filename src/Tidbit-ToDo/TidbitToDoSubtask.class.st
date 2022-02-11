Class {
	#name : #TidbitToDoSubtask,
	#superclass : #TidbitRootObject,
	#instVars : [
		'summary',
		'description',
		'done'
	],
	#category : #'Tidbit-ToDo-Model'
}

{ #category : #accessing }
TidbitToDoSubtask >> description [

	^ description
]

{ #category : #accessing }
TidbitToDoSubtask >> description: anObject [

	description := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoSubtask >> descriptionDescription [
	<magritteDescription>

	^ MAMemoDescription new
		accessor: #description;
		default: '';
		label: 'Description';
		cssClass: 'mcw-textfield';
		priority: 20;
		yourself
]

{ #category : #accessing }
TidbitToDoSubtask >> done [

	^ done
]

{ #category : #accessing }
TidbitToDoSubtask >> done: anObject [

	done := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoSubtask >> doneDescription [
	<magritteDescription>

	^ MABooleanDescription new
		accessor: #done;
		label: 'Done';
		cssClass: 'mcw-textfield';
		priority: 10;
		default: false;
		yourself
]

{ #category : #accessing }
TidbitToDoSubtask >> summary [

	^ summary
]

{ #category : #accessing }
TidbitToDoSubtask >> summary: anObject [

	summary := anObject
]

{ #category : #'accessing-magritte' }
TidbitToDoSubtask >> summaryDescription [
	<magritteDescription>

	^ MAStringDescription new
		accessor: #summary;
		default: '';
		label: 'Summary';
		cssClass: 'mcw-textfield';
		priority: 15;
		beRequired;
		yourself
]
