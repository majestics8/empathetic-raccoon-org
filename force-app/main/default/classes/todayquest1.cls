public class todayquest1 {
    public static void question1(List<Case> cclist){
        set<Id> accid=new set<Id>();
        set<Id> caseid=new set<Id>();
        Map<Id,String> accntmap=new Map<Id,String>();
        for(case cc:cclist){
            if(cc.AccountId !=null && cc.Status__c=='Active'){
                accid.add(cc.AccountId);
                accntmap.put(cc.AccountId,cc.Subject);
                caseid.add(cc.Id);
            }
        }
        
        List<Case> cases=new List<Case>();
        for(Case cc:[select Status__c,Subject,AccountId from Case Where AccountId In :accid And Id Not IN:caseid AND Status__c='Active']){
            cases.add(new Case(Id=cc.Id,Status__c='Inactive'));
        }
        
        List<Account> accnts=new List<Account>();
        for(Id acc:accid){
            if(accntmap.containsKey(acc)){
                accnts.add(New Account(Id=acc,Case_Subject__c=accntmap.get(acc)));
            }
        }
        
        if(!cases.isEmpty()){
            update cases;
        }
        
        if(!accnts.isEmpty()){
            update accnts;
        }
        
    }
}