@isTest
public class OpportunityTriggerHelperTest {
    
     @testSetup 
    public static void setup() {
        //Create custom setting
        Triggers__c triggerSetting = new Triggers__c();
        triggerSetting.Name = 'Opportunity';
        triggerSetting.Enable_Trigger__c = true;
        insert triggerSetting;
        API_details__c setting = new API_details__c();
        setting.Name = 'Twilio';
        setting.accountSID__c = 'ABC';
        setting.EndPointURL__c = 'https://api.twilio.com';
        setting.FromPhone__c = '+919886916030';
        setting.Token__c = '12345';
        insert setting;
        
    }


    @isTest
    public static void setAccountIdsTest() {
        //Create account/opportunities
        Set<Id> acctIds = new Set<Id>();
        Account acct  = new Account () ;
        acct.name ='Test Account';
        acct.phone = '+919886916030';
        acct.AnnualRevenue =3000000;
        insert acct;
        Opportunity opp = new Opportunity();
        opp.Name='Test Opp';
        opp.Amount = 51000;
        opp.CloseDate = System.today();
        opp.StageName='Prospecting';
        opp.AccountId=acct.Id;
        insert opp;
        opp.StageName = 'Closed Won';
        Test.setMock(HttpCalloutMock.class, new MessagingServiceMock());
        update opp;
    }
}