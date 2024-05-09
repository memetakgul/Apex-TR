@isTest
public class LeadTriggerTest {

    @isTest
    Private Static Void leadStateTest(){ 
        
        Lead ld = DataFactory.getLead();
        
        Test.startTest();
        
                insert ld;
        
        Test.stopTest();
        
        Assert.areEqual('Website', ld.LeadSource, 'Lead source-Website');
        Assert.areNotEqual('zzzzzzz ', ld.LastName, 'last name is  zzzzzzz ');
        
        Assert.areEqual('AZ', ld.State, 'Lead State-AZ');
        Assert.areNotEqual('AL: Alabama ', ld.State__c, 'State is  AL: Alabama ');
    }
}