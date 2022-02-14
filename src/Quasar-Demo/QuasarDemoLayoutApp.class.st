"
I am a demo application showing how to use the layout features of the Quasar Framework from Seaside.
"
Class {
	#name : #QuasarDemoLayoutApp,
	#superclass : #QuasarApplication,
	#category : #'Quasar-Demo-Basic'
}

{ #category : #initialization }
QuasarDemoLayoutApp class >> applicationPath [

	^ 'quasar/layout-demo'
]

{ #category : #initialization }
QuasarDemoLayoutApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QuasarDemoLayoutApp >> applicationTitle [

	^ 'Layout'
]

{ #category : #rendering }
QuasarDemoLayoutApp >> renderColorThemeOn: html [

	html div class: 'q-pa-md'; class: 'q-gutter-sm'; with: [
		html qBtn unelevated; outline;
			type: 'a'; href: (html urlForAction: [ self colorTheme: nil ]);
			with: 'None'.

		html qBtn unelevated; outline;
			type: 'a'; href: (html urlForAction: [ self colorTheme: MDQTheme colorThemeQuasar ]);
			with: 'Quasar'.

		html qBtn unelevated; outline;
			type: 'a'; href: (html urlForAction: [ self colorTheme: MDQTheme colorThemeQuasarDark ]);
			with: 'Quasar Dark'.

		html qBtn unelevated; outline;
			type: 'a'; href: (html urlForAction: [ self colorTheme: MDQTheme colorThemeSynthwave ]);
			with: 'Synthwave' ].

	html div class: 'row'; class: 'q-gutter-md'; with: [
		#(primary secondary accent positive negative info warning background) do: [ :each |
			html qCard bordered; class: 'col-1'; style: 'width: 200px'; with: [
				html text: each asString.
				html qCardSection with: [
					html div style: 'background: var(--q-', each asString, ')'; with: [
						html break ] ] ] ] ]
]

{ #category : #rendering }
QuasarDemoLayoutApp >> renderExampleOn: html [

	html qLayout view: 'hHh lpR fFf'; with: [
		html qHeader elevated; heightHint: 98; class: 'bg-primary text-white'; with: [
			html qToolbar with: [
				html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'.
				html qToolbarTitle with: [
					html qAvatar with: [
						html image url: 'https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg' ].
					html text: 'Title' ].
				html qBtn dense; flat; round; icon: 'view_sidebar'; vOnClick: 'this.$refs.rightDrawer.toggle($event)' ].
		html qTabs align: 'left'; with: [
			html qRouteTab to: 'page1'; label: 'Page One'.
			html qRouteTab to: 'page2'; label: 'Page Two'.
			html qRouteTab to: 'page3'; label: 'Page Three' ] ].
		html qDrawer ref: 'leftDrawer'; showIfAbove; side: 'left'; behavior: 'desktop'; with: 'left drawer content'.
		html qDrawer ref: 'rightDrawer'; showIfAbove; side: 'right'; bordered; with: 'right drawer content'.
		html qPageContainer with: [ self renderPageOn: html ].
		html qFooter elevated; class: 'bg-grey-8 text-white'; with: [
			html qToolbar with: [
				html qToolbarTitle with: [
					html qAvatar with: [
						html image url: 'https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg' ].
					html text: 'Title' ] ] ] ]
]

{ #category : #rendering }
QuasarDemoLayoutApp >> renderLayoutOn: html [

	self renderSetColorTheme: self colorTheme on: html.

	html qApp id: self appId; with: [
		self renderExampleOn: html ]
]

{ #category : #rendering }
QuasarDemoLayoutApp >> renderPageOn: html [

	self renderColorThemeOn: html
]
