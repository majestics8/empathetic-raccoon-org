trigger ServiceReqiest on Service_Request__c (before Update,before insert,After Update) {
	ServiceRequesthandler.lastchance(trigger.new);
}