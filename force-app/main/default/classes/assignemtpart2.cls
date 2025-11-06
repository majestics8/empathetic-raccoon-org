public class assignemtpart2 {
     public static void question1(List<Case> cclist){
            set<Id> accid=new set<Id>();
            set<Id> caseid=new set<Id>();
            
            for(case cc:cclist){
                if(cc.AccountId !=null && cc.Status__c=='Active'){
                    accid.add(cc.AccountId);
                    caseid.add(cc.Id);
                }
            }
         
            Map<Id,String> accntmap=new Map<Id,String>();
            set<Id> accountidsofcase=new set<Id>();
            for(Case cc:[select Status__c,Subject,AccountId from Case Where AccountId In :accid AND Id Not IN:caseid AND Status__c='Active']){
                accountidsofcase.add(cc.AccountId);
                accntmap.put(cc.AccountId,cc.Subject);
            }
            
            List<Account> accnts=new List<Account>();
            for(Id acc:accid){
                if(accntmap.containsKey(acc)){
                    accnts.add(New Account(Id=acc,Case_Subject__c=accntmap.get(acc)));
                }
            }
         
            List<Case> cases=new List<Case>();
             for(Case cc:cclist){
                 if(cc.AccountId !=null && cc.Status__c=='Active' && accountidsofcase.contains(cc.AccountId)){
                     cases.add(New Case(Id=cc.Id,Status__c='InActive'));
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