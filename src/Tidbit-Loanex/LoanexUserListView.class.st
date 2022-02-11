Class {
	#name : #LoanexUserListView,
	#superclass : #LoanexListView,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #accessing }
LoanexUserListView >> modelClass [

	^ LoanexUser
]

{ #category : #rendering }
LoanexUserListView >> renderInstancesOn: html [
	| app list |

	app := self mdqApplicationGet.
	list := app repository selectAll: self modelClass.

	self renderTitle: 'Users' on: html.
	self renderAsList: list on: html
]
