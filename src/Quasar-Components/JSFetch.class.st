"
I represent a Javascript Fetch API usage.

Currently a work in progress. The initial code was constructed by copying JQAjax and superclasses, then the code hierarchy was flattened to ""JSObject subclass: #JSFetch"".
"
Class {
	#name : #JSFetch,
	#superclass : #JSObject,
	#instVars : [
		'options',
		'callbackId',
		'callback'
	],
	#category : #'Quasar-Components'
}

{ #category : #'instance creation' }
JSFetch class >> context: aRenderContext rendererClass: aRendererClass [
	^ (self context: aRenderContext)
		rendererClass: aRendererClass;
		yourself
]

{ #category : #javascript }
JSFetch class >> jsFetchJs [
	"Javascript code to be deployed to support JSFetch"

	^ '
async function jsFetch(arg){
let url = arg.url + "?" + arg.data;
let options = {method: "GET",headers: {"Content-Type": "application/json"}};
let onOk = (response)=>{if (!response.ok){throw new Error("Network response was not OK");}return response.json();};
await fetch(url,options).then(onOk).then(arg.success).catch(arg.error)}'
]

{ #category : #parameters }
JSFetch >> addParameter: anObject [
	"Add the request parameter anObject, a single value or an association."

	self parameters add: anObject
]

{ #category : #parameters }
JSFetch >> addParameters: aCollection [
	"Add multiple request parameters from aCollection."

	self parameters addAll: aCollection associations
]

{ #category : #accessing }
JSFetch >> arguments [
	^ options isNil
		ifTrue: [ Array new ]
		ifFalse: [ Array with: options ]
]

{ #category : #options }
JSFetch >> async: aBoolean [
	"By default, all requests are sent asynchronous (i.e. this is set to true by default). If you need synchronous requests, set this option to false. Note that synchronous requests may temporarily lock the browser, disabling any actions while the request is active."
	
	self optionAt: 'async' put: aBoolean
]

{ #category : #options }
JSFetch >> cache: aBoolean [
	"If set to false it will force the pages that you request to not be cached by the browser."
	
	self optionAt: 'cache' put: aBoolean
]

{ #category : #callbacks }
JSFetch >> callback: aBlock [
	"Register aBlock as a primary callback of the receiver. It is only possible to have a single primary callback registered per instance. The primary callback must generate a response."

	self enableCallbacks.
	callback := aBlock
]

{ #category : #callbacks }
JSFetch >> callback: aBlock json: anObject [
	"Register aBlock as a secondary callback. anObject is a reference to a Javascript object on the client-side. anObject will be serialized to a JSON string, sent back to the server, deserialized from JSON to nested Smalltalk objects, and result passed into aBlock."

	self
		callback: [ :value | aBlock value: (WAJsonParser parse: value) ]
		value: (JSStream on: 'JSON.stringify(', anObject, ')')
]

{ #category : #callbacks }
JSFetch >> callback: aBlock value: anObject [
	"Register aBlock as a secondary callback. anObject is a reference to a Javascript object on the client-side. The object will be sent back to the server as a string and passed into aBlock. Multiple secondary callbacks can be defined with one receiver.

Note: anObject should be a single literal Javascript object (String, Number, Boolean). The object is transfered from client to server as the print-string of the object and passed into the callback block as a Smalltalk String."

	self enableCallbacks.
	self addParameter: (self renderContext callbacks
		store: (WAValueCallback on: aBlock)) 
			-> anObject
]

{ #category : #options }
JSFetch >> contentType: aString [
	"When sending data to the server, use this content-type. Default is 'application/x-www-form-urlencoded', which is fine for most cases. If you explicitly pass in a content-type to $.ajax() then it'll always be sent to the server (even if no data is sent)."
	
	self optionAt: 'contentType' put: aString
]

{ #category : #options }
JSFetch >> context: anObject [
	"This object will be made the context of all Ajax-related callbacks. For example specifying a DOM element as the context will make that the context for the complete callback of a request, like so:"
	
	self optionAt: 'context' put: anObject
]

{ #category : #accessing }
JSFetch >> data [
	^ self options at: 'data' ifAbsentPut: [ JSJoin new ]
]

{ #category : #options }
JSFetch >> data: anObject [
	"Data to be sent to the server. It is converted to a query string, if not already a string. It's appended to the url for GET-requests. See processData option to prevent this automatic processing. Object must be Key/Value pairs. If value is an Array, jQuery serializes multiple values with same key i.e. {foo:['bar1', 'bar2']} becomes '&foo=bar1&foo=bar2'."
	
	self optionAt: 'data' put: anObject
]

{ #category : #options }
JSFetch >> dataFilter: anObject [
	"A function to be used to handle the raw responsed data of XMLHttpRequest.This is a pre-filtering function to sanitize the response.You should return the sanitized data.The function gets passed two arguments: The raw data returned from the server, and the 'dataType' parameter."
	
	self optionAt: 'dataFilter' put: (anObject asFunction return: true)
]

{ #category : #options }
JSFetch >> dataType: aString [
	"The type of data that you're expecting back from the server. If none is specified, jQuery will intelligently pass either responseXML or responseText to your success callback, based on the MIME type of the response. The available types (and the result passed as the first argument to your success callback) are:
	-	xml: Returns a XML document that can be processed via jQuery.
	-	html: Returns HTML as plain text; included script tags are evaluated when inserted in the DOM.
	-	script: Evaluates the response as JavaScript and returns it as plain text. Disables caching unless option 'cache' is used. Note: This will turn POSTs into GETs for remote-domain requests.
	-	json: Evaluates the response as JSON and returns a JavaScript Object.
	-	jsonp: Loads in a JSON block using JSONP. Will add an extra '?callback=?' to the end of your URL to specify the callback. (Added in jQuery 1.2)
	-	text: A plain text string."
	
	self optionAt: 'dataType' put: aString
]

{ #category : #private }
JSFetch >> enableCallbacks [
	self hasCallback ifTrue: [ ^ self ].
	self url: self renderContext actionUrl withoutQuery withoutFragment.
	self addParameters: self renderContext actionUrl queryFields.
	self addParameter: (callbackId := self renderContext callbacks
		store: (JSAjaxCallback on: [ self processCallback ]))
]

{ #category : #'accessing-urls' }
JSFetch >> fullUrl [
	"Answer a Seaside URL object that is composed with the parameters of the receiver. This method excludes dynamic Javascript objects that might be part of the parameters."
	
	| url |
	url := self url copy.
	self parameters do: [ :each | 
		(each isString)
			ifTrue: [ url addField: each ].
		((each isKindOf: Association) and: [ each value isJavascript not ])
			ifTrue: [ url addField: each key value: each value ] ].
	^ url
]

{ #category : #options }
JSFetch >> global: aBoolean [
	"Whether to trigger global Ajax event handlers for this request. The default is true. Set to false to prevent the global handlers like ajaxStart or ajaxStop from being triggered. This can be used to control various Ajax Events."
	
	self optionAt: 'global' put: aBoolean
]

{ #category : #private }
JSFetch >> hasCallback [
	^ callbackId notNil
]

{ #category : #callbacks }
JSFetch >> html: aRenderable [
	"Defines a html rendering callback."

	self notSupported.

	self dataType: 'html'.
	self respond: [ :response |
		response
			doNotCache;
			contentType: self application contentType.
		self render: aRenderable on: response stream ]
]

{ #category : #private }
JSFetch >> id: aString [
	"self owner id: aString"
]

{ #category : #options }
JSFetch >> ifModified: aBoolean [
	"Allow the request to be successful only if the response has changed since the last request. This is done by checking the Last-Modified header. Default value is false, ignoring the header. In jQuery 1.4 this technique also checks the 'etag' specified by the server to catch unmodified data."
	
	self optionAt: 'ifModified' put: aBoolean
]

{ #category : #options }
JSFetch >> isSupportedOption: aString [
	^ true
]

{ #category : #private }
JSFetch >> jQuery [
	^ (JQueryClass context: self renderContext)
		rendererClass: self rendererClass;
		yourself
]

{ #category : #printing }
JSFetch >> javascriptContentOn: aStream [

	aStream nextPutAll: 'await jsFetch'.
	JSStream encodeArguments: self arguments on: aStream
	"aStream nextPutAll: 'await jsFetch(', self javascriptUrl contents, ')'"
]

{ #category : #'accessing-urls' }
JSFetch >> javascriptUrl [
	"Answer a Javascript expression that evaluates to the URL with all parameters attached."

	| stream |
	stream := JSStream new.
	stream javascript: self url.
	self data collection isEmpty ifFalse: [
		stream nextPutAll: '+"'.
		stream nextPut: (self url queryFields isEmpty
			ifTrue: [ $? ] ifFalse: [ $& ]).
		stream nextPutAll: '"+'; javascript: self data ].
	^ stream
]

{ #category : #json }
JSFetch >> json: aRenderable [
	"Defines a json rendering callback."

	self dataType: 'json'.
	self respond: [ :response |
		response
			doNotCache;
			contentType: WAMimeType applicationJson;
			nextPutAll: ([ WAJsonCanvas builder render: aRenderable ] on: Error do: [ :ex | ex printString asJson ]) ]
			"nextPutAll: (WAJsonCanvas builder render: aRenderable) ]"
]

{ #category : #options }
JSFetch >> jsonp: aString [
	"Override the callback function name in a jsonp request. This value will be used instead of 'callback' in the 'callback=?' part of the query string in the url for a GET or the data for a POST. So {jsonp:'onJsonPLoad'} would result in 'onJsonPLoad=?' passed to the server."
	
	self optionAt: 'jsonp' put: aString
]

{ #category : #options }
JSFetch >> jsonpCallback: anObject [
	"Specify the callback function name for a jsonp request. This value will be used instead of the random name automatically generated by jQuery. It is preferable to let jQuery generate a unique name as it'll make it easier to manage the requests and provide callbacks and error handling. You may want to specify the callback when you want to enable better browser caching of GET requests."
	
	self optionAt: 'jsonpCallback' put: anObject asFunction
]

{ #category : #accessing }
JSFetch >> method [
	^ 'ajax'
]

{ #category : #callbacks }
JSFetch >> notSupported [
	"Raise error when unsupported JQAjax methods used. Support for the API methods are pending further thought"

	self error: 'JSFetch does not support this feature'
]

{ #category : #events }
JSFetch >> onBeforeSend: anObject [
	"A pre-callback to modify the XMLHttpRequest object before it is sent. Use this to set custom headers etc. The XMLHttpRequest is passed as the only argument."

	self notSupported.
	
	self optionAt: 'beforeSend' put: anObject asFunction
]

{ #category : #events }
JSFetch >> onComplete: anObject [
	"A function to be called when the request finishes (after success and error callbacks are executed). The function gets passed two arguments: The XMLHttpRequest object and a string describing the type of success of the request."
	
	self optionAt: 'complete' put: anObject asFunction
]

{ #category : #events }
JSFetch >> onError: anObject [
	"A function to be called if the request fails. The function is passed a single argumenbt: the error object itself."
	
	self optionAt: 'error' put: anObject asFunction
]

{ #category : #events }
JSFetch >> onSuccess: anObject [
	"A function to be called if the request succeeds. The function gets passed the data returned from the server, formatted according to the 'dataType' parameter."
	
	self optionAt: 'success' put: (anObject asFunction: #('data'))
]

{ #category : #events }
JSFetch >> onSuccessFunction [

	^ options isNil
		ifTrue: [ nil ]
		ifFalse: [ options at: 'success' ifAbsent: [ nil ] ]
]

{ #category : #options }
JSFetch >> optionAt: aKey put: aValue [
	^ (self isSupportedOption: aKey) 
		ifTrue: [ self options at: aKey put: aValue ]
		ifFalse: [ self error: 'The option ' , aKey printString , ' is not supported in ' , self class name , '. Either use #ajaxSetup to configure default values, or the more powerful version with #ajax.' ]
]

{ #category : #options }
JSFetch >> options [
	^ options ifNil: [ options := GRSmallDictionary2 new ]
]

{ #category : #parameters }
JSFetch >> parameters [
	"Answer the request parameters of the reciever."
	
	^ self data collection
]

{ #category : #options }
JSFetch >> password: aString [
	"A password to be used in response to an HTTP access authentication request."
	
	self optionAt: 'password' put: aString
]

{ #category : #private }
JSFetch >> processCallback [
	callback isNil
		ifFalse: [ callback value ]
]

{ #category : #options }
JSFetch >> processData: aBoolean [
	"By default, data passed in to the data option as an object (technically, anything other than a string) will be processed and transformed into a query string, fitting to the default content-type 'application/x-www-form-urlencoded'. If you want to send a DOMDocument, or other non-processed data, set this option to false."
	
	self optionAt: 'processData' put: aBoolean
]

{ #category : #callbacks }
JSFetch >> respond: aBlock [
	"Defines a response callback."

	self callback: [ self requestContext respond: aBlock ]
]

{ #category : #callbacks }
JSFetch >> script: aBlock [
	"Defines a script rendering callback."

	self notSupported.

	self dataType: 'script'.
	self respond: [ :response |
		response
			doNotCache; 
			contentType: (WAMimeType textJavascript
				charset: self requestContext handler charSet).
		self script: aBlock on: response stream ]
]

{ #category : #options }
JSFetch >> scriptCharset: aString [
	"Only for requests with 'jsonp' or 'script' dataType and 'GET' type. Forces the request to be interpreted as a certain charset. Only needed for charset differences between the remote and local content."
	
	self optionAt: 'scriptCharset' put: aString
]

{ #category : #convenience }
JSFetch >> serialize: aQuery [
	"Serializes a set of input elements matching aQuery and trigger the associated Seaside callbacks."

	self enableCallbacks.
	self addParameter: aQuery serialize
]

{ #category : #convenience }
JSFetch >> serializeChildren [
	"Serialize all input fields contained in the receiving element."
	
	self serializeChildren: self jQuery this
]

{ #category : #convenience }
JSFetch >> serializeChildren: aQuery [
	"Serialize all input fields being children of aQuery."

	self serialize: (aQuery find: ':input')
]

{ #category : #convenience }
JSFetch >> serializeFileUpload: aQuery [

	"Upload the file in the field identified by aQuery using FormData. Cannot be composed with any other callback."
	
	self
		data:
			((((JSStream on: 'var formdata = new FormData()'),
			 ((aQuery copy attributeAt: 'name') assignLocalTo: 'name'),
			 (((aQuery property: 0) access: 'files') assignLocalTo: 'files'),
			 (JSStream on:'for(i=0;i<files.length;i++) formdata.append(name,files[i])'),
			 (JSStream on: 'return formdata')) asFunction) apply: #());
		url: self renderContext actionUrl;
		type: 'POST';
		cache: false;
		processData: false;
		contentType: false
]

{ #category : #convenience }
JSFetch >> serializeForm [
	"Serialize all input fields of the form the receiving element is contained in."

	self serializeForm: self jQuery this
]

{ #category : #convenience }
JSFetch >> serializeForm: aQuery [
	"Serialize all input fields of the form matching aQuery."

	self serializeChildren: (aQuery closest: 'form')
]

{ #category : #convenience }
JSFetch >> serializeThis [
	"Serialize the receiving element. Note that this might not work for all form elements: (1) for check-boxes and multi-select lists Seaside internally depends on an additional hidden form element that is generated automatically, instead use #serializeThisWithHidden (2) submit-button callbacks are ignored, instead use a normal callback to trigger specific code evaluation."

	self serialize: self jQuery this
]

{ #category : #convenience }
JSFetch >> serializeThisWithHidden [
	"Serialize the receiving form element and a following hidden form element. This is required in case of a check-box or multi-select list."
	
	self serialize: (self jQuery this
		next: 'input:hidden';
		addBack)
]

{ #category : #convenience }
JSFetch >> serializeWithHidden: aQuery [
	"Serialize the receiving form element and a following hidden form element. This is required in case of a check-box or multi-select list."
	
	self serialize: (aQuery
		next: 'input:hidden';
		addBack)
]

{ #category : #callbacks }
JSFetch >> text: aBlock [
	"Defines a text rendering callback."

	self notSupported.

	self dataType: 'text'.
	self respond: [ :response |
		response
			doNotCache;
			contentType: (WAMimeType textPlain 
				charset: self requestContext handler charSet).
		aBlock value: response stream ]
]

{ #category : #options }
JSFetch >> timeout: anInteger [
	"Set a local timeout (in milliseconds) for the request. This will override the global timeout, if one is set via $.ajaxSetup. For example, you could use this property to give a single request a longer timeout than all other requests that you've set to time out in one second. See $.ajaxSetup() for global timeouts."
	
	self optionAt: 'timeout' put: anInteger
]

{ #category : #options }
JSFetch >> traditional: aBoolean [
	"Set this to true if you wish to use the traditional style of param serialization."
	
	self optionAt: 'traditional' put: aBoolean
]

{ #category : #options }
JSFetch >> type: aString [
	"The type of request to make ('POST' or 'GET'), default is 'GET'. Note: Other HTTP request methods, such as PUT and DELETE, can also be used here, but they are not supported by all browsers."
	
	self optionAt: 'type' put: aString asUppercase
]

{ #category : #accessing }
JSFetch >> url [
	^ self options at: 'url' ifAbsentPut: [ WAUrl new ]
]

{ #category : #options }
JSFetch >> url: aUrl [
	"A string containing the URL to which the request is sent."
	
	self optionAt: 'url' put: aUrl
]

{ #category : #options }
JSFetch >> username: aString [
	"A username to be used in response to an HTTP access authentication request."
	
	self optionAt: 'username' put: aString
]
