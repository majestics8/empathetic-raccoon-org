public class Assignmentoldpart2Helper {
    public static void endtime(List<Service_Request__c> srclist){
        
        for(Service_Request__c src:srclist){
            if(src.Status__c=='Resolved'){
                if(src.Start_Time__c !=null){
                    Long totaltime=system.now().getTime()-src.Start_Time__c.getTime();
                    Decimal totaltimeinmin=totaltime/60000;
                    src.End_Time__c=system.now();
                    src.Time_to_resolve__c=totaltimeinmin;
                    if(totaltimeinmin>10){
                        src.SLA_Breached__c=true;
                    }
                }
            }
        }
    }
}