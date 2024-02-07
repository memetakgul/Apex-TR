public class ContactTriggerHandler {

    //Create a number of contacts field on the account and 
    //develop a trigger that updates this field on the account 
    //every time a new contact is created, ...
    
    public static Void numberOfCntsCreate(list<contact> cntList	){
        
        set<id> accIds = new Set<id>();
            for(contact cnt : cntList){
                if(cnt.AccountId != null){
                  accIds.add(cnt.AccountId);
                    
                }
                                
            }
        
         list< account> accList= [SELECT id, name, Number_Of_Contacts__c,
                                  (SELECT id FROM Contacts) 
                                  FROM account WHERE id IN: accIds];
            
            for(account acc : accList){
                 acc.Number_Of_Contacts__c = acc.Contacts.size(); 
                
			}
                         
                    update accList;
        
        
    }
    
    //... updated ...
    
    public static Void numberOfCntsUpdate(list<contact> cntNewList, Map<id,contact> cntOldMap	){
    
        set<id> accIds = new Set<id>();
            for(contact newCnt : cntNewList){
                 Contact oldCnt = cntOldMap.get(newCnt.Id);
                
                if(newCnt.AccountId == oldCnt.AccountId){
                  accIds.add(newCnt.AccountId);
                    
                }
                                
            }
        
         list< account> accList= [SELECT id, name, Number_Of_Contacts__c,
                                  (SELECT id FROM Contacts) 
                                  FROM account WHERE id IN: accIds];
            
            for(account acc : accList){
                 acc.Number_Of_Contacts__c = acc.Contacts.size(); 
                
			}
                         
                    update accList;
    }
    
    //... deleted ...
    
    public static Void numberOfCntsDelete(list<contact> cntList	){
        
        set<id> accIds = new Set<id>();
            for(contact cnt : cntList){
                if(cnt.AccountId != null){
                  accIds.add(cnt.AccountId);
                    
                }
                                
            }
        
         list< account> accList= [SELECT id, name, Number_Of_Contacts__c,
                                  (SELECT id FROM Contacts) 
                                  FROM account WHERE id IN: accIds];
            
            for(account acc : accList){
                 acc.Number_Of_Contacts__c = acc.Contacts.size(); 
                
			}                         
                    update accList;     
        
    }
    
    //... undelete ...
    
     public static Void numberOfCntsUndelete(list<contact> cntList	){
        
        set<id> accIds = new Set<id>();
            for(contact cnt : cntList){
                if(cnt.AccountId != null){
                  accIds.add(cnt.AccountId);
                    
                }
                                
            }
        
         list< account> accList= [SELECT id, name, Number_Of_Contacts__c,
                                  (SELECT id FROM Contacts) 
                                  FROM account WHERE id IN: accIds];
            
            for(account acc : accList){
                 acc.Number_Of_Contacts__c = acc.Contacts.size(); 
                
			}                         
                    update accList;     
        
    }
    
    
    
    
}