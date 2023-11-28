Class {
	#name : #QuasarApplication,
	#superclass : #WAComponent,
	#instVars : [
		'quasarVersion',
		'colorTheme',
		'reactiveObjects',
		'onMountedObjects'
	],
	#category : #'Quasar-Components'
}

{ #category : #testing }
QuasarApplication class >> canBeRoot [
	^ true
]

{ #category : #'instance creation' }
QuasarApplication class >> mdqRegisterDeployment: aName [
	| app |

	self environment at: #WADevelopmentConfiguration ifPresent: [ :theClass |
		WAAdmin applicationDefaults removeParent: theClass instance ].

	app := WAAdmin register: self asApplicationAt: aName.
	"app addLibrary: JQGoogleLibrary."
	^ app
]

{ #category : #accessing }
QuasarApplication >> appId [

	^ 'qId'
]

{ #category : #accessing }
QuasarApplication >> applicationTitle [

	self subclassResponsibility
]

{ #category : #accessing }
QuasarApplication >> colorTheme [

	^ colorTheme
]

{ #category : #accessing }
QuasarApplication >> colorTheme: anObject [

	colorTheme := anObject
]

{ #category : #accessing }
QuasarApplication >> faviconUrl [
	"Subclasses may override"

	^ nil
]

{ #category : #initialization }
QuasarApplication >> initialize [

	super initialize.
	self onMountedObjectsClear.
	self reactiveObjectsClear
]

{ #category : #login }
QuasarApplication >> isLoggedIn [

	^ self loginComponent notNil and: [ self loginComponent isLoggedIn ]
]

{ #category : #accessing }
QuasarApplication >> jsdelivrUrlFragment [

	^ 'https://cdn.jsdelivr.net/npm/quasar@<1s>/dist/' expandMacrosWith: self quasarVersionLazy
]

{ #category : #logging }
QuasarApplication >> logFormat: aFormatString with: aValue [

	self logString: (aFormatString format: (Array with: aValue))
]

{ #category : #logging }
QuasarApplication >> logFormat: aFormatString with: aValue1 with: aValue2 [

	self logString: (aFormatString format: (Array with: aValue1 with: aValue2))
]

{ #category : #logging }
QuasarApplication >> logFormat: aFormatString with: aValue1 with: aValue2 with: aValue3 [

	self logString: (aFormatString format: (Array with: aValue1 with: aValue2 with: aValue3))
]

{ #category : #logging }
QuasarApplication >> logFormat: aFormatString with: aValue1 with: aValue2 with: aValue3 with: aValue4 [

	self logString: (aFormatString format: (Array with: aValue1 with: aValue2 with: aValue3 with: aValue4))
]

{ #category : #logging }
QuasarApplication >> logFormat: aFormatString with: aValue1 with: aValue2 with: aValue3 with: aValue4 with: aValue5 [

	self logString: (aFormatString format: (Array with: aValue1 with: aValue2 with: aValue3 with: aValue4 with: aValue5))
]

{ #category : #logging }
QuasarApplication >> logString: aString [

	self crTrace: aString
]

{ #category : #login }
QuasarApplication >> logout [

	self loginComponent
		ifNotNil: [ :component |
			component loggedOut ]
		ifNil: [
			self session ifNotNil: [ :value | value unregister ].
			self redirect ]
]

{ #category : #testing }
QuasarApplication >> needsMarkdown [

	^ true
]

{ #category : #accessing }
QuasarApplication >> onMountedObjects [

	^ onMountedObjects
]

{ #category : #accessing }
QuasarApplication >> onMountedObjects: anObject [

	onMountedObjects := anObject
]

{ #category : #accessing }
QuasarApplication >> onMountedObjectsAdd: anObject [

	self onMountedObjects at: anObject refName put: anObject
]

{ #category : #accessing }
QuasarApplication >> onMountedObjectsClear [

	self onMountedObjects: OrderedDictionary new
]

{ #category : #'rendering - quasar' }
QuasarApplication >> quasarAppMountOn: aJSStream with: anAjaxFactory [

	aJSStream
		nextPutAll: 'const { useQuasar } = Quasar;';
		nextPutAll: 'const { ref, onMounted, computed } = Vue;';
		nextPutAll: 'const app = Vue.createApp({'.
	self quasarSetupOn: aJSStream with: anAjaxFactory.
	aJSStream nextPutAll: '});'.
	aJSStream nextPutAll: 'app.use(Quasar, {'.
	self quasarConfigOn: aJSStream with: anAjaxFactory.
	aJSStream nextPutAll: '});'.
	self needsMarkdown ifTrue: [
		aJSStream nextPutAll: 'app.component("QMarkdown", QMarkdown.QMarkdown);' ].
	aJSStream nextPutAll: 'app.mount("#', self appId, '")'
]

{ #category : #'rendering - quasar hooks' }
QuasarApplication >> quasarConfigContentOn: aJSStream with: html [
	"Subclasses may override"
]

{ #category : #'rendering - quasar' }
QuasarApplication >> quasarConfigOn: aJSStream with: anAjaxFactory [

	aJSStream nextPutAll: 'config: {'.
	self quasarConfigContentOn: aJSStream with: anAjaxFactory.
	aJSStream nextPutAll: '}'.
]

{ #category : #accessing }
QuasarApplication >> quasarCssUrl [

	^ self jsdelivrUrlFragment, 'quasar.rtl.prod.css'
]

{ #category : #accessing }
QuasarApplication >> quasarJsUrl [

	^ self jsdelivrUrlFragment, 'quasar.umd.prod.js'
]

{ #category : #accessing }
QuasarApplication >> quasarMarkdownCssUrl [

	^ self quasarMarkdownUrlFragment, 'index.css'
]

{ #category : #accessing }
QuasarApplication >> quasarMarkdownJsUrl [

	^ self quasarMarkdownUrlFragment, 'index.umd.js'
]

{ #category : #accessing }
QuasarApplication >> quasarMarkdownUrlFragment [

	^ 'https://cdn.jsdelivr.net/npm/@quasar/quasar-ui-qmarkdown@next/dist/'
]

{ #category : #'rendering - quasar hooks' }
QuasarApplication >> quasarSetupContentOn: aJSStream with: html [
	"Subclasses may override"
]

{ #category : #'rendering - quasar' }
QuasarApplication >> quasarSetupFetchOn: aJSStream with: anAjaxFactory [

	aJSStream nextPutAll: JSFetch jsFetchOnErrorConsoleJs.
	"aJSStream nextPutAll: QuasarRefSync onErrorNotifyJs."
	aJSStream nextPutAll: JSFetch jsFetchJs
]

{ #category : #'rendering - quasar' }
QuasarApplication >> quasarSetupOn: aJSStream with: anAjaxFactory [

	aJSStream nextPutAll: 'setup() {'.
	aJSStream nextPutAll: 'const $q = useQuasar();'.
	self quasarSetupFetchOn: aJSStream with: anAjaxFactory.
	self reactiveObjects do: [ :eachObject | eachObject quasarSetupOn: aJSStream ].
	self reactiveObjects do: [ :eachObject | eachObject writeCodeOn: aJSStream with: anAjaxFactory. aJSStream nextPutAll: ';' ].
	self quasarSetupContentOn: aJSStream with: anAjaxFactory.
	self quasarSetupOnMountedOn: aJSStream with: anAjaxFactory.
	self quasarSetupReturnList: aJSStream with: anAjaxFactory.
	aJSStream nextPutAll: '}'.
]

{ #category : #'rendering - quasar hooks' }
QuasarApplication >> quasarSetupOnMountedContentOn: aJSStream with: anAjaxFactory [
	"Subclasses may override"
]

{ #category : #'rendering - quasar' }
QuasarApplication >> quasarSetupOnMountedOn: aJSStream with: anAjaxFactory [

	aJSStream nextPutAll: '
onMounted(() => {'.
	self onMountedObjects ifNotEmpty: [ :list |
		list do: [ :eachObject | eachObject writeCodeOn: aJSStream with: anAjaxFactory ].
		self quasarSetupOnMountedContentOn: aJSStream with: anAjaxFactory ].
	aJSStream nextPutAll: '});'
]

{ #category : #'rendering - quasar hooks' }
QuasarApplication >> quasarSetupReturnCustomList: aList with: anAjaxFactory [
	"Subclasses may override"
]

{ #category : #'rendering - quasar' }
QuasarApplication >> quasarSetupReturnList: aJSStream with: anAjaxFactory [
	| list |

	list := OrderedCollection new.
	self reactiveObjects do: [ :eachObject | eachObject quasarSetupReturnList: list with: anAjaxFactory ].
	self quasarSetupReturnCustomList: list with: anAjaxFactory.

	aJSStream nextPutAll: 'return {'.
	list
		do: [ :each | aJSStream nextPutAll: each ]
		separatedBy: [ aJSStream nextPut: $, ].
	aJSStream nextPutAll: '}'
]

{ #category : #accessing }
QuasarApplication >> quasarVersion [

	^ quasarVersion
]

{ #category : #accessing }
QuasarApplication >> quasarVersion: anObject [

	quasarVersion := anObject
]

{ #category : #accessing }
QuasarApplication >> quasarVersionLazy [

	self quasarVersion ifNil: [ self quasarVersion: '2.14.0' ].

	^ self quasarVersion
]

{ #category : #accessing }
QuasarApplication >> reactiveObjects [

	^ reactiveObjects
]

{ #category : #accessing }
QuasarApplication >> reactiveObjects: anObject [

	reactiveObjects := anObject
]

{ #category : #accessing }
QuasarApplication >> reactiveObjectsAddIfAbsent: anObject [

	self reactiveObjects at: anObject refName ifAbsentPut: [ anObject ]
]

{ #category : #accessing }
QuasarApplication >> reactiveObjectsAt: aRefName ifAbsentPut: aBlock [

	^ self reactiveObjects at: aRefName ifAbsentPut: aBlock
]

{ #category : #accessing }
QuasarApplication >> reactiveObjectsClear [

	self reactiveObjects: OrderedDictionary new
]

{ #category : #accessing }
QuasarApplication >> reactiveObjectsRemoveAt: aRefName [

	^ self reactiveObjects removeKey: aRefName ifAbsent: []
]

{ #category : #actions }
QuasarApplication >> redirect [
	"we need to build the url we redirect to because we just expired the session in this test"
	| url |
	url := self application url.
	url addAllToPath: self requestContext consumer upToEnd.
	^ self requestContext redirectTo: url
]

{ #category : #rendering }
QuasarApplication >> renderContentOn: html [

	self renderLayoutOn: html.
	self renderQuasarScriptsOn: html
]

{ #category : #rendering }
QuasarApplication >> renderLayoutOn: html [

	self subclassResponsibility
]

{ #category : #rendering }
QuasarApplication >> renderQuasarScriptsOn: html [
	| jsStream |

	html script "async;" url: self vueJsUrl.
	html script "async;" url: self quasarJsUrl.
	"html script with: JSFetch jsFetchJs."
	"html script url: 'https://cdn.jsdelivr.net/npm/quasar@v2/dist/icon-set/fontawesome-v6.umd.prod.js'.
	html script with: 'Quasar.iconSet.set(Quasar.iconSet.fontawesomeV6)'."
	"html script url: 'https://cdn.jsdelivr.net/npm/quasar@v2/dist/icon-set/material-symbols-sharp.umd.prod.js'.
	html script with: 'Quasar.iconSet.set(Quasar.iconSet.materialSymbolsSharp)'."
	self needsMarkdown ifTrue: [
		html script url: self quasarMarkdownJsUrl ].

	jsStream := JSStream new.
	self quasarAppMountOn: jsStream with: html qAjax.
	html script with: jsStream
]

{ #category : #rendering }
QuasarApplication >> renderSetColorTheme: aColorTheme on: html [

	aColorTheme ifNil: [ ^ self ].

	aColorTheme colors ifNotNil: [ :colors | | stream |
		stream := WriteStream on: String new.
		stream nextPutAll: 'var bodyStyle = document.querySelector(":root").style;'.
		colors keysAndValuesDo: [ :eachKey :eachValue |
			stream
				nextPutAll: 'bodyStyle.setProperty("--q-', eachKey, '", "', eachValue "asHexString", '");';
				yourself ].
		stream nextPutAll: 'document.getElementsByTagName("body")[0].style.fontFamily = "Dancing Script";'.

		html script: stream contents ]
]

{ #category : #updating }
QuasarApplication >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.

	self updateRootFonts: anHtmlRoot.
	self updateRootQuasarCss: anHtmlRoot.

	anHtmlRoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1.0, shrink-to-fit=no'.
	anHtmlRoot style: '[v-cloak]{display:none}'.
	self faviconUrl ifNotNil: [ :value | anHtmlRoot link beShortcutIcon; url: value ].
	anHtmlRoot title: self applicationTitle.
	anHtmlRoot beHtml5
]

{ #category : #updating }
QuasarApplication >> updateRootFonts: anHtmlRoot [

	anHtmlRoot stylesheet
		url: 'https://fonts.googleapis.com/css?family=Roboto+Flex|Material+Icons|Material+Icons+Outlined'
]

{ #category : #updating }
QuasarApplication >> updateRootQuasarCss: anHtmlRoot [

	anHtmlRoot stylesheet url: self quasarCssUrl.
	self needsMarkdown ifTrue: [
		anHtmlRoot stylesheet url: self quasarMarkdownCssUrl ]
]

{ #category : #'accessing - view style' }
QuasarApplication >> viewStyleDense [

	^ false
]

{ #category : #'accessing - view style' }
QuasarApplication >> viewStyleFilled [

	^ false
]

{ #category : #'accessing - view style' }
QuasarApplication >> viewStyleOutlined [

	^ false
]

{ #category : #accessing }
QuasarApplication >> vueJsUrl [

	^ 'https://cdn.jsdelivr.net/npm/vue@3/dist/vue.global.prod.js'
]

{ #category : #accessing }
QuasarApplication >> vueRefsSet: anAssociation [
	"Create a ref object at the association key, if none present.
	Set the ref object's value to the association value."

	anAssociation key ifNil: [ self error: 'Ref name cannot be nil' ].

	self reactiveObjects
		at: anAssociation key
		ifPresent: [ :ref | ref refValue: anAssociation value ]
		ifAbsentPut: [ QuasarRefClientOnly name: anAssociation key value: anAssociation value ]
]
