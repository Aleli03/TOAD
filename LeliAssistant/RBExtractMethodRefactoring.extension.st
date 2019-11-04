Extension { #name : #RBExtractMethodRefactoring }

{ #category : #'*LeliAssistant' }
RBExtractMethodRefactoring >> buildSelector [
	|methodName tag|
	parameters ifNil:[	^ 'newMethod'].
	parameters ifEmpty:[	^ 'newMethod'].
	parameters size = 1 ifTrue:[	^ 'newMethod:'].
	methodName :=''.
	tag :='newMethod:'.
	parameters do:[ :name|
			methodName := methodName,' ',tag.
			tag :='with:'
		].
	^ methodName.
]

{ #category : #'*LeliAssistant' }
RBExtractMethodRefactoring >> buildSelector: newMethodName [
	| methodName dots |
	parameters ifNil: [ ^ newMethodName ].
	parameters ifEmpty: [ ^ newMethodName ].
	dots := newMethodName reject: #isSeparator.
	dots := (dots select: [ :char | char = $: ]) size.
	dots = parameters size
		ifTrue: [ ^ newMethodName ].
	methodName := dots < parameters size
		ifTrue: [ self expandSelector: newMethodName in:  parameters size -dots ]
		ifFalse: [ self reduce: newMethodName in: parameters size ].
	^ methodName
]

{ #category : #'*LeliAssistant' }
RBExtractMethodRefactoring >> expandSelector: newMethodName in: anInteger [
	| methodName |
	anInteger = 1
		ifTrue: [ ^ newMethodName , ':' ].
	methodName := newMethodName,':'.
	
	(anInteger-1) timesRepeat: [ methodName := methodName , 'with:' ].
	^ methodName
]

{ #category : #'*LeliAssistant' }
RBExtractMethodRefactoring >> previewString [
	| existingSelector |
	self extractMethod.
	existingSelector := self existingSelector.
	self
		nameNewMethod:
			(existingSelector isNil
				ifTrue: [ self buildSelector ]
				ifFalse: [ existingSelector ]).
	^ {modifiedParseTree formattedCode.
	extractedParseTree formattedCode}
]

{ #category : #'*LeliAssistant' }
RBExtractMethodRefactoring >> previewString: newMethodName [
	self extractMethod.
	self checkSpecialExtractions.
	self checkReturn.
	needsReturn
		ifTrue: [ extractedParseTree addReturn ].
	self checkTemporaries.
	self nameNewMethod: (self buildSelector: newMethodName).
	^ {modifiedParseTree formattedCode.
	extractedParseTree formattedCode}
]

{ #category : #'*LeliAssistant' }
RBExtractMethodRefactoring >> reduce: newMethodName in: anInteger [
	^ String
		streamContents: [ :methodName | 
			| counter |
			counter := 0.
			newMethodName
				do: [ :char | 
					counter < anInteger
						ifTrue: [ methodName nextPut: char ].
					char = $:
						ifTrue: [ counter := counter + 1 ] ].]
]
