public class ContactTriggerHandler {
    
    
     //•In this Trigger scenario we are going to create a field called “Sales Repr” with data type (Text) on the account Object.
		//•When we create the Account record, the Account Owner will be automatically assigned to Sales Rep field. 
		//•When we update the Account owner of the record, then also the Sales Rep will be automatically updated.
        
    public static void salesRepUpdate(list<contact> cntList){    
        /*
          // 1. Yontem
          
            set<id> userIds = new Set<id>();
            for(contact cnt : trigger.new){
                if(cnt.OwnerId  != null){
                  userIds.add(cnt.OwnerId );                    
                }                              
            }
         
         list< user> userList= [SELECT id, FirstName, LastName FROM User WHERE id IN: userIds];           
            // ic ice for loop  mumkunse yapmayin mecbursak yapariz  
            for(contact cnt : trigger.new){
                for(user cntUser : userList){
                    if(cnt.OwnerId==cntUser.id){
                        cnt.Sales_Rep__c = cntUser.LastName+' '+cntUser.FirstName;
                    }
                } 
                
			}
		*/
                     
          //2. Yontem  ---Best Practice---
          
            set<id> userIds = new Set<id>();
            for(contact cnt : cntList){
                if(cnt.OwnerId  != null){
                  userIds.add(cnt.OwnerId );                    
                }                              
            }
            
         Map<id,user> userMap= new Map<id,user>([SELECT id, FirstName, LastName FROM User WHERE id IN: userIds] );
        	// eger user sayisi fazla degilse set e de ihtiyac yoktur 
        	
            for(contact cnt : cntList){
                user cntUser = userMap.get(cnt.OwnerId);
                 cnt.Sales_Rep__c = cntUser.LastName+' '+cntUser.FirstName;
			}
    
    }
    
    

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
    
    
    		//Your team uses Salesforce to manage customer accounts and contacts, and you want to ensure that 
            //all contacts associated with a particular account have the same phone number as the account.

    public static Void cntPhoneUpdate(list<contact> cntList){
            
        Map<id,account> accMap= new Map<id,account>([SELECT id,phone FROM Account]);
            
                for(contact cnt : cntList){
                    
                    if(cnt.AccountId != null){
                        
                        account acc = accMap.get(cnt.AccountId);
                        
                        if(acc.Phone != null){
                            
                            cnt.Phone=acc.Phone;
                        }
                    }
 
           		 }   
        
    }
    
    
    
    
    
    
    
    
    
    
    
}