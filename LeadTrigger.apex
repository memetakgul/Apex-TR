trigger LeadTrigger on Lead (before insert , before update , before delete , after insert , after update, after delete, after undelete ){

    //If a new Lead is created or updated and if ‘Industry’ filed is null; Give a warning
    //validation
    
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { 
     
            //trigger tekrar eden codelar icerince OOP consept uygulanmali
            //HandlerClass     
        	//LeadTriggerHandler.industryControl(trigger.new);
        
        LeadTriggerHandler.industryValidation(trigger.new);
            
        
        }
        WHEN BEFORE_UPDATE  { 
       
        	//LeadTriggerHandler.industryControl(trigger.new);
        	
        LeadTriggerHandler.industryValidation(trigger.new);

        }
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   { }
        WHEN AFTER_UPDATE   { }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { 
            //When a lead record is Restored from a recycle bin, type 'Restored' in the console
            for(lead newLead : trigger.new){
                system.debug(newLead.id+' li record copten cikti!');
                //  after trigger icserisinde triggeri tetikleyen reocrd read only oldugu icin
               //  bu record icerisinde degisiklik yapilamaz
              //   newLed.description = 'Bu idli record çöpten çıktı!';
             // LeadTrigger: execution of AfterUndelete caused by: System.FinalException: Record is read-only Trigger.LeadTrigger: line 22, column 1
            }        
        }
 
    }
       
}




// ------------LeadTriggerHandler---------



public class LeadTriggerHandler {
	
    //When a new lead is created and updated, assign 'Education' if Industry field is null
    public static void industryControl(list<lead> leadList){
       
        for(lead newLd:leadList){
                if(newLd.Industry==null){//String.isBlank(newLd.Industry)
                    newLd.Industry='Education';
                }
            }
    } 
    
    
     //If a new Lead is created or updated and if ‘Industry’ filed is null; Give a warning
    //validation
    public static void industryValidation(list<lead> leadList){
       
        for(lead newLd:leadList){
                if(newLd.Industry==null){//String.isBlank(newLd.Industry)
                    //newLd.addError('Industry fieldi bos birakilamaz'); //Sayfa genelinde
                     newLd.Industry.addError('Industry fieldi bos birakilamaz'); //Field da hata gosterme
                }
            }
    } 
    
    
    
    
}
