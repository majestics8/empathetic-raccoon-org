public class Assignementoldpart3Helper {
   // final integer var=4;
    public static void accountrecord(List<Service_Request__c> srclist){

        set<Id> accid=new set<Id>();
        for(Service_Request__c src:srclist){
            if(src.Account__c!=null && src.Status__c=='Resolved'){
                accid.add(src.Account__c);
            }
        }
        Map<Id,Decimal> averagetime=new Map<Id,Decimal>();
        for(AggregateResult arr:[select avg(Time_to_resolve__c) avgtime,Account__c accnt from Service_Request__c where Account__c In:accid And Status__c='Resolved' Group By Account__c]){
            averagetime.put((Id)arr.get('accnt'),(Decimal)arr.get('avgtime'));
        }
        
        
        Map<Id,integer> countfortop=new Map<Id,integer>();
        Map<Id,Id> topagent=new Map<Id,Id>();
        
		for(AggregateResult arr:[select count(Id) totalreq,Account__c accnt,Agent__c topagent from Service_Request__c where Account__c In:accid And Status__c='Resolved' Group By Account__c,Agent__c]){
            id accountid=(Id)arr.get('accnt');
            id topagentid=(Id)arr.get('topagent');
            integer count=(integer)arr.get('totalreq');
            
            if(!topagent.containskey(accountid)){
                topagent.put(accountid,topagentid);
                countfortop.put(accountid,count);
            }
            if(count>countfortop.get(accountid)){
                topagent.put(accountid,topagentid);
                countfortop.put(accountid,count);
            }
        }
        
        
        
        List<Account> accnt=new List<Account>();
        for(Id acc:accid){
           accnt.Add(New Account(Id=acc,Average_Resolution_Time__c=averagetime.get(acc),Top_Agent__c=topagent.get(acc)));
        }
        
        if(!accnt.isEmpty()){
            update accnt;
        }
    }
}