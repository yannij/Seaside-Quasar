Class {
	#name : #KeycloakHelloApp,
	#superclass : #QuasarApplication,
	#category : #'Quasar-Material-Keycloak'
}

{ #category : #initialization }
KeycloakHelloApp class >> applicationPath [

	^ 'quasar/keycloak-hello'
]

{ #category : #initialization }
KeycloakHelloApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ (self mdqRegisterDeployment: self applicationPath)
		"addLibrary: KeycloakHelloLibrary;"
		yourself
]

{ #category : #accessing }
KeycloakHelloApp >> applicationTitle [

	^ 'Keycloak Hello'
]

{ #category : #rendering }
KeycloakHelloApp >> keycloakInitJs [
	^ '
        keycloak.init({
            checkLoginIframe: false
        }).success(function(auth) {
            if (auth) {
                var name;
                if (keycloak.tokenParsed[''family_name''] || keycloak.tokenParsed[''given_name'']) {
                    name = keycloak.tokenParsed[''given_name''] + '' '' + keycloak.tokenParsed[''family_name'']
                } else {
                    name = keycloak.tokenParsed.preferred_username;
                }
                document.getElementById(''user-details'').innerHTML = name
            } else {
                console.info(''Not Authenticated'')
            }
        })
'
]

{ #category : #rendering }
KeycloakHelloApp >> keycloakVarJs [
	^ '
        var keycloak = new Keycloak({
            url: ''http://localhost:8080'',
            realm: ''myrealm'',
            clientId: ''hello''
        })
'
]

{ #category : #rendering }
KeycloakHelloApp >> renderAppOn: html [

	html qLayout view: 'hHh lpR fFf'; with: [
		html qHeader elevated; heightHint: 98; class: 'bg-primary text-white'; with: [
			html qToolbar with: [
				html qToolbarTitle with: [
					html text: 'Keycloak Example' ] ] ].
		html qPageContainer with: [
			html qPage with: [
				self renderKeycloakOn: html ] ] ]
]

{ #category : #rendering }
KeycloakHelloApp >> renderKeycloakOn: html [

	"html script url: (KeycloakHelloLibrary urlOf: #keycloakJs)."
	html script url: 'https://cdn.jsdelivr.net/npm/keycloak-js@17.0.1/dist/keycloak.min.js'.
	html script with: self keycloakVarJs.
	html document addLoadScript: (JSStream new nextPutAll: self keycloakInitJs; yourself).

	html qCard class: 'bg-secondary text-white'; style: 'width: 300px'; with: [
		html qCardSection with: [
			html div class: 'text-h6'; with: 'Login'.
			"html div class: 'text-subtitle2'; with: 'by John Doe'" ].
		html qCardSection with: [
			html html: 'Hello, <span id="user-details"></span>' ].
		html qSeparator dark.
		html qCardActions with: [
			html qBtn label: 'Sign in'; onClick: 'keycloak.login()'.
			html qBtn label: 'Sign out'; onClick: 'keycloak.logout()' ] ]
]

{ #category : #rendering }
KeycloakHelloApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		self renderAppOn: html ]
]
