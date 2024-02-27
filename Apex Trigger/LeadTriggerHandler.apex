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