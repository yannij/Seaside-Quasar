Class {
	#name : 'QuasarDemoMovieListingApp',
	#superclass : 'QuasarDemoApp',
	#instVars : [
		'repository',
		'tab',
		'model',
		'modelView'
	],
	#category : 'Quasar-Demo-Movies',
	#package : 'Quasar-Demo',
	#tag : 'Movies'
}

{ #category : 'class initialization' }
QuasarDemoMovieListingApp class >> applicationPath [

	^ 'quasar/movies'
]

{ #category : 'demo data' }
QuasarDemoMovieListingApp class >> createData [
	"
	self createData
	"
	| repo |

	self repositoryClass mapReset.
	self repositoryClass mapCreateAt: self soilPath.

	repo := self movieRepository.
	self createDemoMovieIn: repo.
	self createDemoTheatreIn: repo.
	self createDemoShowTimeIn: repo
]

{ #category : 'demo data' }
QuasarDemoMovieListingApp class >> createDemoMovieIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoMoviesMovie.
	aRepository removeAll: modelClass.

	#(
	(1 'Aquaman and the Lost Kingdom' 'PG' 6 115 'Action, Adventure, Fantasy')
	(2 'Migration' 'G' 6 91 'Adventure, Animation, Comedy')
	(3 'Rewind' 'PG' 10 112 'Drama, Romance')
	(4 'Wonka' 'PG' 8 116 'Adventure, Fantasy, Comedy')
	) do: [ :data | | newObject |
		newObject := modelClass new
			id: (data at: 1);
			name: (data at: 2);
			classification: (data at: 3);
			rating: (data at: 4);
			duration: (data at: 5);
			tags: (data at: 6);
			yourself.
		aRepository save: newObject ]
]

{ #category : 'demo data' }
QuasarDemoMovieListingApp class >> createDemoShowTimeIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoMoviesShowTime.
	aRepository removeAll: modelClass.

	#(
	(110 1 1 0 '1:40pm')
	(111 1 1 0 '3:40pm')
	(120 1 2 0 '1:30pm')
	(121 1 2 0 '4:20pm')
	(140 1 4 0 '1:40pm')
	(141 1 4 0 '3:50pm')
	(142 1 4 0 '6:30pm')
	(143 1 4 0 '9:20pm')

	(210 2 1 0 '12:00pm')
	(211 2 1 0 '3:00pm')
	(230 2 3 0 '11:20am')
	(231 2 3 0 '2:00pm')
	(232 2 3 0 '4:40pm')
	(233 2 3 0 '7:20pm')
	(234 2 3 0 '10:00pm')
	(240 2 4 0 '11:30am')
	(241 2 4 0 '2:10pm')
	(242 2 4 0 '4:50pm')
	(243 2 4 0 '7:30pm')
	(244 2 4 0 '10:10pm')
	) do: [ :data | | newObject |
		newObject := modelClass new
			id: (data at: 1);
			theatreId: (data at: 2);
			movieId: (data at: 3);
			showDate: (Date today addDays: (data at: 4));
			showStartTime: (Time fromString: '11:20am');
			yourself.
		aRepository save: newObject ]
]

{ #category : 'demo data' }
QuasarDemoMovieListingApp class >> createDemoTheatreIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoMoviesTheatre.
	aRepository removeAll: modelClass.

	#(
	(1 'Cinemas Fairview Mall' '1800 Sheppard Ave. E, Toronto, ON M2J 5A7' '416-888-7746')
	(2 'Cinemas Vaughan' '3555 Hwy. 7 W, Vaughan, ON L4L 6B1' '905-888-1001')
	) do: [ :data | | newObject |
		newObject := modelClass new
			id: (data at: 1);
			name: (data at: 2);
			address: (data at: 3);
			phone: (data at: 4);
			yourself.
		aRepository save: newObject ]
]

{ #category : 'class initialization' }
QuasarDemoMovieListingApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : 'demo data' }
QuasarDemoMovieListingApp class >> movieRepository [

	^ self repositoryClass
		mapAt: self soilPath
		ifAbsent: [ (self repositoryClass onPath: self soilPath) open; yourself ]
]

