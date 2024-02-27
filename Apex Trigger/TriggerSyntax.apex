trigger AccountTrigger on Account (before update) {

    for(Account acc : TRIGGER.NEW){
                    //TRIGGER.NEW triggeri tetikleyen acccountlarin listesi yeni hali
                    //TRIGGER.OLD triggeri tetikleyen acccountlarin listesi eski hali
        acc.name = acc.name+' $$$$';
        
    }
} 

      //En kapsamli kalip
    trigger XXXXXXTrigger on XXXXXX (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {
  
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { }
        WHEN BEFORE_UPDATE  { }
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   { }
        WHEN AFTER_UPDATE   { }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { }
 
    }
    
}

trigger XXXXXXTrigger on XXXXXX (before insert , before update , before delete , after insert , after update, after delete, after undelete) {
   
      if ( Trigger.IsBefore &&  Trigger.isInsert) { }
      if ( Trigger.IsBefore &&  Trigger.isUpdate) { }
      if ( Trigger.IsBefore &&  Trigger.isDelete) { }
      if ( Trigger.IsAfter  &&  Trigger.isInsert) { }
      if ( Trigger.IsAfter  &&  Trigger.isUpdate) { }
      if ( Trigger.IsAfter  &&  Trigger.isDelete) { }
      if ( Trigger.IsAfter  &&  Trigger.isUndelete) { }
   
    
}

trigger XXXXXXTrigger on XXXXXX (before insert , before update , before delete , after insert , after update, after delete, after undelete) {
 if ( Trigger.IsBefore ) {
        if ( Trigger.isInsert) { }
        if ( Trigger.isUpdate) { }
        if ( Trigger.isDelete) { }
    
 } 
    
 if ( Trigger.IsAfter ) {
        if ( Trigger.isInsert)   { }
        if ( Trigger.isUpdate)   { }
          if ( Trigger.isDelete)   { }
        if ( Trigger.isUndelete) { }
    
 }  
}



/*

trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {
  
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { 
        	for(Account acc : TRIGGER.NEW){
        		acc.rating ='Hot';
                acc.BillingState='ARKANSAS';
            }
        
        }
        WHEN BEFORE_UPDATE  { }
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   { }
        WHEN AFTER_UPDATE   { }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { }
 
    }
    
}

*/