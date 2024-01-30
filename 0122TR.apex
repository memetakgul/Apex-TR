public class SayiKontrol {

    
    
    public static string sayiKontrolMethod(integer sayi){
        string sonuc;
        if (sayi>0){
            sonuc = 'Elma';
        }else if (sayi<0){
            sonuc = 'Armut';
        }else {sonuc = 'Sifir';
              }   
        return sonuc;  
    }
    
   
}

//-----TEST CLASS----

@isTest //Apex e bu test class demek
public class SayiKontrolTest {

    @isTest //Alttaki method test methodu demektir
    STATIC VOID sayiKontrolMethodPozitifKontol(){
        
/*        //Eski Yontem
        string cevap1=SayiKontrol.sayiKontrolMethod(5);
        system.assertEquals('Elma', cevap1, 'Cevabin elma olmasi gerekiyor');
        
        string cevap2=SayiKontrol.sayiKontrolMethod(-3);
        system.assertEquals('Armut', cevap2, 'Cevabin armut olmasi gerekiyor'); 
        
        string cevap3=SayiKontrol.sayiKontrolMethod(0);
        system.assertEquals('Sifir', cevap3, 'Cevabin Sifir olmasi gerekiyor'); 
*/        
        //Yeni Yontem
        //https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_class_System_Assert.htm
        string cevap1=SayiKontrol.sayiKontrolMethod(5);
        Assert.areEqual('Elma', cevap1, 'Cevabin elma olmasi gerekiyor');
        
        string cevap2=SayiKontrol.sayiKontrolMethod(-3);
        Assert.areEqual('Armut', cevap2, 'Cevabin armut olmasi gerekiyor'); 
        
        string cevap3=SayiKontrol.sayiKontrolMethod(0);
        Assert.areEqual('Sifir', cevap3, 'Cevabin Sifir olmasi gerekiyor');
        
        
        
        
    }

	 @isTest //Alttaki method test methodu demektir
	STATIC VOID sayiKontrolMethodNegatifKontrol(){
        
/*        //Eski Yontem        
        string cevap1=SayiKontrol.sayiKontrolMethod(5);
        system.assertNotEquals('Armut', cevap1, 'Cevabin Armut cikmayacak, cevap Elma cikacak');
        
        string cevap2=SayiKontrol.sayiKontrolMethod(-3);
        system.assertNotEquals('Elma', cevap2, 'Cevabin Elma cikmayacak, cevap Armut cikacak');
        
        string cevap3=SayiKontrol.sayiKontrolMethod(-3);
        system.assertNotEquals('Sifir', cevap3, 'Cevabin Elma bveya Armut cikmayacak, cevap Sifir cikacak');
*/
        //Yeni Yontem
        string cevap1=SayiKontrol.sayiKontrolMethod(5);
        Assert.areNotEqual('Armut', cevap1, 'Cevabin Armut cikmayacak, cevap Elma cikacak');
        
        string cevap2=SayiKontrol.sayiKontrolMethod(-3);
        Assert.areNotEqual('Elma', cevap2, 'Cevabin Elma cikmayacak, cevap Armut cikacak');
        
        string cevap3=SayiKontrol.sayiKontrolMethod(-3);
        Assert.areNotEqual('Sifir', cevap3, 'Cevabin Elma bveya Armut cikmayacak, cevap Sifir cikacak');
    }

  
}

