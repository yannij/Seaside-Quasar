Class {
	#name : 'QuasarDemoHtmlTextApp',
	#superclass : 'QuasarApplication',
	#instVars : [
		'htmlText1'
	],
	#category : 'Quasar-Demo-Basic',
	#package : 'Quasar-Demo',
	#tag : 'Basic'
}

{ #category : 'initialization' }
QuasarDemoHtmlTextApp class >> applicationPath [

	^ 'quasar/htmltext'
]

{ #category : 'accessing' }
QuasarDemoHtmlTextApp class >> categoryName [

	^ #quasar
]

{ #category : 'initialization' }
QuasarDemoHtmlTextApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : 'accessing' }
QuasarDemoHtmlTextApp >> applicationTitle [

	^ 'Html text editor'
]

{ #category : 'accessing' }
QuasarDemoHtmlTextApp >> htmlText1 [

	^ htmlText1
]

{ #category : 'accessing' }
QuasarDemoHtmlTextApp >> htmlText1: anObject [

	htmlText1 := anObject
]

{ #category : 'initialization' }
QuasarDemoHtmlTextApp >> htmlText1Default [

	^ '<b>The</b> <i>quick</i> <strike>brown</strike> <u>fox</u> jumps over the lazy dog'
]

{ #category : 'initialization' }
QuasarDemoHtmlTextApp >> initialize [

	super initialize.

	self htmlText1: (QuasarRefCallback name: 'htmlText1' value: self htmlText1Default).
	self reactiveObjectsAddIfAbsent: self htmlText1
]

{ #category : 'rendering' }
QuasarDemoHtmlTextApp >> renderAppOn: html [

	html qLayout view: 'hHh lpR fFf'; with: [
		html qHeader elevated; heightHint: 98; class: 'bg-primary text-white'; with: [
			html qToolbar with: [
				html qToolbarTitle with: [
					html text: 'HtmlText example' ] ] ].
		html qPageContainer with: [
			self renderHtmlTextOn: html ] ]
]

{ #category : 'rendering' }
QuasarDemoHtmlTextApp >> renderHtmlTextOn: html [
	| app modelName |

	app := self mdqApplicationGet.
	modelName := self htmlText1 refName.

	html qInput stackLabel; filled; type: 'textarea';
		label: 'HtmlText 1'; inputStyle: 'display: none';
		vModel: modelName; name: 'foobar';
		with: [
			html qTemplate vSlot: 'default'; with: [
				html div class: 'q-py-sm fit'; with: [
					html qEditor
						vBind: 'toolbar' with: self toolbarItems;
						name: modelName; vModel: modelName ] ] ]
]

{ #category : 'rendering' }
QuasarDemoHtmlTextApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		self renderAppOn: html ]
]

{ #category : 'rendering' }
QuasarDemoHtmlTextApp >> toolbarItems [

	^ '[
[''left'', ''center'', ''right'', ''justify''],
[''bold'', ''italic'', ''strike'', ''underline'', ''subscript'', ''superscript''],
[''token'', ''hr'', ''link'', ''custom_btn''],
[{
label: $q.lang.editor.formatting,
icon: $q.iconSet.editor.formatting,
list: ''no-icons'',
options: [''p'',''h1'',''h2'',''h3'',''h4'',''h5'',''h6'',''code'']}],
[''quote'', ''unordered'', ''ordered'', ''outdent'', ''indent''],
[''undo'', ''redo''],
[''print'', ''fullscreen''],
[''removeFormat'', ''viewsource'']
]'
]
