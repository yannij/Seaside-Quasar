Class {
	#name : 'QuasarDemoBrowseApp',
	#superclass : 'QuasarApplication',
	#category : 'Quasar-Demo-Basic',
	#package : 'Quasar-Demo',
	#tag : 'Basic'
}

{ #category : 'initialization' }
QuasarDemoBrowseApp class >> applicationPath [

	^ 'quasar/browse'
]

{ #category : 'initialization' }
QuasarDemoBrowseApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : 'accessing' }
QuasarDemoBrowseApp >> applicationTitle [

	^ 'Browse'
]

{ #category : 'rendering' }
QuasarDemoBrowseApp >> demoClassNames [

	^ #(
	#QuasarDemoHelloWorldApp
	#QuasarDemoLayoutApp
	#QuasarDemoComponentApp
	#QuasarDemoReactiveApp
	#QuasarDemoServerSideTablePaginationApp
	#QuasarDemoHtmlTextApp
	#QuasarDemoMarkdownApp
	#QuasarDemoAccountingMemoryDbApp
	#QuasarDemoAccountingSoilDbApp
	#QuasarDemoMovieListingApp
	#QShrineApp
	#QRallyApp
	#QTidbitToDoApp
	#QLoanexApp
	#CraneApp
	#ShrineApp
	#RallyApp
	#TidbitToDoApp
	#LoanexApp
	#KeycloakHelloApp
	#KeycloakHelloBootstrapApp
	#TBApplicationRootComponent
	#TB2ApplicationRootComponent
	#QuasarDemoVueUsageApp
	#QuasarDemoVueRouterApp
	#QuasarCodePenVueRouterApp
	#QuasarDemoUtilsApp
	#QuasarDemoScaffoldApp
	)
]

{ #category : 'rendering' }
QuasarDemoBrowseApp >> demoClasses [

	^ self demoClassNames
		inject: OrderedCollection new
		into: [ :list :each |
			(each asClassInEnvironment: Smalltalk globals ifAbsent: [])
				ifNotNil: [ :theClass | list add: theClass ].
			list ]
]

{ #category : 'rendering' }
QuasarDemoBrowseApp >> demoClassesOfCategory: categoryName [
	"Answer classes belonging to categoryName.
	If the class does not respond to #categoryName,
	then include it in the #misc category"

	^ self demoClasses select: [ :eachClass |
		(eachClass respondsTo: #categoryName)
			ifTrue:  [ eachClass categoryName = categoryName ]
			ifFalse: [ #misc = categoryName ] ]
]

{ #category : 'rendering' }
QuasarDemoBrowseApp >> demoTabData [

	^ {
		#demo -> 'Demo'.
		#studies -> 'Material Studies'.
		#quasar -> 'Quasar'.
		#misc -> 'Misc'
	}
]

{ #category : 'rendering - quasar hooks' }
QuasarDemoBrowseApp >> quasarSetupReturnCustomList: aList with: anAjaxFactory [
	
	aList add: '
tab: ref(''demo'')'
]

{ #category : 'rendering' }
QuasarDemoBrowseApp >> renderDemoCard: anAppClass on: html [
	| url comment |

	url := WAUrl absolute: anAppClass applicationPath.
	comment := SystemVersion current major >= 12
		ifTrue: [ anAppClass comment ]
		ifFalse: [ anAppClass organization classComment ].

	html qCard "class: 'bg-secondary text-white';" with: [
		html qCardSection with: [
			"html div class: 'text-h6'; with: anAppClass name asString."
			html div class: 'text-h6'; with: anAppClass basicNew applicationTitle.
			html div class: 'text-subtitle2'; with: url greaseString ].
		html qCardSection with: comment.
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

{ #category : 'rendering' }
QuasarDemoBrowseApp >> renderDemoCategory: categoryName on: html [

	html div class: 'row'; class: 'q-pa-md'; class: 'q-col-gutter-md'; with: [
		(self demoClassesOfCategory: categoryName) do: [ :eachClass |
			html div class: 'col-xs-6 col-sm-4 col-md-3 col-lg-2 col-xl-2'; with: [
				self renderDemoCard: eachClass on: html ] ] ]
]

{ #category : 'rendering' }
QuasarDemoBrowseApp >> renderDemoTabPanel: data on: html [

	html qTabPanel name: data key; with: [
		html div class: 'text-h6'; with: data value.
		self renderDemoCategory: data key on: html ]
]

{ #category : 'rendering' }
QuasarDemoBrowseApp >> renderDemosOn: html [

	html qTabs vModel: 'tab'; dense; class: 'text-grey'; activeColor: 'primary'; indicatorColor: 'primary'; align: 'justify'; narrowIndicator; with: [
		self demoTabData do: [ :data |
			html qTab name: data key; label: data value ] ].
	html qSeparator.
	html qTabPanels vModel: 'tab'; animated; with: [
		self demoTabData do: [ :data |
			self renderDemoTabPanel: data on: html ] ]
]

{ #category : 'rendering' }
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
