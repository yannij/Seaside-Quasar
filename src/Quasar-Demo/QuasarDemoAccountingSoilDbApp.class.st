Class {
	#name : #QuasarDemoAccountingSoilDbApp,
	#superclass : #QuasarDemoAccountingApp,
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #initialization }
QuasarDemoAccountingSoilDbApp class >> applicationPath [

	^ 'quasar/accounting-soil'
]

{ #category : #initialization }
QuasarDemoAccountingSoilDbApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]
