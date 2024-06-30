Class {
	#name : 'KeycloakHelloBootstrapApp',
	#superclass : 'WAComponent',
	#category : 'Quasar-Material-Keycloak',
	#package : 'Quasar-Material',
	#tag : 'Keycloak'
}

{ #category : 'initialization' }
KeycloakHelloBootstrapApp class >> applicationPath [

	^ 'quasar/keycloak-hello-bootstrap'
]

{ #category : 'testing' }
KeycloakHelloBootstrapApp class >> canBeRoot [
	^ true
]

{ #category : 'initialization' }
KeycloakHelloBootstrapApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"
	| app |

	self environment at: #WADevelopmentConfiguration ifPresent: [ :class |
		WAAdmin applicationDefaults removeParent: WADevelopmentConfiguration instance ].

	app := WAAdmin register: self asApplicationAt: self applicationPath.
	"app addLibrary: KeycloakHelloLibrary"
]

{ #category : 'rendering' }
KeycloakHelloBootstrapApp >> appJsContent [
	^ 'function init() {
    document.getElementById(''config-form'').onsubmit = function() {
        updateConfig();
        return false;
    }

    var conf = loadConfig();

    if (conf.url && conf.realm && conf.client) {
        var keycloak = new Keycloak({
            url: conf.url,
            realm: conf.realm,
            clientId: conf.client
        });

        keycloak.init({
            checkLoginIframe: false
        }).success(function(auth) {
            document.getElementById(''login'').onclick = keycloak.login;
            document.getElementById(''logout'').onclick = keycloak.logout;

            show(''config-view'');
            hide(''config-edit'');

            if (auth) {
                var name;
                if (keycloak.tokenParsed[''family_name''] || keycloak.tokenParsed[''given_name'']) {
                    name = keycloak.tokenParsed[''given_name''] + '' '' + keycloak.tokenParsed[''family_name'']
                } else {
                    name = keycloak.tokenParsed.preferred_username;
                }
                document.getElementById(''user-details'').innerHTML = name;
                hide(''login'');
                show(''logout'')
                show(''display-user'');

            } else {
                console.info(''Not Authenticated'');
                hide(''display-user'');
                show(''login'');
                hide(''logout'')
            }
        })
    } else {
        show(''config-edit'');
        hide(''config-view'');
    }
}

function show(id) {
    document.getElementById(id).classList.remove(''hide'');
    document.getElementById(id).classList.add(''show'');
}

function hide(id) {
    document.getElementById(id).classList.add(''hide'');
    document.getElementById(id).classList.remove(''show'');
}

function updateConfig() {
    var url = document.getElementById(''url'').value;
    var realm = document.getElementById(''realm'').value;
    var client = document.getElementById(''client'').value;

    window.location.href = window.location.href.split(''#'')[0] + ''#url='' + url + ''&realm='' + realm + ''&client='' + client;
}

function loadConfig() {
    var h = window.location.hash.substring(1).split(''&'');
    var r = {};
    for (var i = 0; i < h.length; i++) {
        var t = h[i].split(''='')
        r[t[0]] = t[1];
    }
    return r;
}

window.onhashchange = init;
window.onload = init;
'
]

{ #category : 'accessing' }
KeycloakHelloBootstrapApp >> applicationTitle [

	^ 'Keycloak Hello Bootstrap'
]

{ #category : 'rendering' }
KeycloakHelloBootstrapApp >> renderContentOn: html [

	html script url: 'https://cdn.jsdelivr.net/npm/keycloak-js@17.0.1/dist/keycloak.min.js'.
	html script with: self appJsContent.

	html html: '
<div class="jumbotron jumbotron-fluid kc-bg-triangles py-5 kc-app">
    <div class="container">
    <div class="row">
        <div class="card">
            <div id="card-config" class="card-body">
                <div id="config-view" class="hide my-3">
                    <a id="login" class="btn btn-primary hide">Sign in</a>
                    <a id="logout" class="btn btn-primary hide">Sign out</a>
                    <a href="#" class="btn btn-secondary show">Clear config</a>
                </div>
                <div id="config-edit" class="hide">
                    <form id="config-form">
                      <div class="mb-3">
                        <label for="url" class="form-label">Keycloak URL</label>
                        <div>
                          <input type="text" class="form-control" id="url" value="http://localhost:8080">
                        </div>
                      </div>
                      <div class="mb-3">
                        <label for="realm" class="form-label">Realm</label>
                        <div>
                          <input type="text" class="form-control" id="realm" value="myrealm">
                        </div>
                      </div>
                      <div class="mb-3">
                        <label for="client" class="form-label">Client</label>
                        <div>
                          <input type="text" class="form-control" id="client" value="myclient">
                        </div>
                      </div>
                      <div>
                          <button class="btn btn-primary">Save</button>
                      </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div id="display-user" class="row hide">
        <div class="card mt-3">
            <div class="card-body">
                Hello, <span id="user-details"></span>
            </div>
        </div>
    </div>
    </div>
</div>
'
]

{ #category : 'updating' }
KeycloakHelloBootstrapApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.

	anHtmlRoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1.0, shrink-to-fit=no'.

	anHtmlRoot stylesheet url: 'https://www.keycloak.org/resources/bootstrap/dist/css/bootstrap.min.css'.
	anHtmlRoot stylesheet url: 'https://www.keycloak.org/resources/@fortawesome/fontawesome-free/css/all.min.css'.
	anHtmlRoot stylesheet url: 'https://www.keycloak.org/resources/css/keycloak.css'.
	anHtmlRoot stylesheet url: 'https://www.keycloak.org/resources/bootstrap/dist/js/bootstrap.min.js'.
	anHtmlRoot title: self applicationTitle.
	anHtmlRoot beHtml5

]
