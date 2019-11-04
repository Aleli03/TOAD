Class {
	#name : #BrowserToMoveMethod,
	#superclass : #ComposablePresenter,
	#instVars : [
		'titleLabel',
		'moveToSection',
		'asAbstractCheckBox',
		'actualPlaceFromMethod',
		'previewSection',
		'okButton',
		'cancelButton'
	],
	#category : #'LeliAssistant-UI'
}

{ #category : #specs }
BrowserToMoveMethod class >> defaultSpec [
	<spec>
	^ SpecColumnLayout composed
		newRow: [ :row | row add: #titleLabel ] origin: 0 @ 0 corner: 1 @ 0.07;
		newRow: [ :row | row add: #moveToSection ] origin: 0 @ 0.07 corner: 1 @ 0.3;
		newRow: [ :row | row add: #asAbstractCheckBox ] origin: 0 @ 0.3 corner: 1 @ 0.35;
		addSplitter;
		newRow: [ :row | 
			row
				add: #actualPlaceFromMethod;
				add: #previewSection ]
			origin: 0 @ 0.35
			corner: 1 @ 0.88;
		addSplitter;
		newRow: [ :row | row add: #okButton ] origin: 0 @ 0.88 corner: 1 @ 0.94;
		newRow: [ :row | row add: #cancelButton ] origin: 0 @ 0.94 corner: 1 @ 1;
		yourself
]

{ #category : #'as yet unclassified' }
BrowserToMoveMethod class >> title [
	^ 'TOAD: auto-refactorings alternatives for moving methods'
]

{ #category : #accessing }
BrowserToMoveMethod >> actualPlaceFromMethod [
	^ actualPlaceFromMethod
]

{ #category : #accessing }
BrowserToMoveMethod >> asAbstractCheckBox [
	^ asAbstractCheckBox
]

{ #category : #accessing }
BrowserToMoveMethod >> cancelButton [
	^ cancelButton
]

{ #category : #api }
BrowserToMoveMethod >> extent [
	^ 1000 @ 800
]

{ #category : #initialization }
BrowserToMoveMethod >> initializeWidgets [
	titleLabel := self instantiate: LabelPresenter.
	actualPlaceFromMethod := self instantiate: TextPresenter.
	previewSection := self instantiate: TextPresenter.
	okButton := self instantiate: ButtonPresenter.
	cancelButton := self instantiate: ButtonPresenter.
	moveToSection := self instantiate: TextPresenter.
	"asAbstractCheckBox := CheckBoxPresenter."
	asAbstractCheckBox := self instantiate: ButtonPresenter.
	okButton
		label: 'Ok';
		icon: (self iconNamed: #thumbsUp).
	cancelButton
		label: 'Cancel';
		icon: (self iconNamed: #thumbsDown)
]

{ #category : #accessing }
BrowserToMoveMethod >> moveToSection [
	^ moveToSection
]

{ #category : #accessing }
BrowserToMoveMethod >> okButton [
	^ okButton
]

{ #category : #accessing }
BrowserToMoveMethod >> previewSection [
	^ previewSection
]

{ #category : #accessing }
BrowserToMoveMethod >> titleLabel [
	^ titleLabel
]
