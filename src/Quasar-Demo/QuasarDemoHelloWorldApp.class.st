"
I am a ""hello world"" application for the Quasar Framework in Seaside.
"
Class {
	#name : 'QuasarDemoHelloWorldApp',
	#superclass : 'QuasarApplication',
	#category : 'Quasar-Demo-Basic',
	#package : 'Quasar-Demo',
	#tag : 'Basic'
}

{ #category : 'initialization' }
QuasarDemoHelloWorldApp class >> applicationPath [

	^ 'quasar/hello-world'
]

{ #category : 'accessing' }
QuasarDemoHelloWorldApp class >> categoryName [

	^ #demo
]

{ #category : 'initialization' }
QuasarDemoHelloWorldApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : 'accessing' }
QuasarDemoHelloWorldApp >> applicationTitle [

	^ 'HelloWorld'
]

{ #category : 'rendering' }
QuasarDemoHelloWorldApp >> renderAppOn: html [

	html qLayout view: 'hHh lpR fFf'; with: [
		html qHeader elevated; heightHint: 98; class: 'bg-primary text-white'; with: [
			html qToolbar with: [
				html qToolbarTitle with: [
					html text: 'Hello World Example' ] ] ].
		html qPageContainer with: [
			html span with: 'Start your application here, to use Quasar Framework directly' ] ]
]

{ #category : 'rendering' }
QuasarDemoHelloWorldApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		self renderAppOn: html ]
]
