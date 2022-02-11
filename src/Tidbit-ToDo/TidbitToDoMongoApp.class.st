"
I am a specialized subclass that stores data in MongoDB instead.

Docker instructions:

docker network create tidbit-app
docker run -it --network tidbit-app --network-alias mongo -v /Users/yanni/mongodata:/data/db -p 27017:27017 --name mongo -d mongo
docker run --network tidbit-app --network-alias tidbit1 -e MONGO_HOST=mongo -d -p 80:8080 tidbit

# Initialize the database
docker exec -it mongo bash
pharo Pharo.image eval ""TidbitExampleDatabase repositorySetUpMongo1Host: 'mongo' port: VOMongoRepository defaultPort""
"
Class {
	#name : #TidbitToDoMongoApp,
	#superclass : #QTidbitToDoApp,
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #'class initialization' }
TidbitToDoMongoApp class >> applicationPath [

	^ 'tidbit/todo-mongo'
]

{ #category : #'class initialization' }
TidbitToDoMongoApp class >> dockerDeployPostLoad [
	<dockerDeployPostLoad>

	TidbitExampleDatabase mongo1ResetConnection
]

{ #category : #'class initialization' }
TidbitToDoMongoApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
TidbitToDoMongoApp >> applicationTitle [

	^ 'Tidbit ToDo/Mongo'
]

{ #category : #'utility - repository' }
TidbitToDoMongoApp >> repository [

	^ TidbitExampleDatabase mongo1
]

{ #category : #'utility - repository' }
TidbitToDoMongoApp >> repositoryRecreateTestData [

	TidbitExampleDatabase mongo1RecreateTestData
]

{ #category : #'utility - repository' }
TidbitToDoMongoApp >> repositoryResetConnection [

	TidbitExampleDatabase mongo1ResetConnection
]
