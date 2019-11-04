Extension { #name : #RBInlineMethodRefactoring }

{ #category : #'*LeliAssistant' }
RBInlineMethodRefactoring >> previewString [
	self
		renameConflictingTemporaries;
		insertInlinedMethod.
	^ sourceParseTree formattedCode
]
