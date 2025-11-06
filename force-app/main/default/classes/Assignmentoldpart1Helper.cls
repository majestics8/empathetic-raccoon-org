public class Assignmentoldpart1Helper {
    public static void starttime(List<Service_Request__c> srlist){
        for(Service_Request__c src:srlist){
            if(src.Agent__c!=null){
				if(src.Status__c=='Open'){
                src.Start_Time__c=System.Now();
                }
            }
        }
    }
}