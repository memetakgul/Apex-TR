    
   trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {
  
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { 
            
        	for(Account acc : TRIGGER.NEW){
        		acc.rating ='Hot';
                acc.BillingState='ARKANSAS';
                
                if (acc.Industry==null){ //String.isBlank(acc.Insustry)
                    acc.Industry='Banking';
                }
            }
        }   
        WHEN BEFORE_UPDATE  { 
            /*
            // Eger accountun type kismi update ediliyor ise
            // ve accountun industry si bos ise
            // o zaman indusrty kismi education olsun
            
            // Version1--Olabildigince ic ice looplardan uzak dur.cok kaynak tuketiyor
            for(account accOld:trigger.old){
                for(account accNew:trigger.new){
                    if( (accOld.Type != accNew.type) && accNew.Industry==null){
                        accNew.Industry='Education';
                    }
                }
            }
            
            //Version2 ---Best Practice---
            for(account accNew:trigger.new){
             account accOld=trigger.oldMap.get(accNew.Id);//idsi verilen accountun eski halini getirir
                if( (accOld.Type != accNew.type) && accNew.Industry==null){
                        accNew.Industry='Education';
                    }
            }*/
            
            AccountTriggerHandler.industryCheck(trigger.new , trigger.oldMap);
            
            
            
        /*
            for(Account acc : TRIGGER.NEW){
                if(acc.Industry == null   ){ // String.isBlank(acc.Industry)
                     acc.Industry='Education';
                }
                
            }*/
        }
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   { 
            /*
            list <contact>cntList=new list <contact>();
            for(account acc2:trigger.new){
                contact cnt=new contact();
                cnt.LastName= 'Cnt of '+ acc2.name;
              	cnt.AccountId= acc2.id;   
                cntList.add(cnt);
            }
           insert cntList;  
            */
            
             AccountTriggerHandler.accRecursionExample(trigger.new);
            
            
            
        }
        WHEN AFTER_UPDATE   { }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { 
        
            list<id> accIdleri = new List<Id>();
            
         // yontem 1  
            for( account acc: trigger.new){
                
              accIdleri.add(acc.Id);                        
                
            } 
            
      // yontem 2
     SET<id> accIdleri2 = trigger.newMap.keySet();       
   
            // kodun ana kismi
            list<contact> cntList = [SELECT id,Description FROM contact 
                                     WHERE accountId IN: accIdleri2  ];               
            
            for(contact cnt : cntList ){
                
                cnt.Description = ' senin account copten cikti';
                
            }
            
     update cntList;            
        
        // calisan ama hatali sayilan kod    
            for(account acc: trigger.new){
                list<contact> cntList1 =[SELECT id ,Description FROM contact 
                                         WHERE accountId =: acc.id ];
                for(contact cnt : cntList1 ){
                   cnt.Description = ' senin account copten cikti';
  
                }
                update cntList1;
            }
            
            
        }
 
    }
        
}
    




 //   -----AccountTriggerHandler-------


 public class AccountTriggerHandler {

    public static void industryCheck(List<account> accList , Map<id,account> accOldMap){

        for(account accNew:accList){
            
             account accOld=accOldMap.get(accNew.Id);//idsi verilen accountun eski halini getirir
            
                if( (accOld.Type != accNew.type) && accNew.Industry==null){
                        
                    	accNew.Industry='Education';
                    }
            }    
	}
     
    
    static boolean flag=true;
  //static integer count = 0;  //kacta defa calismasini istiyorsak kullaniriz
  
    public static VOID accRecursionExample(list<account> accTriggerList   ){
        
        if( flag   ){
          flag= false;
            /*
              if( count < 3  ){
              count++;
            */
            
            //try catch ile de cozulur
               list<account> accList = new List<account>();
            for(account acc : accTriggerList){
                account accNew = new Account();
                accNew.Name=acc.name + ' yeni ';
               accList.add(accNew);
            }
           insert accList;
        }
    }
  
    
    
    
}