Class {
	#name : #QuasarReactiveObject,
	#superclass : #Object,
	#instVars : [
		'refName',
		'refValue',
		'transformBlock'
	],
	#category : #'Quasar-Components'
}

{ #category : #'instance creation' }
QuasarReactiveObject class >> name: aString value: anObject [

	^ self new
		refName: aString;
		refValue: anObject;
		yourself
]

{ #category : #accessing }
QuasarReactiveObject >> refName [

	^ refName
]

{ #category : #accessing }
QuasarReactiveObject >> refName: anObject [

	refName := anObject
]

{ #category : #accessing }
QuasarReactiveObject >> refValue [

	^ refValue
]

{ #category : #accessing }
QuasarReactiveObject >> refValue: anObject [

	refValue := anObject
]

{ #category : #accessing }
QuasarReactiveObject >> refValueUpdate: anObject [
	| newValue |

	newValue := self transformBlock ifNil: [ anObject ] ifNotNil: [ :block | block value: anObject ].
	self refValue: newValue
]

{ #category : #accessing }
QuasarReactiveObject >> transformBlock [

	^ transformBlock
]

{ #category : #accessing }
QuasarReactiveObject >> transformBlock: anObject [

	transformBlock := anObject
]
