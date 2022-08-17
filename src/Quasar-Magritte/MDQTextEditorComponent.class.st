Class {
	#name : #MDQTextEditorComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQTextEditorComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| theDescription inputTag inputLabel inputValue app flag toolbarItems modelName |

	app := self mdqApplicationGet.
	theDescription := self magritteDescription.
	inputLabel := theDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qInput.
	self setFieldStyleOf: inputTag.
	inputTag type: 'textarea'.
	inputTag label: inputLabel.

	flag := aReadonlyFlag or: [ self isReadonlyForced ].
	toolbarItems := flag ifTrue: [ '[]' ] ifFalse: [ self toolbarItemsForEdit ].
	modelName := self magritteDescription mdqLabelAsSafeIdentifier.
	app vueRefsAdd: modelName -> inputValue.
	inputTag
		inputStyle: 'display: none';
		vModel: modelName;
		on: self inputAspect of: self;
		with: [
			html qTemplate vSlot: 'default'; with: [
				html div class: 'q-py-sm fit'; with: [
					html qEditor
						height: theDescription height;
						minHeight: theDescription minHeight;
						maxHeight: theDescription maxHeight;
						vBind: 'toolbar' with: toolbarItems;
						readonly: flag; "disable: flag;" name: modelName; vModel: modelName ] ] ]
]

{ #category : #rendering }
MDQTextEditorComponent >> toolbarItemsForEdit [

	^ '[
[''left'', ''center'', ''right'', ''justify''],
[''bold'', ''italic'', ''strike'', ''underline'', ''subscript'', ''superscript''],
[''token'', ''hr'', ''link'', ''custom_btn''],
[{
label: $q.lang.editor.formatting,
icon: $q.iconSet.editor.formatting,
list: ''no-icons'',
options: [''p'',''h1'',''h2'',''h3'',''h4'',''h5'',''h6'',''code'']}],
[''quote'', ''unordered'', ''ordered'', ''outdent'', ''indent''],
[''undo'', ''redo''],
[''print'', ''fullscreen''],
[''removeFormat'', ''viewsource'']
]'
]
