Class {
	#name : 'MDQDescribedColumn',
	#superclass : 'MADescribedColumn',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'rendering' }
MDQDescribedColumn >> renderCell: anObject index: anInteger on: html [

	html tableData scope: 'row'; with: [
		self renderer valueWithEnoughArguments: (Array with: anObject with: html with: anInteger) ] 
]
