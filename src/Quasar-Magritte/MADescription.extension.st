Extension { #name : #MADescription }

{ #category : #'*Quasar-Magritte' }
MADescription >> mdqComponentClass [

	^ self propertyAt: #mdqComponentClass ifAbsent: [ self class mdqDefaultComponentClass ]
]

{ #category : #'*Quasar-Magritte' }
MADescription >> mdqComponentClass: aClass [

	self propertyAt: #mdqComponentClass put: aClass
]

{ #category : #'*Quasar-Magritte' }
MADescription class >> mdqDefaultComponentClass [

	^ self mdqDefaultComponentClasses
		ifEmpty: [ MAUndefinedComponent ]
		ifNotEmpty: [ :list | list first ]
]

{ #category : #'*Quasar-Magritte' }
MADescription class >> mdqDefaultComponentClasses [

	^ Array with: MAUndefinedComponent
]

{ #category : #'*Quasar-Magritte' }
MADescription class >> mdqDefaultReportColumnClass [

	^ MDQDescribedColumn
]

{ #category : #'*Quasar-Magritte' }
MADescription >> mdqIsReference [
	"Answer ==true== if the receiver is a reference description."

	^ false
]

{ #category : #'*Quasar-Magritte' }
MADescription >> mdqOptionsClass [

	^ self propertyAt: #mdqOptionsClass ifAbsent: [ nil ]
]

{ #category : #'*Quasar-Magritte' }
MADescription >> mdqOptionsClass: aClass [

	self propertyAt: #mdqOptionsClass put: aClass
]

{ #category : #'*Quasar-Magritte' }
MADescription >> mdqReportColumnClass [

	^ self propertyAt: #mdqReportColumnClass ifAbsent: [ self class mdqDefaultReportColumnClass ]
]

{ #category : #'*Quasar-Magritte' }
MADescription >> mdqTableAlign [

	^ self propertyAt: #mdqTableAlign ifAbsent: [ 'left' ]
]

{ #category : #'*Quasar-Magritte' }
MADescription >> mdqTableAlign: aClass [

	self propertyAt: #mdqTableAlign put: aClass
]
