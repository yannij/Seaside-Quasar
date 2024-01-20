Class {
	#name : #QuasarDemoAccountingMemoryDbApp,
	#superclass : #QuasarDemoAccountingApp,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #initialization }
QuasarDemoAccountingMemoryDbApp class >> applicationPath [

	^ 'quasar/accounting'
]

{ #category : #initialization }
QuasarDemoAccountingMemoryDbApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #initialization }
QuasarDemoAccountingMemoryDbApp class >> repositoryClass [
	"
	self createData
	"

	^ QuasarDemoMemoryRepository
]
