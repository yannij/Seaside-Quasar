Class {
	#name : #MDQTextEditorComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQTextEditorComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app flag toolbarItems modelName |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qInput.
	self setFieldStyleOf: inputTag.
	inputTag type: 'textarea'.
	"self setExtraOf: fieldTag."
	inputTag label: inputLabel.
	"self fieldPrefix ifNotNil: [ :prefixValue | inputTag prefix: prefixValue ].
	self fieldSuffix ifNotNil: [ :suffixValue | inputTag suffix: suffixValue ]."

	flag := aReadonlyFlag or: [ self isReadonlyForced ].
	toolbarItems := flag ifTrue: [ '[]' ] ifFalse: [ self toolbarItemsForEdit ].
	modelName := inputLabel asCamelCase uncapitalized.
	app vueRefsAdd: modelName -> inputValue.
	inputTag
		inputStyle: 'display: none';
		vModel: modelName;
		on: self inputAspect of: self;
		with: [
			html qTemplate vSlot: 'default'; with: [
				html qEditor
					vBind: 'toolbar' with: toolbarItems;
					readonly: flag; "disable: flag;" name: modelName; vModel: modelName ]
			"self renderTemplateOn: html vModel: modelName" ]
]

{ #category : #rendering }
MDQTextEditorComponent >> toolbarItemsForEdit [

	^ '[
[''left'', ''center'', ''right'', ''justify''],
[''bold'', ''italic'', ''strike'', ''underline'', ''subscript'', ''superscript''],
[''token'', ''hr'', ''link'', ''custom_btn''],
[''print'', ''fullscreen''],
[{
label: $q.lang.editor.formatting,
icon: $q.iconSet.editor.formatting,
list: ''no-icons'',
options: [''p'',''h1'',''h2'',''h3'',''h4'',''h5'',''h6'',''code'']}],
[''quote'', ''unordered'', ''ordered'', ''outdent'', ''indent''],
[''undo'', ''redo''],
[''removeFormat'', ''viewsource'']
]'
]
