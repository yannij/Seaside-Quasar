Class {
	#name : 'MDQMarkupTable',
	#superclass : 'MAReport',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'rendering' }
MDQMarkupTable >> renderContentOn: html [

	html qMarkupTable id: self ajaxId; with: [
		html qTemplate vSlot: 'default'; with: [
			self renderTableOn: html ] ]
]
