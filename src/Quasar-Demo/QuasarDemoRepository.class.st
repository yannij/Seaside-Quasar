Class {
	#name : #QuasarDemoRepository,
	#superclass : #Object,
	#classInstVars : [
		'map'
	],
	#category : #'Quasar-Demo-Common'
}

{ #category : #accessing }
QuasarDemoRepository class >> map [

	^ map ifNil: [ map := Dictionary new ]
]

{ #category : #accessing }
QuasarDemoRepository class >> mapAt: aKey ifAbsent: aBlock [

	^ self map at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
QuasarDemoRepository class >> mapCreateAt: aKey [
	| repo |

	self map at: aKey ifPresent: [ :value | value close ].
	repo := (self onPath: aKey) create; open; yourself.
	^ self map at: aKey put: repo
]

{ #category : #accessing }
QuasarDemoRepository class >> mapReset [
	"
	self mapReset
	"

	map ifNotNil: [ :value |
		value values do: [ :each | each close ] ].

	map := nil
]

{ #category : #'instance creation' }
QuasarDemoRepository class >> onPath: aString [

	^ self new
		path: aString;
		yourself
]

{ #category : #accessing }
QuasarDemoRepository class >> singletonKey [

	^ 'current'
]

{ #category : #api }
QuasarDemoRepository >> close [
	"Do nothing. Subclasses may override"
]

{ #category : #persistence }
QuasarDemoRepository >> collectionNameFor: aClass [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> commit: aBlock [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> count: aClass [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> count: aClass where: aDictionary [

	self subclassResponsibility
]

{ #category : #api }
QuasarDemoRepository >> create [
	"Do nothing. Subclasses may override"
]

{ #category : #api }
QuasarDemoRepository >> destroy [
	"Do nothing. Subclasses may override"
]

{ #category : #api }
QuasarDemoRepository >> open [
	"Do nothing. Subclasses may override"
]

{ #category : #api }
QuasarDemoRepository >> path: anObject [
	"Subclasses may override"
]

{ #category : #persistence }
QuasarDemoRepository >> remove: anObject [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> removeAll: aClass [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> selectAll: aClass [

	^ self selectAll: aClass sortBy: nil
]

{ #category : #persistence }
QuasarDemoRepository >> selectAll: aClass sortBy: sortBlockOrSymbol [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> selectMany: aClass where: aDictionary [

	^ self selectMany: aClass where: aDictionary limit: nil
]

{ #category : #persistence }
QuasarDemoRepository >> selectMany: aClass where: aDictionary limit: aLimit [

	^ self selectMany: aClass where: aDictionary limit: aLimit offset: 0
]

{ #category : #persistence }
QuasarDemoRepository >> selectMany: aClass where: aDictionary limit: aLimit offset: anOffset [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> selectMany: aClass where: aBlock sortBy: sortBlockOrSymbol [

	self subclassResponsibility
]

{ #category : #persistence }
QuasarDemoRepository >> selectOne: aClass where: aBlock [

	self subclassResponsibility
]
