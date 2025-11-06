public class Nov4Assignment {
    public static void createtask(list<Opportunity> opplist){
		Map<Id,Id> accmap=new Map<Id,Id>();  //grab this
        set<Id> oppid=new set<Id>();
        for(Opportunity opp:opplist){
            if(opp.AccountId!=null && opp.StageName=='Closed Won'){
				accmap.put(opp.AccountId,opp.Id);
                oppid.add(opp.Id);
            }
        }
        
        Map<Id,Id> cntmap=new Map<id,Id>();  //grab this
        map<Id,Id>ccownermap=new map<Id,Id>();
        for(Contact cc:[select Id, ownerId,AccountId from Contact where AccountId In :accmap.keyset() And Level__c='Primary']){
            cntmap.put(cc.AccountId,cc.Id);
            ccownermap.put(cc.Id,cc.OwnerId);
        }
        
        set<Id> existcnt=new set<Id>();
        set<Id> existopp=new set<Id>();
        for(Task tt:[select WhatId,WhoId from Task where WhatId In:oppid And WhoId In:ccownermap.keyset()]){
            existopp.add(tt.WhatId);
            existcnt.add(tt.WhoId);
        }
        
        List<Task> tt=new List<Task>();
        for(Id accid:cntmap.keyset()){
            if(!existcnt.contains(cntmap.get(accid)) && !existopp.contains(accmap.get(accid))){
              tt.add(new Task(Subject='Follow up with Decision Maker for renewal',ActivityDate=date.today().addDays(30),Whatid=accmap.get(accid),WhoId=cntmap.get(accid),OwnerId=ccownermap.get(cntmap.get(accid))));
            }
        }
        
        if(!tt.isEmpty()){
            insert tt;
        }
         
    }
}