Extension { #name : #WAComponent }

{ #category : #'*Quasar-Components' }
WAComponent >> mdqApplicationGet [

	^ self session
		ifNil: [ nil ]
		ifNotNil: [ :value | value presenter ]
]

{ #category : #'*Quasar-Components' }
WAComponent class >> mdqPublicServerUrl [
	"Answer URL based on Seaside configuration of:
		serverProtocol
		serverHostname
		serverPort
		serverPath
	Answer nil if serverHostname is not set.
	Example:
		WAComponent mcwPublicServerUrl
	"
	| serverUrl |

	serverUrl := WADispatcher default url.
	^ serverUrl host
		ifNil: [ nil ]
		ifNotNil: [ :value | serverUrl ]
]

{ #category : #'*Quasar-Components' }
WAComponent >> mdqPublicServerUrl [

	^ self class mdqPublicServerUrl
]

{ #category : #'*Quasar-Components' }
WAComponent class >> mdqPublicServerUrl: aUrlString [
	"Set Seaside configuration of:
		serverProtocol
		serverHostname
		serverPort
		serverPath

	Example:
		WAComponent mdqPublicServerUrl: 'http://foobar.com'.
		WAComponent mdqPublicServerUrl: 'http://localhost:8080'.
	"
	| newUrl |

	newUrl := WAUrl absolute: aUrlString.

	WADispatcher default
	serverProtocol: newUrl scheme;
	serverHostname: newUrl host;
	serverPort: newUrl port;
	serverPath: newUrl pathStringUnencoded.
]

{ #category : #'*Quasar-Components' }
WAComponent class >> mdqPublicServerUrlInstallDockerConfig [
	"
	DockerDeploy current loadConfigNamed: DockerDeploy defaultConfigName.
	WAComponent mdqPublicServerUrlInstallDockerConfig
	"
	| publicServerUrl |

	publicServerUrl := DockerDeploy current configsAt: DockerDeploy defaultConfigName atKey: 'publicServerUrl'.
	publicServerUrl ifNil: [ ^ self ].

	self mdqPublicServerUrl: publicServerUrl
]
