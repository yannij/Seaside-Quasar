Class {
	#name : #LoanexRootObject,
	#superclass : #MDQModel,
	#category : #'Tidbit-Loanex-Model'
}

{ #category : #accessing }
LoanexRootObject class >> descriptionContainerClass [

	^ MDQPriorityContainer
]

{ #category : #voyage }
LoanexRootObject >> cardParameters [

	^ Array with: self mdPrimaryString with: self mdSecondaryString
]

{ #category : #printing }
LoanexRootObject >> chipIconName [

	^ #toys
]

{ #category : #printing }
LoanexRootObject >> dataBadgeValue [

	^ ''

]

{ #category : #voyage }
LoanexRootObject >> descriptionContainer [
	"Return the default description container."
	<magritteContainer>

	^ self class descriptionContainerClass new
		componentRenderer: MDQCssRenderer;
		label: self class label;
		propertyAt: #cardWidth ifAbsentPut: [ 600 ];
		yourself
]

{ #category : #printing }
LoanexRootObject >> hasDataBadge [

	^ false

]

{ #category : #voyage }
LoanexRootObject >> listItemParameters [

	^ Array with: self mdPrimaryString with: self mdSecondaryString
]

{ #category : #printing }
LoanexRootObject >> mdPrimaryString [

	^ self printString
]

{ #category : #printing }
LoanexRootObject >> mdSecondaryString [

	^ '<Model:', self hash printString, '>'
]

{ #category : #accessing }
LoanexRootObject >> mementoClass [

	^ MAStraightMemento
]
