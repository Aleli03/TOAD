Class {
	#name : #LeliSourceCodeWithFieldBrowser,
	#superclass : #LeliSourceCodeBrowser,
	#instVars : [
		'methodNameField',
		'option1',
		'option2',
		'option3',
		'option4',
		'option5',
		'actions',
		'selectedSuggestion'
	],
	#category : #'LeliAssistant-UI'
}

{ #category : #specs }
LeliSourceCodeWithFieldBrowser class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row | 
			row
				add: #superiorLabel width: 120;
				add: #methodNameField ]
			origin: 0 @ 0
			corner: 1 @ 0.05;
		newRow: [ :row | 
			row
				add: #previewSourceCodeOrBefore;
				add: #previewMethodOrAfter ]
			origin: 0 @ 0.05
			corner: 1 @ 0.90;
		newRow: [ :row | 
			row
				newColumn: [ :col | 
					col
						newRow: [ :subRow | 
							subRow
								add: #comboBoxLabel width: 90;
								add: #option1 width: 40;
								add: #option2 width: 40;
								add: #option3 width: 40;
								add: #option4 width: 40;
								add: #option5 width: 40 ]
						height: 40 ];
				newColumn: [ :col | 
					col
						newRow: [ :subRow | 
							subRow
								newColumn: [ :subCol |  ];
								newColumn: [ :subcol | 
									subcol
										newRow: [ :subSubRow | 
											subSubRow
												add: #okButton;
												add: #cancelButton ]
										height: 40 ] ] ] ]
			origin: 0 @ 0.9
			corner: 1 @ 1;
		yourself
]

{ #category : #specs }
LeliSourceCodeWithFieldBrowser class >> on: suggestions [
	| inst |
	inst := self new.
	inst suggestions: suggestions.
	^ inst
]

{ #category : #'as yet unclassified' }
LeliSourceCodeWithFieldBrowser >> getPreviewText: item [
|nameFromField|
	nameFromField := methodNameField text.
	^ item previewText: nameFromField.
]

{ #category : #initialization }
LeliSourceCodeWithFieldBrowser >> initializePresenter [
	super initializePresenter.
	methodNameField whenTextChanged: [ self textUpdate ].
	okButton action: [ 
		selectedSuggestion ifNotNil: [ selectedSuggestion applyingRefactoring: methodNameField text. ].
		
		self window close ].
	self options do: [ :optionButton | optionButton action: [ self select: optionButton ] ].
]

{ #category : #initialization }
LeliSourceCodeWithFieldBrowser >> initializeWidgets [
	super initializeWidgets.
	methodNameField := self instantiate: TextInputFieldPresenter.
	methodNameField text: 'newMethod'.
	option1 := self instantiate: ButtonPresenter.
	option2 := self instantiate: ButtonPresenter.
	option3 := self instantiate: ButtonPresenter.
	option4 := self instantiate: ButtonPresenter.
	option5 := self instantiate: ButtonPresenter.
	actions := Dictionary new.
	option1 icon: BaseLeliBrowser new option1Icon.
	option2 icon: BaseLeliBrowser new option2Icon.
	option3 icon: BaseLeliBrowser new option3Icon.
	option4 icon: BaseLeliBrowser new option4Icon.
	option5 icon: BaseLeliBrowser new option5Icon
]

{ #category : #accessing }
LeliSourceCodeWithFieldBrowser >> methodNameField [
	^ methodNameField
]

{ #category : #accessing }
LeliSourceCodeWithFieldBrowser >> option1 [
	^ option1
]

{ #category : #accessing }
LeliSourceCodeWithFieldBrowser >> option2 [
	^ option2
]

{ #category : #accessing }
LeliSourceCodeWithFieldBrowser >> option3 [
	^ option3
]

{ #category : #accessing }
LeliSourceCodeWithFieldBrowser >> option4 [
	^ option4
]

{ #category : #accessing }
LeliSourceCodeWithFieldBrowser >> option5 [
	^ option5
]

{ #category : #initialization }
LeliSourceCodeWithFieldBrowser >> options [
	^{option1. option2 . option3. option4. option5}
]

{ #category : #initialization }
LeliSourceCodeWithFieldBrowser >> select: anOption [
	(actions at: anOption) value.
]

{ #category : #accessing }
LeliSourceCodeWithFieldBrowser >> suggestions: aOrderedCollection [
	| gap |
	aOrderedCollection isEmpty
		ifTrue: [ ^ self ].
	self options
		do: [ :optionButton | 
			optionButton disable.
			actions at: optionButton put: [  ] ].
	gap := 1.
	selectedSuggestion := aOrderedCollection middle.
	self textUpdate.
	aOrderedCollection
		do: [ :sug |
			| op |
			op := self options at: gap.
			sug ifNil:[
				op disable.
			actions at: op put: [  ] 
				] ifNotNil:[
							op enable.
			actions
				at: op
				put: [ selectedSuggestion := sug.
					self textUpdate ].
				
				].
			sug = selectedSuggestion
				ifTrue: [ op action ].
			gap := gap + 1 ]
]

{ #category : #'as yet unclassified' }
LeliSourceCodeWithFieldBrowser >> textUpdate [
	| previewSourceCode previewMethod selectedItem both |
	selectedSuggestion ifNil: [ ^ self ].
	selectedItem := selectedSuggestion.
	both := selectedItem previewText: methodNameField text.
	previewSourceCode := both first.
	previewMethod := both second.
	previewSourceCodeOrBefore text: previewSourceCode.
	previewMethodOrAfter text: previewMethod.
	previewMethodOrAfter setSelection: (selectedItem selectorInterval: methodNameField text).
	previewSourceCodeOrBefore
		setSelection: (selectedItem senderInterval: methodNameField text)
]

{ #category : #'as yet unclassified' }
LeliSourceCodeWithFieldBrowser >> updateUI [
]
