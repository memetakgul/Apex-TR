public class ContactSayilari {

       // id is verilen accountun contact sayisini donunuz
       
       // public static integer contactSayisi( String accId){
       
    @testVisible //method sadece test class icin visible olur
    private static integer contactSayisi( String accId){
        integer contactSayisi;
        // kod yaziniz
        string gelenId=accId;
        if( accId.length() == 18  ){
           
            contactSayisi= [SELECT COUNT() FROM Contact WHERE AccountId = :gelenId];
            
        }else {
            contactSayisi=-1;
        }
      
        if(contactSayisi == null  ){
           
            contactSayisi = -1;
        }
        
        
        return contactSayisi;
    }
    
    // id is verilen accountun contact Listesini donunuz
     public static List<contact> contactListesi( string accId){
        
        List<contact> cntList = new List<contact>();
         // koda yaziniz
         
         if(accId.length() == 18  ){
           cntList = [SELECT id,lastName FROM Contact WHERE accountId =: accId ORDER BY lastName DESC];
             				//ORDER BY ile sirali gelen liste kiyaslamada kullanmak icin 
        }else{
            cntList=null;
        }
         
         return cntList;
        
    }
        
    }


    ///******  1. yontem ****** ////
@isTest       // (SeeAllData = true)    buraya yazildiginda tum class icerisindeki methodlarin SF database ulasma izni verir
public class ContactSayilariTest {
// 1. yontem (SeeAllData = true)  diyerek SF data base ulasmak   ( TAVSIYE EDILMEZ)
    
    //ContactSayilari.contactSayisi(accId)
    
    @isTest(SeeAllData = true)    //eger method onuna yazilirsa sadece bu method SF data base ulasabilir 
    Private Static Void contactSayisiTest(){
        
       Account acc = [SELECT id FROM account WHERE name Like 'Burlington%']; 
    integer sonuc= ContactSayilari.contactSayisi(acc.id);
       
      system.assertEquals(1, sonuc, ' burlington textile contact sayisi 1 dir'); 
        
        
    }
    
     @isTest   
    Private Static Void contactListesiTest(){
        
   integer sonuc= ContactSayilari.contactSayisi('001Hu00002xfON2IAM');
       
      system.assertEquals(1, sonuc, ' burlington textile contact sayisi 1 dir'); 
        
    }
   
}


///******  2. yontem ****** ////
@isTest
public class ContactSayilariTest2 {
   
    
    @isTest
    Private Static Void contactSayisiTest(){
        // method icinde sahte bir DB olusturma, olusan recordlar rollback olur DB e kaydolmaz
      Account acc = new Account();
        acc.Name = 'XXX';
        insert acc;
        
      Contact cnt = new Contact();
        cnt.LastName = 'zz contatc of ' + acc.Name; 
        cnt.AccountId = acc.id;
       insert cnt; 
        
    integer sonuc= ContactSayilari.contactSayisi(acc.id);
      // NOT   normalde yukarda 1 adet contact olusturduk
      // ancak account trigger da after insert de account olusturuldugunda contact olusturan 
      // trigger var idi  bu yuzden toplamda 2 adet contact olustu.
      // NOT:  sizler test class yazarken orgda olan hemen her seyi bilmeniz gerekiyor
      // flowlar , triggerlar, validationlar etc. 
      system.assertEquals(2, sonuc, ' burlington textile contact sayisi 1 dir'); 
        
        
    }
    
     @isTest
    Private Static Void contactListTest(){
      Account acc = new Account();
        acc.Name = 'XXX';
        insert acc;
        
      Contact cnt = new Contact();
        cnt.LastName = 'zzzzzzz '; 
        cnt.AccountId = acc.id;
       insert cnt; 
        
    list<contact> cntList = ContactSayilari.contactListesi(acc.id);
       
      system.assertEquals(2, cntList.size(), 'contact sayisi 2 dir'); //iki liste kiyaslanirken size kiyaslanabilir.
      system.assertNotEquals('zzzzzzz ', cntList[0].lastName, 'last name sirasina gore 0. index zzzzzzz dir'); // ya da siralayip ilk eleman kiyaslanabilir.
        
        Assert.areEqual(2, cntList.size(), 'contact sayisi 2 dir');
        Assert.areNotEqual('zzzzzzz ', cntList[0].lastName, 'last name sirasina gore 0. index zzzzzzz dir');
        
        Assert.areNotEqual(1, cntList.size());
        Assert.areNotEqual('cnt of', cntList[0].lastname, '  last name sirasina gore listinein ilk elemani ZZZZZ last name li olmalidir');
    }
    
    
}


///******  3. yontem ****** ////----@testSetup---
@isTest 
public class ContactSayilariTest3 {
    
