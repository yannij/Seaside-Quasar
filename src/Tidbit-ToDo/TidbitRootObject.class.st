Class {
	#name : #TidbitRootObject,
	#superclass : #MDQModel,
	#classInstVars : [
		'DescriptionContainerClass'
	],
	#category : #'Tidbit-ToDo-Model'
}

{ #category : #printing }
TidbitRootObject >> chipIconName [

	^ #toys
]

{ #category : #printing }
TidbitRootObject >> dataBadgeValue [

	^ ''

]

{ #category : #printing }
TidbitRootObject >> hasDataBadge [

	^ false

]

{ #category : #printing }
TidbitRootObject >> mdPrimaryString [

	^ self printString
]

{ #category : #printing }
TidbitRootObject >> mdSecondaryString [

	^ '<Model:', self hash printString, '>'
]

{ #category : #accessing }
TidbitRootObject >> mementoClass [

	^ MAStraightMemento
]
