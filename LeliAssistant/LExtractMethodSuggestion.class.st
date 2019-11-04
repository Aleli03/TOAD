Class {
	#name : #LExtractMethodSuggestion,
	#superclass : #LSourceCodeSuggestion,
	#instVars : [
		'numberOfArgument',
		'numberOfLines',
		'previewCache'
	],
	#category : #'LeliAssistant-Core'
}

{ #category : #accessing }
LExtractMethodSuggestion class >> label [
	^ 'Extract method suggestion'
]

{ #category : #'as yet unclassified' }
LExtractMethodSuggestion >> applyingRefactoring [
	| toExecuteRefactor dialog|
	toExecuteRefactor := self refactoring.
	toExecuteRefactor
		setOption: #methodName
		toUse: [ :ref :methodName | 
			dialog := SycMethodNameEditor openOn: methodName.
			dialog cancelled
				ifTrue: [ CmdCommandAborted signal ].
			methodName ].
	toExecuteRefactor execute
]

{ #category : #'as yet unclassified' }
LExtractMethodSuggestion >> applyingRefactoring: newMethodName [
	| both sourceCodeChange |
	super applyingRefactoring: newMethodName.
	both := self previewText: newMethodName.
	sourceCodeChange := both first.
	self selectedClass compile: sourceCodeChange
]

{ #category : #'as yet unclassified' }
LExtractMethodSuggestion >> browserForRefactor [
	^ LeliSourceCodeWithFieldBrowser
]

{ #category : #accessing }
LExtractMethodSuggestion >> numberOfArgumentsOfNewMethod [
	numberOfArgument
		ifNil: [ | newMethodCode |
			newMethodCode := self refactoring previewString second.
			numberOfArgument := (RBParser parseMethod: newMethodCode) arguments
				size ].
	^ numberOfArgument.
]

{ #category : #accessing }
LExtractMethodSuggestion >> numberOfLinesOfNewMethod [
	numberOfLines ifNil:[
	| newMethodCode |
	newMethodCode := self refactoring previewString second.
	numberOfLines := newMethodCode lineCount
	].
	^ numberOfLines.
]

{ #category : #accessing }
LExtractMethodSuggestion >> previewText [
	previewCache
		ifNil: [ | both textA textB styler |
			both := self refactoring previewString.
			styler := SHRBTextStyler new.
			styler classOrMetaClass: self selectedClass.
			textA := styler styledTextFor: both first asText.
			textB := styler styledTextFor: both second asText.
			previewCache := {textA.
			textB} ].
	^ previewCache
]

{ #category : #accessing }
LExtractMethodSuggestion >> previewText: newMethodName [
	| both textA textB styler |
	"super previewText: newMethodName."
	both := self refactoring clone previewString: newMethodName.
	styler := SHRBTextStyler new.
	styler classOrMetaClass: self selectedClass.
	textA := styler styledTextFor: both first asText.
	textB := styler styledTextFor: both second asText.
	^ {textA.
	textB}
]

{ #category : #accessing }
LExtractMethodSuggestion >> refactoring [
	refactoring
		ifNil: [ refactoring := RBExtractMethodRefactoring
				extract: self sourceCodeInterval
				from: self selectedMethod selector
				in: self selectedClass ].
	^ refactoring
]

{ #category : #accessing }
LExtractMethodSuggestion >> selectorInterval [
	| newMethodCode parsed stop |
	newMethodCode := (self refactoring previewString: 'jj') second.
	parsed := RBParser parseMethod: newMethodCode.
	stop := parsed arguments isEmpty
		ifTrue: [ parsed selector size ]
		ifFalse: [ parsed arguments last stop ].
	^ {1.
	stop}
]

{ #category : #accessing }
LExtractMethodSuggestion >> selectorInterval: newName [
	| newMethodCode parsed stop |
	newMethodCode := (self refactoring previewString: newName) second.
	parsed := RBParser parseMethod: newMethodCode.
	stop := parsed arguments isEmpty
		ifTrue: [ parsed selector size ]
		ifFalse: [ parsed arguments last stop ].
	^ {1.
	stop}
]

{ #category : #accessing }
LExtractMethodSuggestion >> senderInterval [
	| newMethodCode newSelector oldMethod node |
	newMethodCode := self refactoring previewString second.
	newSelector := (RBParser parseMethod: newMethodCode) selector.
	oldMethod := RBParser parseMethod: (self refactoring previewString) first.
	node := oldMethod allChildren detect: [ :n | n isMessage and: [ n selector = newSelector ] ] ifNone: [ nil ].
	^ node ifNil: [ 0 to: 0 ] ifNotNil: [ node start to: node stop ]
]

{ #category : #accessing }
LExtractMethodSuggestion >> senderInterval: newName [
	| newMethodCode newSelector oldMethod node |
	newMethodCode := (self refactoring previewString: newName) second.
	newSelector := (RBParser parseMethod: newMethodCode) selector.
	oldMethod := RBParser parseMethod: (self refactoring previewString: newName) first.
		node := oldMethod allChildren
		detect: [ :n | n isMessage and: [ n selector = newSelector ] ]
		ifNone: [ nil ].
	^ node
		ifNil: [ 0 to: 0 ]
		ifNotNil: [ node startWithoutParentheses to: node stopWithoutParentheses ]
]

{ #category : #accessing }
LExtractMethodSuggestion >> shortMessage [
	^ optionNumber asString .
]
