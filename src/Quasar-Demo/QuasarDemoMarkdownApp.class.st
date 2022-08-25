Class {
	#name : #QuasarDemoMarkdownApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'markdown1'
	],
	#category : #'Quasar-Demo-Basic'
}

{ #category : #initialization }
QuasarDemoMarkdownApp class >> applicationPath [

	^ 'quasar/markdown'
]

{ #category : #initialization }
QuasarDemoMarkdownApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QuasarDemoMarkdownApp >> applicationTitle [

	^ 'Markdown'
]

{ #category : #initialization }
QuasarDemoMarkdownApp >> initialize [

	super initialize.

	self markdown1: (QuasarReactiveRefCallback name: 'markdown1' value: self markdown1Default).
	self reactiveObjectsAdd: self markdown1
]

{ #category : #accessing }
QuasarDemoMarkdownApp >> markdown1 [

	^ markdown1
]

{ #category : #accessing }
QuasarDemoMarkdownApp >> markdown1: anObject [

	markdown1 := anObject
]

{ #category : #initialization }
QuasarDemoMarkdownApp >> markdown1Default [

	^ '**This is bold text**

__This is bold text, second way__

*This is italic text*

_This is italic text, second way_

**_This is bold italic text_**

___This is bold italic text, second way___

~~This is Strikethrough~~
'
]

{ #category : #'rendering - quasar hooks' }
QuasarDemoMarkdownApp >> quasarSetupReturnContentOn: aJSStream with: html [
	| exports |

	exports := ',' join: (self quasarData, (self vueRefs keys)).
	exports ifNotEmpty: [
		aJSStream nextPutAll: exports ]
]

{ #category : #rendering }
QuasarDemoMarkdownApp >> renderAppOn: html [

	html qLayout view: 'hHh lpR fFf'; with: [
		html qHeader elevated; heightHint: 98; class: 'bg-primary text-white'; with: [
			html qToolbar with: [
				html qToolbarTitle with: [
					html text: 'Markdown example' ] ] ].
		html qPageContainer with: [
			self renderMarkdownOn: html ] ]
]

{ #category : #rendering }
QuasarDemoMarkdownApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		self renderAppOn: html ]
]

{ #category : #rendering }
QuasarDemoMarkdownApp >> renderMarkdown: modelName splitter: splitterName on: html [

	html div class: 'q-py-sm fit'; with: [
		html qSplitter vModel: splitterName; with: [
			html qTemplate vSlot: 'separator'; with: [
				html qAvatar color: 'primary'; textColor: 'white'; size: '28px'; icon: 'adjust' ].
			html qTemplate vSlot: 'before'; with: [
				html div class: 'q-pr-md'; with: [ | textareaTag |
					textareaTag := html textArea.
					textareaTag attributes removeKey: 'rows' ifAbsent: [  ].
					textareaTag attributes removeKey: 'coloumns' ifAbsent: [  ].
					textareaTag
						vModel: modelName;
						vBind: 'rows' with: 20;
						class: 'fit q-pa-sm' ] ].
			html qTemplate vSlot: 'after'; with: [
				html div class: 'q-pl-md'; style: 'max-height: 467px;'; with: [
					html qMarkdown
						vModel: modelName colon: 'src';
						class: 'fit bordered q-pr-xs' ] ] ] ]
]

{ #category : #rendering }
QuasarDemoMarkdownApp >> renderMarkdown: modelName splitter: splitterName readonly: flag on: html [

	html div class: 'q-py-sm fit'; with: [
		html qSplitter vModel: splitterName; with: [
			html qTemplate vSlot: 'separator'; with: [
				html qAvatar color: 'primary'; textColor: 'white'; size: '28px'; icon: 'adjust' ].
			html qTemplate vSlot: 'before'; with: [
				html div class: 'q-pr-md'; with: [ | textareaTag |
					textareaTag := html textArea.
					textareaTag attributes removeKey: 'rows' ifAbsent: [  ].
					textareaTag attributes removeKey: 'coloumns' ifAbsent: [  ].
					textareaTag
						readonly: flag;
						vModel: modelName;
						vBind: 'rows' with: 20;
						class: 'fit q-pa-sm' ] ].
			html qTemplate vSlot: 'after'; with: [
				html div class: 'q-pl-md'; style: 'max-height: 467px;'; with: [
					html qMarkdown
						vModel: modelName colon: 'src';
						class: 'fit bordered q-pr-xs' ] ] ] ]
]

{ #category : #rendering }
QuasarDemoMarkdownApp >> renderMarkdownOn: html [
	| app modelName splitterName |

	app := self mdqApplicationGet.
	modelName := self markdown1 refName.
	splitterName := modelName, 'Splitter'.
	app vueRefsAdd: splitterName -> 50.

	html qInput stackLabel; filled; type: 'textarea';
		label: 'Markdown 1'; inputStyle: 'display: none';
		vModel: modelName; name: 'foobar';
		with: [
			html qTemplate vSlot: 'default'; with: [
				self renderMarkdown: modelName splitter: splitterName readonly: false on: html ] ]
]
