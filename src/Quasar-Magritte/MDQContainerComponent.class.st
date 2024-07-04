Class {
	#name : 'MDQContainerComponent',
	#superclass : 'MAContainerComponent',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'decorating' }
MDQContainerComponent >> addForm: aCollection [

	self addDecoration: (MDQFormDecoration buttons: aCollection)
]

{ #category : 'private' }
MDQContainerComponent >> buildChildren [
	| map newChildren |

	"map := self magritteDescription componentClassMap."
	map := Dictionary new.

	self magritteDescription
		componentClass: MDQContainerComponent;
		do: [ :eachChild | | theClass |
			theClass := map at: eachChild label ifAbsent: [ eachChild mdqComponentClass ].
			eachChild componentClass: theClass ].

	newChildren := self magritteDescription
		inject: Dictionary new
		into: [ :result :each |
			each isVisible ifTrue: [
				| newComponent |
				newComponent := each componentClass memento: self memento description: each parent: self.
				result at: each put: newComponent ].
			result ].

	^ newChildren
]

{ #category : 'rendering' }
MDQContainerComponent >> renderContentOn: html [

	"| width |

	width := self magritteDescription propertyAt: #cardWidth ifAbsent: [300]."

	"html div
		style: 'padding: 16px';
		with: [
			self renderSaveCancelOn: html.
			super renderContentOn: html]"

	super renderContentOn: html

]

{ #category : 'actions' }
MDQContainerComponent >> save [
	self validate ifFalse: [ ^ self ].
	self commit.
	self model class isVoyageRoot
		ifTrue: [ self mdqApplicationGet saveObject: self model ].
	self answer: self model
]