{ #category : 'demo data' }
QuasarDemoMovieListingApp class >> movieRepositoryCreate [

	^ self repositoryClass mapCreateAt: self soilPath
]

{ #category : 'demo data' }
QuasarDemoMovieListingApp class >> repositoryClass [
	"
	self createData
	"

	^ QuasarDemoSoilRepository
]

{ #category : 'demo data' }
QuasarDemoMovieListingApp class >> soilPath [

	^ 'demo-movies'
]

{ #category : 'rendering - table' }
QuasarDemoMovieListingApp >> addCols: aList modelClass: aClass [
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

{ #category : 'rendering - table' }
QuasarDemoMovieListingApp >> addRows: aList modelClass: aClass on: html [
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

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> applicationTitle [

	^ 'Movies'
]

{ #category : 'initialization' }
QuasarDemoMovieListingApp >> initialize [

	super initialize.

	self repositorySetup.
	self tab: self tabTheatre
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> model [

	^ model
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> model: anObject [

	model := anObject
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> modelSet: anObject [

	self model: anObject.
	anObject
		ifNil: [ self modelView: nil ]
		ifNotNil: [ self modelView: (anObject viewClass on: anObject) ]
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> modelView [

	^ modelView
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> modelView: anObject [

	modelView := anObject
]

{ #category : 'rendering - quasar hooks' }
QuasarDemoMovieListingApp >> quasarConfigContentOn: aJSStream with: html [

	aJSStream nextPutAll: '
brand: {
	primary: ''#E5E488''
}'
	"aJSStream nextPutAll: '
brand: {
	primary: ''#E5E4FA'',
	secondary: ''#e30425'',
	accent: ''#9C27B0'',
	dark: ''#1d1d1d'',
	positive: ''#21BA45'',
	negative: ''#C10015'',
	info: ''#31CCEC'',
	warning: ''#F2C037''
}'"
]

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> renderItemChoiceOn: html [

	html qTabs
		vModel: self tab;
		with: [
			html qRouteTab label: 'Theatre'; href: (html urlForAction: [ self tabSet: self tabTheatre ]).
			html qRouteTab label: 'Movie'; href: (html urlForAction: [ self tabSet: self tabMovie ]).
			html qRouteTab label: 'Show Time'; href: (html urlForAction: [ self tabSet: self tabShowTime ]) ]
]

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> renderItemListOn: html [

	self tab = self tabTheatre ifTrue: [
		self renderTheatreOn: html ].

	self tab = self tabMovie ifTrue: [
		self renderMovieOn: html ].

	self tab = self tabShowTime ifTrue: [
		self renderShowTimeOn: html ].
]

{ #category : 'rendering - quasar hooks' }
QuasarDemoMovieListingApp >> renderLayoutOn: html [

	self model ifNil: [
		self modelSet: (self repository selectAll: QuasarDemoMoviesTheatre) any ].

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; vCloak; with: [
			html qHeader heightHint: 98; class: 'bg-primary'; style: 'color: black'; with: [
				html qToolbar with: [
					self renderItemChoiceOn: html ] ].
			self renderLayoutPageOn: html ] ]
]

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage with: [
			self renderModelOn: html.
			html qSeparator.
			self renderItemListOn: html ] ]
]

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> renderModelList: aList on: html [

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

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> renderModelOn: html [

	self modelView isNil ifTrue: [
		^ html heading level2; with: 'No model selected' ].

	html render: self modelView
]

{ #category : 'rendering - table' }
QuasarDemoMovieListingApp >> renderModelTable: aList modelClass: aClass title: aTitleString on: html [

	html qTable
		class: 'q-mt-sm';
		title: aTitleString;
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

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> renderMovieOn: html [

	self tab = self tabMovie ifFalse: [ ^ self ].

	self
		renderModelList: (self repository selectAll: QuasarDemoMoviesMovie)
		on: html
]

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> renderShowTimeOn: html [

	self tab = self tabShowTime ifFalse: [ ^ self ].

	self
		renderModelList: (self repository selectAll: QuasarDemoMoviesShowTime)
		on: html
]

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> renderTheatreOn: html [

	self tab = self tabTheatre ifFalse: [ ^ self ].

	self
		renderModelList: (self repository selectAll: QuasarDemoMoviesTheatre)
		on: html
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> repository [

	^ repository
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> repository: anObject [

	repository := anObject
]

{ #category : 'rendering - quasar hooks' }
QuasarDemoMovieListingApp >> repositorySetup [

	self repository: self class movieRepository
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> tab [

	^ tab
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> tab: anObject [

	tab := anObject
]

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> tabMovie [

	^ #movie
]

{ #category : 'accessing' }
QuasarDemoMovieListingApp >> tabSet: anObject [

	self tab: anObject.
	"self modelSet: nil"
]

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> tabShowTime [

	^ #showTime
]

{ #category : 'rendering' }
QuasarDemoMovieListingApp >> tabTheatre [

	^ #theatre
]
