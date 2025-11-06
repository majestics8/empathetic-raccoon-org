trigger caseTrigger on Case (After Update ,After Insert) {
	CaseHandler.casehandling(trigger.new);
}