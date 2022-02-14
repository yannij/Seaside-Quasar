Class {
	#name : #QShrineCanvas,
	#superclass : #QuasarComponent,
	#instVars : [
		'products'
	],
	#category : #'Quasar-Material-Shrine'
}

{ #category : #actions }
QShrineCanvas >> addToShoppingCart: aProduct [

	self mdqApplicationGet ifNotNil: [ :app |
		app stripeInterface shoppingCart: app shoppingCart addProduct: aProduct ]
]

{ #category : #accessing }
QShrineCanvas >> products [

	products ifNil: [
		products := self productsBuild ].

	^ products
]

{ #category : #accessing }
QShrineCanvas >> products: anObject [

	products := anObject
]

{ #category : #rendering }
QShrineCanvas >> productsBuild [

	^ (WAJsonParser parse: self productsJson) collect: [ :each |
		| number |
		number := 10000 atRandom.
		each at: 'price' put: number / 100.0.
		each at: 'priceAmount' put: number.
		each at: 'priceCurrency' put: 'cad'.
		each ]
]

{ #category : #rendering }
QShrineCanvas >> productsFiltered [
	| categoryValue |

	categoryValue := self mdqApplicationGet category.

	^ self products select: [ :eachProduct |
		(eachProduct at: 'tags') includes: categoryValue ]
]

{ #category : #rendering }
QShrineCanvas >> productsJson [

	^ '[
{"id": "prod_1", "tags":["Accessories"], "description": "Ginger scarf",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/ginger-scarf.jpg"]},
{"id": "prod_2", "tags":["Apartment", "Featured"], "description": "Blue stone mug",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/blue-stone-mug.jpg"]},
{"id": "prod_3", "tags":["Tops"], "description": "Cerise scallop tee",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/cerise-scallop.jpg"]},
{"id": "prod_4", "tags":["Apartment", "Featured"], "description": "Chambray napkins",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/chambray-napkins.jpg"]},
{"id": "prod_5", "tags":["Tops"], "description": "Fine lines tee",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/fine-lines.jpg"]},
{"id": "prod_6", "tags":["Accessories", "Featured"], "description": "Garden strand",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/garden-strand.jpg"]},
{"id": "prod_7", "tags":["Accessories"], "description": "Gatsby hat",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/gatsby-hat.jpg"]},
{"id": "prod_8", "tags":["Apartment"], "description": "Gilt desk trio",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/gilt-desk-trio.jpg"]},
{"id": "prod_9", "tags":["Apartment"], "description": "Kitchen quattro",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/kitchen-quattro.jpg"]},
{"id": "prod_10", "tags":["Tops"], "description": "Seabreeze sweater",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/seabreeze-sweater.jpg"]},
{"id": "prod_11", "tags":["Accessories"], "description": "Shrug bag",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/shrug-bag.jpg"]},
{"id": "prod_12", "tags":["Accessories"], "description": "Stella sunglasses",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/stella-sunglasses.jpg"]},
{"id": "prod_13", "tags":["Tops"], "description": "Surf and perf shirt",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/surf-and-perf.jpg"]},
{"id": "prod_14", "tags":["Accessories"], "description": "Vagabond sack",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/vagabond-sack.jpg"]},
{"id": "prod_15", "tags":["Tops"], "description": "Walter henley (white)",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/walter-henley.jpg"]},
{"id": "prod_16", "tags":["Accessories"], "description": "Weave keyring",
 "images": ["https://raw.githubusercontent.com/material-components/material-components-web-codelabs/master/mdc-101/complete/assets/weave-keyring.jpg"]}
]'
]

{ #category : #rendering }
QShrineCanvas >> renderContentOn: html [

	self renderProductsOn: html

]

{ #category : #rendering }
QShrineCanvas >> renderProduct: aProduct on: html [
	| imageUrl productName productPrice |

	imageUrl := (aProduct at: 'images') first.
	productName := aProduct at: 'description'.
	productPrice := aProduct at: 'price'.

	html qCard flat; with: [
		html qImg src: imageUrl; with: [
			html div class: 'absolute-top-left'; class: 'no-padding'; with: [
				html qBtn flat; class: 'q-pa-sm';
					icon: 'add_shopping_cart';
					type: 'a';
					href: (html urlForAction: [ self addToShoppingCart: aProduct ]) ] ].
		html qCardSection with: [
			html div class: 'text-subtitle2 text-center'; with: productName.
			html div class: 'text-subtitle2 text-center'; with: '$', productPrice greaseString ] ]
]

{ #category : #rendering }
QShrineCanvas >> renderProductsOn: html [

	html div class: 'row'; class: 'q-pa-md'; class: 'q-col-gutter-md'; with: [
		self productsFiltered do: [ :eachProduct |
			html div class: 'col-xs-6 col-sm-4 col-md-3 col-lg-2 col-xl-2'; with: [
				self renderProduct: eachProduct on: html ] ] ]
]
