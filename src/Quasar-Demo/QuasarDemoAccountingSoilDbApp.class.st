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

{ #category : #initialization }
QuasarDemoAccountingSoilDbApp >> repositorySetup [
	| repo |

	repo := (QuasarDemoSoilRepository path: 'soil-demo-acct') open; yourself.
	self repository: repo
]

{ #category : #accessing }
QuasarDemoAccountingSoilDbApp >> repositoryToUse [
	| useGlobalRepo |

	useGlobalRepo := false.

	^ useGlobalRepo
		ifTrue: [ QuasarDemoSoilRepository current ]
		ifFalse: [ self repository ]
]
