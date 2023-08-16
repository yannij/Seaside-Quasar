"
I represent the configuration values passed by Docker when deploying via a Docker container.

I load a config or secret file. The file should be located in the default Docker location,
or mapped by the Docker command invocation to appear in the Smalltalk image directory.

The default directory for a config is ""/"".
The default directory for a secret is ""/run/secrets/""

In this implementation the ""config"" and ""secret"" files are expected to be in json format,
and contain a single json dictionary. For example, the machine name for the mongo database
could be passed in a config file. Assume a file named ""mongo.json"" has content:
	{
		""mongo-host"":""mongo-data-center-1""
	}

Create the config in Docker using:
% docker config create mongo.json - < mongo.json

During image startup, or afterward, the following code needs to run:
	DockerDeploy current loadConfigNamed: 'mongo'

Then the config value is avaialbe using:
	DockerDeploy current at: 'mongo' atKey: 'mongo-host'
which should answer
	'mongo-data-center-1'
"
Class {
	#name : #DockerDeploy,
	#superclass : #Object,
	#instVars : [
		'configNames',
		'configs'
	],
	#classVars : [
		'Current'
	],
	#category : #DockerUtility
}

{ #category : #accessing }
DockerDeploy class >> current [

	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
DockerDeploy class >> currentReset [

	Current := nil
]

{ #category : #accessing }
DockerDeploy class >> defaultAtKey: aKey [

	^ self defaultAtKey: aKey ifAbsent: [ nil ]
]

{ #category : #accessing }
DockerDeploy class >> defaultAtKey: aKey ifAbsent: aBlock [

	^ self current configsAt: self defaultConfigName atKey: aKey ifAbsent: aBlock
]

{ #category : #accessing }
DockerDeploy class >> defaultConfigName [

	^ 'default'
]

{ #category : #accessing }
DockerDeploy class >> loadDefaultConfig [
	"
	DockerDeploy loadDefaultConfig.
	"

	^ self current loadConfigNamed: self defaultConfigName
]

{ #category : #accessing }
DockerDeploy >> configNames [
	^ configNames
]

{ #category : #accessing }
DockerDeploy >> configNames: anObject [
	configNames := anObject
]

{ #category : #'api - configs' }
DockerDeploy >> configNamesAdd: aConfigName [

	self configNames add: aConfigName
]

{ #category : #'api - configs' }
DockerDeploy >> configNamesRemove: aConfigName [

	self configNames remove: aConfigName ifAbsent: [ nil ]
]

{ #category : #accessing }
DockerDeploy >> configs [
	^ configs
]

{ #category : #accessing }
DockerDeploy >> configs: anObject [
	configs := anObject
]

{ #category : #'api - configs' }
DockerDeploy >> configsAt: aConfigName atKey: aKey [

	^ self configsAt: aConfigName atKey: aKey ifAbsent: [ nil ]
]

{ #category : #'api - configs' }
DockerDeploy >> configsAt: aConfigName atKey: aKey ifAbsent: aBlock [
	| json |

	json := self configs at: aConfigName ifAbsent: [ ^ aBlock value ].
	^ json at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
DockerDeploy >> configsAt: aString put: aJsonDictionary [

	self configs at: aString put: aJsonDictionary
]

{ #category : #initialization }
DockerDeploy >> initialize [

	super initialize.

	self configNames: Set new.
	self configs: Dictionary new
]

{ #category : #'api - configs' }
DockerDeploy >> loadAllConfigs [
	"
	DockerDeploy current loadAllConfigs
	"

	self configNames do: [ :eachName |
		self loadConfigNamed: eachName ]
]

{ #category : #'api - configs' }
DockerDeploy >> loadConfigNamed: aString [
	"
	DockerDeploy current loadConfigNamed: DockerDeploy defaultConfigName
	"
	| configFileName configFile json |

	configFileName := aString, '.json'.
	configFile := SmalltalkImage current imageDirectory / configFileName.
	configFile exists
		ifFalse: [ configFile := FileSystem root / configFileName ].

	json := WAJsonParser parse: configFile contents.

	self configsAt: aString put: json
]

{ #category : #private }
DockerDeploy >> runAppMethodsWithPragmaNamed: aPragmaName [
	| appRootClass |

	appRootClass := #QuasarApplication asClassInEnvironment: Smalltalk globals ifAbsent: [ nil ].
	appRootClass ifNil: [ ^ self ].

	appRootClass allSubclasses do: [ :eachClass | | pragmas appMetaClass |
		appMetaClass := eachClass class.
		pragmas := Pragma allNamed: aPragmaName in: appMetaClass.
		pragmas do: [ :eachPragma |
			appMetaClass soleInstance perform: eachPragma method selector asSymbol ] ]
]

{ #category : #'api - deploy' }
DockerDeploy >> runStartup [
	"
	Invoke this method during Docker container start up.

	DockerDeploy current runStartup
	"

	self runStartupPreLoad.
	self loadAllConfigs.
	self runStartupPostLoad
]

{ #category : #private }
DockerDeploy >> runStartupPostLoad [

	self runAppMethodsWithPragmaNamed: #dockerDeployPostLoad
]

{ #category : #private }
DockerDeploy >> runStartupPreLoad [

	self runAppMethodsWithPragmaNamed: #dockerDeployPreLoad
]

{ #category : #'api - secrets' }
DockerDeploy >> secretNamed: aSecretName [
	| secretFileName secretFile json |

	secretFileName := aSecretName, '.json'.

	"If the secret file exists in the image directory, then it is used"
	secretFile := SmalltalkImage current imageDirectory / secretFileName.

	"Otherwise, look for it in the default docker secrets directory"
	secretFile exists
		ifFalse: [ secretFile := FileSystem root / 'run' / 'secrets' / secretFileName ].

	secretFile exists
		ifFalse: [ ^ nil ].

	json := WAJsonParser parse: secretFile contents.

	^ json
]

{ #category : #'api - secrets' }
DockerDeploy >> secretsAt: aSecretName atKey: aKey [

	^ self secretsAt: aSecretName atKey: aKey ifAbsent: [ nil ]
]

{ #category : #'api - secrets' }
DockerDeploy >> secretsAt: aSecretName atKey: aKey ifAbsent: aBlock [
	| json secrets |

	secrets := self secretNamed: aSecretName.
	json := secrets ifNil: [ ^ aBlock value ].
	^ json at: aKey ifAbsent: aBlock
]
