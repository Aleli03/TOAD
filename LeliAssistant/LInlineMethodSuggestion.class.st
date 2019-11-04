"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	previewCache:		<Object>


    Implementation Points
"
Class {
	#name : #LInlineMethodSuggestion,
	#superclass : #LSourceCodeSuggestion,
	#instVars : [
		'previewCache'
	],
	#category : #'LeliAssistant-Core'
}

{ #category : #accessing }
LInlineMethodSuggestion class >> label [
^ 'Inline method suggestion'
]

{ #category : #'as yet unclassified' }
LInlineMethodSuggestion >> applyingRefactoring [
]

{ #category : #'as yet unclassified' }
LInlineMethodSuggestion >> browserForRefactor [
	^ LeliSourceCodeBrowser
]

{ #category : #accessing }
LInlineMethodSuggestion >> previewText [
	previewCache
		ifNil: [ | both textA textB styler |
			both := self refactoring previewString.
			styler := SHRBTextStyler new.
			styler classOrMetaClass: self selectedClass.
			textA := styler styledTextFor: self selectedMethod sourceCode asText.
			textB := styler styledTextFor: both asText.
			previewCache := {textA.
			textB} ].
	^ previewCache
]

{ #category : #accessing }
LInlineMethodSuggestion >> previewText: variableName [
	| newCode textA textB styler |
	super previewText: variableName.
	newCode := self refactoring previewString.
	styler := SHRBTextStyler new.
	styler classOrMetaClass: self selectedClass.
	textA := styler styledTextFor: self selectedMethod sourceCode asText.
	textB := styler styledTextFor: newCode asText.
	^ {textA.
	textB}
]

{ #category : #accessing }
LInlineMethodSuggestion >> refactoring [
	refactoring
		ifNil: [ refactoring := RBInlineMethodRefactoring
				inline: self sourceCodeInterval
				inMethod: self selectedMethod selector
				forClass: self selectedClass ].
	^ refactoring
]

{ #category : #accessing }
LInlineMethodSuggestion >> shortMessage [
	^ optionNumber asString .
]
