public class AccountTriggerHandler {

        ////////----Recursion----///////
    
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
  
    
    // Eger accountun type kismi update ediliyor ise
    // ve accountun industry si bos ise
    // o zaman indusrty kismi education olsun
    
    public static void industryCheck(List<account> accList , Map<id,account> accOldMap){

        /*        
            // Version1--Olabildigince ic ice looplardan uzak dur.cok kaynak tuketiyor
            for(account accOld:trigger.old){
                for(account accNew:trigger.new){
                    if( (accOld.Type != accNew.type) && accNew.Industry==null){
                        accNew.Industry='Education';
                    }
                }
            }
            
		*/
        
        
            //Version2 ---Best Practice---
            
        for(account accNew:accList){
            
             account accOld=accOldMap.get(accNew.Id);//idsi verilen accountun eski halini getirir
            
                if( (accOld.Type != accNew.type) && accNew.Industry==null){
                        
                    	accNew.Industry='Education';
                    }
            }    
	}
     
    
    		/*
             Write a trigger on Account, when an account is inserted, automatically account billing
             address should populate into the account shipping address.
            When it comes to Account Billing and Shipping Address, we cannot 
            directly enter the values to the field Address because the Address is split into Street,
             City, State, PostalCode, and Country.
            */
    
    public static void shippingAdressUpdate(list <account> accList ){
        
        //SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry,  BillingAddress,
            //ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, ShippingAddress FROM Account
            
        for (account acc : accList){
                if(acc.BillingStreet != null){
                    if(acc.ShippingStreet == null){
                        acc.ShippingStreet = acc.BillingStreet;
                    }
                }               
                if(acc.BillingCity != null){
                    if(acc.ShippingCity == null){
                        acc.ShippingCity = acc.BillingCity;
                    }
                }
                if(acc.BillingState != null){
                    if(acc.ShippingState == null){
                        acc.ShippingState = acc.BillingState;
                    }
                }
                if(acc.BillingPostalCode != null){
                    if(acc.ShippingPostalCode == null){
                        acc.ShippingPostalCode = acc.BillingPostalCode;
                    }
                }
                if(acc.BillingCountry != null){
                    if(acc.ShippingCountry == null){
                        acc.ShippingCountry = acc.BillingCountry;
                    }
                }                              
            }
       
    }
            
            

	//Account olusturulurken eger ayni isimli bir account varsa izin verme error mesaji goster
    public static void accNameDublicate(list <account> accNameList){
        
         Set<String> accNames = new Set<String>();
             if (!accNameList.isEmpty()) {
                for (Account acc : accNameList) {
                accNames.add(acc.Name);
                }
             }
                               
                List<Account> accList = [SELECT Id, Name FROM Account WHERE Name IN :accNames];
                
                Map<String, Account> existingAccMap = new Map<String, Account>();
                
                if (!accList.isEmpty()) {
                    for (Account accObj : accList) {
                    existingAccMap.put(accObj.Name, accObj);
                    }
                }
                
                    if (!accNameList.isEmpty()) {
                        for (Account existingAcc : accNameList) {
                            if (existingAccMap.containsKey(existingAcc.Name)) {
                            existingAcc.addError('Account name already exists');
                            }
                        }
                    }    
    }
    
    
            
         //•Create a filed named ‘Old Phone’ on account object
		//•Whenever phone field is updated on Account record
		//•Then Old Phone filed should also get updated with old version of phone number on account
          
    public static void oldPhoneSaving (list <account> accList, Map<id,account> oldMap){
        
        for(account acc : accList){
                
             Account oldAcc=oldMap.get(acc.id);
                
                if(acc.Phone!=oldAcc.Phone){
                    
                    //acc.Old_Phone__c = oldAcc.Phone != null ? oldAcc.Phone + ', ' + acc.Phone : acc.Phone;  
                    
                    if( acc.Old_Phone__c != null && oldAcc.Old_Phone__c.length()<240){
                        acc.Old_Phone__c =oldAcc.Old_Phone__c+ ' , ' + oldAcc.Phone  ;
            
                    }else{
                           acc.Old_Phone__c = oldAcc.Phone ;
                          }               
                }
        }
    }
            
    
    
    	/*
             Write a trigger on the Account when the Account is updated check all opportunities related to the account.
             Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from 
            today and stage not equal to close won.
        */
        	
    public static void oppStageUpdate(Map<id,account> newMap){
        
        SET<id> accIdleri = newMap.keySet();       
              
        list<opportunity> oppList = [SELECT id, StageName,CreatedDate FROM opportunity 
                                     WHERE AccountId  IN: accIdleri ];
            
        list<opportunity> oppsToUpdate = new list<opportunity>();
            
            if(oppList != null){
                
                for (opportunity opp : oppList){
                
                    if(opp.CreatedDate.date().daysBetween(date.today())>30
                      && opp.StageName != 'Closed Won'){
                          
                        opp.StageName = 'Closed Lost';
                          oppsToUpdate.add(opp);
                    }               
            	}
        
            	update oppsToUpdate;
            }
              
    }
             
    
    
    
    
    
    
     
    
}