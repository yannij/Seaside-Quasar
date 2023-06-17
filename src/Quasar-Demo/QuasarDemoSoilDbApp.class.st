Class {
	#name : #QuasarDemoSoilDbApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'username',
		'tab',
		'sideSheet',
		'sideSheetOpen',
		'model',
		'modelView'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #initialization }
QuasarDemoSoilDbApp class >> applicationPath [

	^ 'quasar/accounting-soil'
]

{ #category : #initialization }
QuasarDemoSoilDbApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #'rendering-table' }
QuasarDemoSoilDbApp >> addCols: aList modelClass: aClass [
	| refName data |

	refName := aClass modelName, 'Cols'.
	data := OrderedCollection new.
	data add: (Dictionary new
				at: 'name' put: 'actions';
				at: 'label' put: 'Actions';
				at: 'field' put: (JSStream on: 'row => row.actions');
				at: 'align' put: 'left';
				yourself).

	aClass attributeData do: [ :each | | columnData |
		columnData := Dictionary new
				at: 'name' put: each;
				at: 'label' put: each capitalized;
				at: 'field' put: each;
				"at: 'sortable' put: true;"
				at: 'align' put: 'left';
				yourself.
		data add: columnData ].

	self qdemoApp vueRefsSet: refName -> data.
	^ refName
]

{ #category : #'rendering-table' }
QuasarDemoSoilDbApp >> addRows: aList modelClass: aClass on: html [
	| refName data |

	refName := aClass modelName, 'Rows'.
	data := OrderedCollection new.
	aList do: [ :eachItem | | map actions |
		map := eachItem asMap.

		actions := OrderedCollection new.
		actions add: ({'id' -> 'nav'. 'icon' -> 'arrow_forward'. 'href' -> (html urlForAction: [ self modelSet: eachItem ]) } asDictionary).
		map at: 'actions' put: actions.

		data add: map ].

	self qdemoApp vueRefsSet: refName -> data.
	^ refName
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> applicationTitle [

	^ 'Accounting-SoilDb'
]

{ #category : #initialization }
QuasarDemoSoilDbApp >> initialize [

	super initialize.

	self sideSheetOpen: ((QuasarRefCallback name: 'sideSheetOpen' value: true) traceOn; yourself).
	self reactiveObjectsAddIfAbsent: self sideSheetOpen.
	self sideSheet: QuasarDemoSideSheet new.
	self tab: 'users'
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> model [

	^ model
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> model: anObject [

	model := anObject
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> modelSet: anObject [

	self model: anObject.
	anObject
		ifNil: [ self modelView: nil ]
		ifNotNil: [ self modelView: (anObject viewClass on: anObject) ]
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> modelView [

	^ modelView
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> modelView: anObject [

	modelView := anObject
]

{ #category : #'rendering - quasar hooks' }
QuasarDemoSoilDbApp >> quasarConfigContentOn: aJSStream with: html [

	aJSStream nextPutAll: '
brand: {
	primary: ''#E5E4FA'',
	secondary: ''#e30425'',
	accent: ''#9C27B0'',
	dark: ''#1d1d1d'',
	positive: ''#21BA45'',
	negative: ''#C10015'',
	info: ''#31CCEC'',
	warning: ''#F2C037''
}'
]

{ #category : #rendering }
QuasarDemoSoilDbApp >> renderAccountsOn: html [

	self tab = 'accounts' ifFalse: [ ^ self ].

	self renderModelList: QuasarDemoAccountingAccount instanceList on: html
]

{ #category : #rendering }
QuasarDemoSoilDbApp >> renderCompaniesOn: html [

	self tab = 'companies' ifFalse: [ ^ self ].

	self renderModelList: QuasarDemoAccountingCompany instanceList on: html
]

{ #category : #rendering }
QuasarDemoSoilDbApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; vCloak; with: [
			html qHeader heightHint: 98; class: 'bg-primary'; style: 'color: black'; with: [
				html qToolbar with: [
					"html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'.".
					self renderTabsOn: html.
					html qSpace.
					html qBtn flat; round; icon: 'view_sidebar'; vOnClick: 'this.$refs.sideSheet.toggle($event)' ] ].
			self renderLayoutPageOn: html.
			html render: self sideSheet ] ]
]

{ #category : #rendering }
QuasarDemoSoilDbApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage with: [
			self renderModelOn: html ] ]
]

{ #category : #rendering }
QuasarDemoSoilDbApp >> renderModelList: aList on: html [

	html qList style: 'background: white'; with: [
		aList do: [ :eachObject |
			html qItem qTag: 'a'; href: (html urlForAction: [ self modelSet: eachObject ]); with: [
				html qItemSection top; avatar; with: [
					html qAvatar color: 'primary'; textColor: 'white'; icon: 'star' ].
				html qItemSection with: [
					html qItemLabel with: eachObject name.
					html qItemLabel caption; "lines: 2;"
						with: eachObject summaryString ].
				"html qItemSection with: [
					html qItemLabel style: 'color: red'; with: eachObject price ]" ] ] ]
]

{ #category : #rendering }
QuasarDemoSoilDbApp >> renderModelOn: html [

	self modelView isNil ifTrue: [
		^ html heading level2; with: 'No model selected' ].

	html render: self modelView
]

{ #category : #'rendering-table' }
QuasarDemoSoilDbApp >> renderModelTable: aList modelClass: aClass on: html [

	html qTable "title: 'a-title';"
		flat; bordered;
		columns: (self addCols: aList modelClass: aClass);
		rows: (self addRows: aList modelClass: aClass on: html);
		vBind: 'pagination' with: '{rowsPerPage: 10}';
		rowKey: 'name';
		with: [
			html qTemplate vSlot: 'body-cell-actions' with: 'props'; with: [
				html qTd vBind: 'props' with: 'props'; with: [
					html qBtn
						round; outline; color: 'primary';
						vFor: 'actions in props.value';
						vBind: 'key' with: 'actions.id';
						vBind: 'icon' with: 'actions.icon';
						vBind: 'href' with: 'actions.href' ] ] ]
]

{ #category : #rendering }
QuasarDemoSoilDbApp >> renderTabPanelsOn: html [

	html qTabPanels "vModel: 'tab';" modelValue: self tab; animated; with: [
		html qTabPanel name: 'companies'; class: 'q-pa-none'; with: [ self renderCompaniesOn: html ].
		html qTabPanel name: 'accounts'; class: 'q-pa-none'; with: [ self renderAccountsOn: html ].
		html qTabPanel name: 'users'; class: 'q-pa-none'; with: [ self renderUsersOn: html ] ]
]

{ #category : #rendering }
QuasarDemoSoilDbApp >> renderTabsOn: html [

	html qTabs
		vModel: self tab;
		with: [
			html qRouteTab label: 'Companies'; href: (html urlForAction: [ self tabSet: 'companies' ]).
			html qRouteTab label: 'Accounts'; href: (html urlForAction: [ self tabSet: 'accounts' ]).
			html qRouteTab label: 'Users'; href: (html urlForAction: [ self tabSet: 'users' ]) ]
]

{ #category : #rendering }
QuasarDemoSoilDbApp >> renderUsersOn: html [

	self tab = 'users' ifFalse: [ ^ self ].

	self renderModelList: QuasarDemoAccountingUser instanceList on: html
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> sideSheet [

	^ sideSheet
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> sideSheet: anObject [

	sideSheet := anObject
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> sideSheetOpen [

	^ sideSheetOpen
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> sideSheetOpen: anObject [

	sideSheetOpen := anObject
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> tab [

	^ tab
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> tab: anObject [

	tab := anObject
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> tabSet: anObject [

	self tab: anObject.
	self modelSet: nil
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> username [

	^ username
]

{ #category : #accessing }
QuasarDemoSoilDbApp >> username: anObject [

	username := anObject
]
