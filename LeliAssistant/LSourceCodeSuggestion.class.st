Class {
	#name : #LSourceCodeSuggestion,
	#superclass : #LSuggestion,
	#instVars : [
		'methodNameFromField',
		'shortMessage',
		'icon',
		'context',
		'refactoring',
		'valid',
		'sourceCodeInterval',
		'code',
		'trimmedInterval'
	],
	#category : #'LeliAssistant-Core'
}

{ #category : #accessing }
LSourceCodeSuggestion class >> label [
	^ 'Source code suggestion'
]

{ #category : #'instance creation' }
LSourceCodeSuggestion class >> on: aContext [
	| sug |
	sug := self new.
	sug context: aContext.
	^ sug
]

{ #category : #comparing }
LSourceCodeSuggestion >> = otherSuggestion [
	^ self class = otherSuggestion class
		and: [ self trimmedInterval = otherSuggestion trimmedInterval ]
]

{ #category : #'as yet unclassified' }
LSourceCodeSuggestion >> applyingRefactoring [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
LSourceCodeSuggestion >> applyingRefactoring: newMethodName [
	| both methodToCreate |
	both := self previewText: newMethodName.
	methodToCreate := both second.
	self selectedClass compile: methodToCreate
]

{ #category : #acccessing }
LSourceCodeSuggestion >> beValid [
	valid := true.
]

{ #category : #accessing }
LSourceCodeSuggestion >> checkPreconditions [
	[ self refactoring preconditions check.
	self beValid ]
		on: Error
		do: [  ]
]

{ #category : #accessing }
LSourceCodeSuggestion >> code [
	^ code
]

{ #category : #accessing }
LSourceCodeSuggestion >> code: anObject [
	^ code := anObject
]

{ #category : #accessing }
LSourceCodeSuggestion >> context: anObject [
	context := anObject.
	self sourceCodeInterval: context selectedInterval.
]

{ #category : #accessing }
LSourceCodeSuggestion >> fullSourceCode [
	code ifNil:[
		code := self selectedMethod sourceCode.
		].
	^ code .
]

{ #category : #accessing }
LSourceCodeSuggestion >> icon [
	^ icon
]

{ #category : #acccessing }
LSourceCodeSuggestion >> initialize [
	super initialize.
	valid := false.
]

{ #category : #acccessing }
LSourceCodeSuggestion >> isValid [ 	
	^ valid
]

{ #category : #accessing }
LSourceCodeSuggestion >> methodNameFromField [
	^ methodNameFromField
]

{ #category : #accessing }
LSourceCodeSuggestion >> methodNameFromField: anObject [
	methodNameFromField := anObject
]

{ #category : #accessing }
LSourceCodeSuggestion >> previewText [
	^ self subclassResponsibility.
]

{ #category : #accessing }
LSourceCodeSuggestion >> previewText: anObject [
	methodNameFromField := anObject
]

{ #category : #accessing }
LSourceCodeSuggestion >> printOn: aStream [
	aStream nextPutAll: self shortMessage.
]

{ #category : #accessing }
LSourceCodeSuggestion >> refactoring [
	^ self subclassResponsibility.
]

{ #category : #accessing }
LSourceCodeSuggestion >> refactoring: anObject [
	refactoring := anObject
]

{ #category : #acccessing }
LSourceCodeSuggestion >> refactoringClass [
	^ RBExtractMethodRefactoring
]

{ #category : #accessing }
LSourceCodeSuggestion >> selectedClass [
	^ context selectedClass
]

{ #category : #accessing }
LSourceCodeSuggestion >> selectedMethod [
	^ context selectedMethod
]

{ #category : #accessing }
LSourceCodeSuggestion >> shortMessage [
	shortMessage
		ifNil: [ shortMessage := self sourceCode first: (50 min: self sourceCode size) ].
	^ shortMessage
]

{ #category : #accessing }
LSourceCodeSuggestion >> sourceCode [
	
	^ self fullSourceCode copyFrom: self sourceCodeInterval first to: self sourceCodeInterval last.
]

{ #category : #accessing }
LSourceCodeSuggestion >> sourceCodeInterval [
	^ sourceCodeInterval
]

{ #category : #accessing }
LSourceCodeSuggestion >> sourceCodeInterval: anInterval [
	sourceCodeInterval:= anInterval.
]

{ #category : #accessing }
LSourceCodeSuggestion >> trimmedInterval [
	trimmedInterval
		ifNil: [ | a b tempCode size |
			tempCode := self fullSourceCode.
			size := tempCode size.
			a := (self sourceCodeInterval first) max:1.
			b := self sourceCodeInterval last.
			[ a < size and: [ (tempCode at: a) isSeparator ] ]
				whileTrue: [ a := a + 1 ].
			[ b >= 1 and: [ (tempCode at: b) isSeparator ] ]
				whileTrue: [ b := b - 1 ].
			trimmedInterval := a to: b ].
	^ trimmedInterval
]

{ #category : #accessing }
LSourceCodeSuggestion >> trimmedInterval1 [
	^ trimmedInterval
]

{ #category : #accessing }
LSourceCodeSuggestion >> trimmedInterval: anObject [
	trimmedInterval := anObject
]

{ #category : #accessing }
LSourceCodeSuggestion >> valid: anObject [
	valid := anObject
]
