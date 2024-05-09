trigger LeadTrigger on Lead (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {
  
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { 
        
            string chosenState;
           
            for(Lead ld:trigger.new){
                
                if(ld.State__c != null && ld.LeadSource == 'Website'){
                    
                    chosenState = ld.State__c;
                }
                
                ld.State = chosenState.split(':')[0];
            }
            
            
        
        
        }
        
        /*
        WHEN BEFORE_UPDATE  { }
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   { }
        WHEN AFTER_UPDATE   { }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { }
 		*/
    }
    
}