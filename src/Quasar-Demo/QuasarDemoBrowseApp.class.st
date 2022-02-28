Class {
	#name : #QuasarDemoBrowseApp,
	#superclass : #QuasarApplication,
	#category : #'Quasar-Demo-Basic'
}

{ #category : #initialization }
QuasarDemoBrowseApp class >> applicationPath [

	^ 'quasar/browse'
]

{ #category : #initialization }
QuasarDemoBrowseApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QuasarDemoBrowseApp >> applicationTitle [

	^ 'Browse'
]

{ #category : #rendering }
QuasarDemoBrowseApp >> demoClasses [

	^ #(
	#QuasarDemoHelloWorldApp
	#QuasarDemoLayoutApp
	#QuasarDemoComponentApp
	#QuasarDemoReactiveApp
	#QShrineApp
	#QRallyApp
	#QTidbitToDoApp
	#QLoanexApp
	#ShrineApp
	#RallyApp
	#TidbitToDoApp
	#LoanexApp
	#QuasarDemoScaffoldApp
	)
	collect: [ :eachApp | eachApp asClassInEnvironment: Smalltalk globals ifAbsent: [ nil ] ]
]

{ #category : #rendering }
QuasarDemoBrowseApp >> renderDemoCard: anAppClass on: html [
	| url |

	url := WAUrl absolute: anAppClass applicationPath.

	html qCard "class: 'bg-secondary text-white';" with: [
		html qCardSection with: [
			"html div class: 'text-h6'; with: anAppClass name asString."
			html div class: 'text-h6'; with: anAppClass basicNew applicationTitle.
			html div class: 'text-subtitle2'; with: url greaseString ].
		html qCardSection with: anAppClass organization classComment.
		html qSeparator dark.
		html qCardActions "align: 'right';" vertical with: [
			html qBtn "flat;" class: 'justify-end';
				onClick: 'Quasar.openURL(''', url greaseString, ''')';
				with: 'Open' ] ].

	"html div with: [
		(anAppClass class canUnderstand: #snapshotUrl) ifTrue: [
			html image
				url: (anAppClass class soleInstance perform: #snapshotUrl) ] ]"
]

{ #category : #rendering }
QuasarDemoBrowseApp >> renderDemosOn: html [

	html div class: 'row'; class: 'q-pa-md'; class: 'q-col-gutter-md'; with: [
		(self demoClasses select: [ :eachClass | eachClass notNil ]) do: [ :eachClass |
			html div class: 'col-xs-6 col-sm-4 col-md-3 col-lg-2 col-xl-2'; with: [
			self renderDemoCard: eachClass on: html ] ] ]
]

{ #category : #rendering }
QuasarDemoBrowseApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; with: [
			html qHeader heightHint: 98; class: 'bg-primary text-white'; with: [
				html qToolbar with: [
					html qToolbarTitle with: [
						html text: 'Quasar Framework on Seaside - Browse Demos' ] ] ].
			html qPageContainer with: [
				self renderDemosOn: html ] ] ]
]
