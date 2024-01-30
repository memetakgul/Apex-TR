public class ClasslarCalisma {

    
    string oAdi='Mehmet';
    date dob;
    integer yas=0;
    string kurs='Muzik';
    string dersadi ='matematik';
    string isim='koca';
    string yasim;
    
public integer yasBulma(integer dTarihi){
        
        date bugun=Date.today();
        integer yearOfDate= bugun.year();
        
        yas=yearOfDate-dTarihi;
        
        return yas;
    }
    
    
    public string ders (string adi){
            this.dersadi=adi;
        return dersadi;
        }
    
    
    public string dersYas(string adi2, integer yas1){
          string sonuc;
        isim=adi2;
         yasim=yas1.format();// yada yasim=string.valueOf(yas1) de olur.
         sonuc=isim+yasim;
	return sonuc;
    }
    
    
    
    public static integer kursSuresi(integer s){
        
       integer aa=s+5;
           return aa;
    }
    
//Anonymous 

/*
 
Ders1 Ogrenci1=new Ders1();


integer sonuc=Ogrenci1.yasbulma(1987);

system.debug(sonuc);
system.debug(Ogrenci1.yasbulma(1987));


Ders1 hangiDers= new Ders1();
system.debug(hangiDers.ders('Edebiyat'));

Ders1 dersAd= new Ders1();
system.debug(dersAd.dersYas('Mahmut',20));



system.debug(Ders1.kursSuresi(20));

*/    

    ////Getter-Setter//////
    
//------I yontem------
    private string ad='memoli';
    
    public string Adgetir(){
        return ad;

    }
    
    /*Ders1 ornek=new Ders1();
system.debug(ornek.ad);
Ders1 ornek2=new Ders1();
system.debug(ornek2.Adgetir());
*/
    
 public void setGetir(string ad2){
       ad=ad2;
 }
    
/*
 Ders1 ornek3=new Ders1();
 ornek3.setGetir('mahmut');
 system.debug(ornek3.Adgetir());
*/
    
    //------II yontem-
    public static integer userInput{ get;set;}
    // sadece public de çalışır-private'da çalışmaz
/*
Ders1.userInput=5;
system.debug(Ders1.userInput);
*/
    
    //------III yontem------
private static integer ornekMember=5;
     public static Integer counter {
        get{
        	return ornekMember;
        }
        set{
            ornekMember = value;
        }
    
     }    
     
 /*
Ders1.counter=8;
system.debug(Ders1.counter);
*/   
//------ static olmadığı sürece getter-setter methodlarının anlamı yok    
    
    
    
    
    
}
