Class {
	#name : #LCreateCascadeSuggestion,
	#superclass : #LSourceCodeSuggestion,
	#instVars : [
		'previewCache'
	],
	#category : #'LeliAssistant-Core'
}

{ #category : #accessing }
LCreateCascadeSuggestion class >> label [
	^ 'Create cascade suggestion'
]

{ #category : #'as yet unclassified' }
LCreateCascadeSuggestion >> applyingRefactoring [
	
]

{ #category : #'as yet unclassified' }
LCreateCascadeSuggestion >> browserForRefactor [
^ LeliSourceCodeBrowser
]

{ #category : #'as yet unclassified' }
LCreateCascadeSuggestion >> previewText [
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
LCreateCascadeSuggestion >> previewText: variableName [
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
LCreateCascadeSuggestion >> refactoring [
	refactoring
		ifNil: [ refactoring := RBCreateCascadeRefactoring
				combine: self sourceCodeInterval 
				from: self selectedMethod selector
				in: self selectedClass ].
	^ refactoring
]

{ #category : #accessing }
LCreateCascadeSuggestion >> shortMessage [
	^ optionNumber asString
]
