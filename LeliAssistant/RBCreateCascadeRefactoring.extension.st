Extension { #name : #RBCreateCascadeRefactoring }

{ #category : #'*LeliAssistant' }
RBCreateCascadeRefactoring >> previewString [
	self combineMessages.
	(RBParseTreeRewriter
				replaceStatements: sequenceNode formattedCode
				with: transformedNode formattedCode
				in: self parseTree
				onInterval: selectedInterval).
	^ self parseTree formattedCode.
]

{ #category : #'*LeliAssistant' }
RBCreateCascadeRefactoring >> previewString: aString [
	self combineMessages.
	(RBParseTreeRewriter
				replaceStatements: sequenceNode formattedCode
				with: transformedNode formattedCode
				in: self parseTree
				onInterval: selectedInterval).
	^ self parseTree formattedCode
]
