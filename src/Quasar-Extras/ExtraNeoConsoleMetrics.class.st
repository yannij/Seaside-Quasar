Class {
	#name : #ExtraNeoConsoleMetrics,
	#superclass : #Object,
	#category : #'Quasar-Extras'
}

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> appSessions [
	"Answer size of session cache for the root application"

	^ (WADispatcher default handlerAt: SsrRootApp applicationPath) cache size
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> appSessionstInstall [

	NeoConsoleMetric
		addNamed: 'app.sessions'
		description: 'Size of application session cache'
		reader: [ self appSessions ]
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> fileCount [

	^ File allInstances size
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> fileCountInstall [

	NeoConsoleMetric
		addNamed: 'file.count'
		description: 'Size of File allInstances'
		reader: [ self fileCount ]
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> fileRegistrySize [

	^ File registry size
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> fileRegistrySizeInstall [

	NeoConsoleMetric
		addNamed: 'file.registry'
		description: 'Size of File registry'
		reader: [ self fileRegistrySize ]
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> imageExternalObjectsSize [

	^ Smalltalk image externalObjects size
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> imageExternalObjectsSizeInstall [

	NeoConsoleMetric
		addNamed: 'image.externalObjects'
		description: 'Size of Smalltalk image externalObjects'
		reader: [ self imageExternalObjectsSize ]
]

{ #category : #actions }
ExtraNeoConsoleMetrics class >> initialize [
	"self initialize"

	self install
]

{ #category : #actions }
ExtraNeoConsoleMetrics class >> install [
	"ExtraNeoConsoleMetrics install"

	self
		appSessionstInstall;
		fileCountInstall;
		fileRegistrySizeInstall;
		imageExternalObjectsSizeInstall;
		processCount2Install;
		semaphoreCountInstall;
		socketCountInstall
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> processCount2 [

	^ Process allInstances size
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> processCount2Install [

	NeoConsoleMetric
		"Note: NeoConsoleMetric already defines a process.count"
		addNamed: 'process.count2'
		description: 'Size of Process allInstances'
		reader: [ self processCount2 ]
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> semaphoreCount [

	^ Semaphore allInstances size
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> semaphoreCountInstall [

	NeoConsoleMetric
		addNamed: 'semaphore.count'
		description: 'Size of Semaphore allInstances'
		reader: [ self semaphoreCount ]
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> socketCount [

	^ Socket allInstances size
]

{ #category : #metrics }
ExtraNeoConsoleMetrics class >> socketCountInstall [

	NeoConsoleMetric
		addNamed: 'socket.count'
		description: 'Size of Socket allInstances'
		reader: [ self socketCount ]
]
