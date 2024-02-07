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