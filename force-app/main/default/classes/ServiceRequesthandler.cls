public class ServiceRequesthandler {
    public static void lastchance(List<Service_Request__c> srclist){
        if(Trigger.isBefore && (Trigger.isUpdate ||Trigger.isInsert)){
            Assignmentoldpart1Helper.starttime(srclist);
        }  
        if(Trigger.isBefore && Trigger.isUpdate){
            Assignmentoldpart2Helper.endtime(srclist);
        }
        if(Trigger.isAfter && Trigger.isUpdate){
            Assignementoldpart3Helper.accountrecord(srclist);
        }
    }
}