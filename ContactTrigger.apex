trigger ContactTrigger on Contact (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {
  
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  {
        
        //•In this Trigger scenario we are going to create a field called “Sales Repr” with data type (Text) on the account Object.
		//•When we create the Account record, the Account Owner will be automatically assigned to Sales Rep field. 
		//•When we update the Account owner of the record, then also the Sales Rep will be automatically updated.
        
          set<id> userIds = new Set<id>();
            for(contact cnt : trigger.new){
                if(cnt.OwnerId  != null){
                  userIds.add(cnt.OwnerId );                    
                }                              
            }
        
          // 1. Yontem
         
         list< user> userList= [SELECT id, FirstName, LastName FROM User WHERE id IN: userIds];           
            // ic ice for loop  mumkunse yapmayin mecbursak yapariz  
            for(contact cnt : trigger.new){
                for(user cntUser : userList){
                    if(cnt.OwnerId==cntUser.id){
                       // cnt.Sales_Rep__c = cntUser.LastName+' '+cntUser.FirstName;
                    }
                } 
                
			}
                     
          //2. Yontem  
         Map<id,user> userMap= new Map<id,user>([SELECT id, FirstName, LastName FROM User WHERE id IN: userIds] );
        	// eger user sayisi fazla degilse set e de ihtiyac yoktur 
        	
            for(contact cnt : trigger.new){
                user cntUser = userMap.get(cnt.OwnerId);
                 cnt.Sales_Rep__c = cntUser.LastName+' '+cntUser.FirstName;
			}
        
        }
        WHEN BEFORE_UPDATE  { }
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   { 
        
        	
    //Create a number of contacts field on the account and 
    //develop a trigger that updates this field on the account 
    //every time a new contact is created , updated, deleted , undeleted
    
    
    	ContactTriggerHandler.numberOfCntsCreate(trigger.new);
        
        
        }
        WHEN AFTER_UPDATE   { 
        
          ContactTriggerHandler.numberOfCntsUpdate(trigger.new,trigger.oldMap);

            
        }
        WHEN AFTER_DELETE   { 
        
        ContactTriggerHandler.numberOfCntsDelete(trigger.old);
        
        
        }
        WHEN AFTER_UNDELETE { 
        
        ContactTriggerHandler.numberOfCntsUndelete(trigger.new);
        
        }
 
    }

}