    @testSetup // classin icinde icinde sahte bir DB olusturma, DB den veri ceker gibi bu sahte DB den query ile cekeriz 
    static void sahteDataBase(){
        
        Account acc = new Account();
        acc.Name = 'XXX';
        insert acc;
        
      Contact cnt = new Contact();
        cnt.LastName = 'zzzzzzz ' ; 
        cnt.AccountId = acc.id;
       insert cnt;      
        
    }
    
  
    @isTest 
    Private Static Void contactSayisiTest(){
       //sahte DB de olan accountu query ile getirdik. 
        account acc = [SELECT id FROM account WHERE name Like 'XXX%'];
        
    integer sonuc= ContactSayilari.contactSayisi(acc.id);
      // NOT   normalde yukarda 1 adet contact olusturduk
      // ancak account trigger da after insert de account olusturuldugunda contact olusturan 
      // trigger var idi  bu yuzden toplamda 2 adet contact olustu.
      // NOT:  sizler test class yazarken orgda olan hemen her seyi bilmeniz gerekiyor
      // flowlar , triggerlar, validationlar etc. 
      system.assertEquals(2, sonuc, ' XXX contact sayisi 1 dir'); 
             
    }
    

     @isTest 
    Private Static Void contactListTest(){
      Account acc = new Account();
        acc.Name = 'XXX';
        insert acc;
        
      Contact cnt = new Contact();
        cnt.LastName = 'zzzzzzz '; 
        cnt.AccountId = acc.id;
       insert cnt; 
        
    list<contact> cntList = ContactSayilari.contactListesi(acc.id);
       
      system.assertEquals(2, cntList.size(), 'contact sayisi 2 dir'); //iki liste kiyaslanirken size kiyaslanabilir.
      system.assertEquals('zzzzzzz ', cntList[0].lastName, 'last name sirasina gore 0. index zzzzzzz dir'); // ya da siralayip ilk eleman kiyaslanabilir.
        
        Assert.areEqual(2, cntList.size(), 'contact sayisi 2 dir');
        Assert.areEqual('zzzzzzz ', cntList[0].lastName, 'last name sirasina gore 0. index zzzzzzz dir');
        
        Assert.areNotEqual(1, cntList.size());
        Assert.areNotEqual('cnt of', cntList[0].lastname, '  last name sirasina gore listinein ilk elemani ZZZZZ last name li olmalidir');
        
    }
    
    
}



//////   3. yontem------DATAFACTORY yontemi /////
@isTest
public class ContactSayilariTest4DF {
    
    
    @isTest
    Private Static Void contactSayisiTest(){
      Account acc = DataFactory.getAccount();
        
        insert acc;
        
      Contact cnt = DataFactory.getContact(  );
       cnt.LastName = 'ZZZZZZZ';
        cnt.AccountId = acc.id;
      
        insert cnt; 
        
    integer sonuc= ContactSayilari.contactSayisi(acc.id);
     
      system.assertEquals(2, sonuc, ' burlington textile contact sayisi 1 dir'); 
        
        
    }
    
    
    
     @isTest
    Private Static Void contactListTest(){ 
          
      Account acc = DataFactory.getAccount();
        
        Test.startTest() ;  //  governer limitleri sifirlamak icin kullanilir
        //  bir method icerisinde sadece bir defa Test.startTest() kullanilir
        insert acc;
        
      Contact cnt = DataFactory.getContact(  );
       cnt.LastName = 'ZZZZZZZ';
        cnt.AccountId = acc.id;
      
        insert cnt; 
      Test.stopTest(); //  governer limitleri sifirlamak icin kullanilir
        //  bir method icerisinde sadece bir defa Test.stopTest() kullanilir
        
    list<contact> cntList = ContactSayilari.contactListesi(acc.id);
       
      system.assertEquals(2, cntList.size(), 'contact sayisi 2 dir'); //iki liste kiyaslanirken size kiyaslanabilir.
      system.assertEquals('zzzzzzz ', cntList[0].lastName, 'last name sirasina gore 0. index zzzzzzz dir'); // ya da siralayip ilk eleman kiyaslanabilir.
        
        Assert.areEqual(2, cntList.size(), 'contact sayisi 2 dir');
        Assert.areEqual('zzzzzzz ', cntList[0].lastName, 'last name sirasina gore 0. index zzzzzzz dir');
        
        Assert.areNotEqual(1, cntList.size());
        Assert.areNotEqual('cnt of', cntList[0].lastname, '  last name sirasina gore listinein ilk elemani ZZZZZ last name li olmalidir');
        
    }
    
    
        /*Check if a test is running
    if( Test.isRunningTest() ) {
      //Run specific logic for Tests
    }
    //Check if test is NOT Running
    if(!Test.isRunningTest()){
            //Run specific logic that wont run in tests
    }
      */  
    
}

    /////-----DataFactory-----/////
    public class DataFactory {

    //genel bir tane Data Factory olur icinde record olusturan bir suru method vardir
    //Data Factory record olustururken manuel olan fieldlar verilir loopup gibi fieldlar verilmez
    
    
   // data for account
	public static Account getAccount(){
        
        Account acc = new Account();
        acc.name = 'ZZZ';
        acc.Phone = '1234567';
        
        return acc;
        //method return olarak olusan recordu doner 
    }
    
  // data for contact
    public static Contact getContact(  ){
        
        Contact cnt = New Contact();
         cnt.LastName = 'aaaaa';
        cnt.MobilePhone = '1234';
        
        return cnt;
        //method return olarak olusan recordu doner 
    }  
    
    
}
    

