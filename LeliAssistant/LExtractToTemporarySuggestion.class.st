Class {
	#name : #LExtractToTemporarySuggestion,
	#superclass : #LSourceCodeSuggestion,
	#instVars : [
		'previewCache'
	],
	#category : #'LeliAssistant-Core'
}

{ #category : #accessing }
LExtractToTemporarySuggestion class >> label [
	^'Extract to temporary suggestion'
]

{ #category : #'as yet unclassified' }
LExtractToTemporarySuggestion >> applyingRefactoring [

]

{ #category : #'as yet unclassified' }
LExtractToTemporarySuggestion >> browserForRefactor [
	^ LeliSourceCodeWithFieldBrowser
]

{ #category : #'as yet unclassified' }
LExtractToTemporarySuggestion >> checkPreconditions [
	[ self refactoring preconditions check. self previewText.
	self beValid ]
		on: Error
		do: [  ]
]

{ #category : #'as yet unclassified' }
LExtractToTemporarySuggestion >> previewText [
	previewCache
		ifNil: [ | newCode textA textB styler |
			newCode := self refactoring previewString.
			styler := SHRBTextStyler new.
			styler classOrMetaClass: self selectedClass.
			textA := styler styledTextFor: self selectedMethod sourceCode asText.
			textB := styler styledTextFor: newCode asText.
			previewCache := {textA.
			textB} ].
	^ previewCache
]

{ #category : #'as yet unclassified' }
LExtractToTemporarySuggestion >> previewText: variableName [
	| newCode textA textB styler |
		super previewText: variableName.
	newCode := self refactoring previewString: variableName.
	styler := SHRBTextStyler new.
	styler classOrMetaClass: self selectedClass.
	textA := styler styledTextFor: self selectedMethod sourceCode asText.
	textB := styler styledTextFor: newCode asText.
	^ {textA.
	textB}
]

{ #category : #accessing }
LExtractToTemporarySuggestion >> refactoring [
	refactoring
		ifNil: [ refactoring := RBExtractToTemporaryRefactoring
				extract: self sourceCodeInterval
				to: 'newVariable'
				from: self selectedMethod selector
				in: self selectedClass ].
	^ refactoring
]

{ #category : #accessing }
LExtractToTemporarySuggestion >> shortMessage [
	^ optionNumber asString
]
