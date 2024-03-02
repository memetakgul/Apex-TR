public class AsynchFutureMethod {

    @future
    public STATIC VOID mixedDmlKurtulma(string kullaniciIsimEmail    ){
        //@future method lar sObject almazlar 
        //Genllikle callout icin kullanilir
        //Mixed DML Exeption icin kullanilir.(setup ve system objectler(non-setup) ayni anda kullanilirsaa)
        account accNew = Utilities.accRecordOlustur();
        
        user newUser =   Utilities.userrecordOlusturur ( kullaniciIsimEmail, 'Soyismi*' , 'russellhigh01@gmail.com');
            
            try{
              insert newUser;
              insert  accNew;
                
             system.debug(newUser.id + '>>>' +  accNew.id  ) ;
                
            }catch(exception e){
               system.debug('HATA VAR!! >> '+ e.getMessage());
            }
        }
    
    
    
    
}

/////--Utilities Class--/////

public class Utilities {

    // bu method account recordu olusturmak icindir
    public static Account accRecordOlustur(){
        account acc = new Account();
        acc.Name = 'AAA mixedDMLException';
        return acc;
    }
    
    
    
    //bu method user olusturmak icindir
    public static USER userrecordOlusturur ( string userNameEmail , string UserLastName , string userEmail    ){
         User brandNewUsr= new User();
        brandNewUsr.Username = userNameEmail;
        brandNewUsr.LastName = UserLastName;
        brandNewUsr.Alias = 'AA mix';
        brandNewUsr.Email = userEmail;
        
        Profile prof= [SELECT id FROM Profile WHERE NAME='Standard Platform User NEWW' LIMIT 1];
        
        brandNewUsr.ProfileId = prof.id;
        brandNewUsr.LocaleSidKey = 'en_US';
        brandNewUsr.LanguageLocaleKey = 'en_US';
        brandNewUsr.EmailEncodingKey = 'UTF-8';
        brandNewUsr.TimeZoneSidKey = 'America/Los_Angeles';
        
        return brandNewUsr;
    }
    
    
    
}