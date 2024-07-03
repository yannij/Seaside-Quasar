Extension { #name : 'WARenderer' }

{ #category : '*Quasar-Components' }
WARenderer >> urlForAction: aBlock absolute: aUrl [
	"Similar to urlForAction:, but any absolute url that might be present,
	is replaced with the url represented by aUrl. The feature is useful for
	generating callback url's for external services.

	Example:
		successUrl := html urlForAction: [ self actionSuccess ] absolute: (WAUrl absolute: 'https://foo.com:8000/seaside').
	"
	| actionUrl |

	actionUrl := self actionUrl.
	aUrl addAllToPath: actionUrl path.
	actionUrl
		scheme: aUrl scheme;
		host: aUrl host;
		port: aUrl port;
		path: aUrl path.
	^ actionUrl withField: (self callbacks store: (WAActionCallback on: aBlock))
]
