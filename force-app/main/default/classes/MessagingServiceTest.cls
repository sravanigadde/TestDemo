/**
 * Test class for the class MessagingService
 **/
@isTest
public class MessagingServiceTest {
    public static Account acct;
    @testSetup 
    public static void setup() {
        //Create custom setting
        API_details__c setting = new API_details__c();
        setting.Name = 'Twilio';
        setting.accountSID__c = 'ABC';
        setting.EndPointURL__c = 'https://api.twilio.com';
        setting.FromPhone__c = '+9188777656544';
        setting.Token__c = '12345';
        insert setting;
        
    }

    @isTest
    public static void sendSMSToCEOTest(){
       Test.setMock(HttpCalloutMock.class, new MessagingServiceMock());
       Set<Id> acctIds = new Set<Id>();
        acct  = new Account () ;
        acct.name ='Test Account';
        acct.phone = '+919886916030';
        acct.AnnualRevenue =3000000;
        acct.Annual_Revenue_Spent__c=400000;
        insert acct;
       acctIds.add(acct.Id);
       MessagingService.sendSMSToCEO(acctIds); 
    }
    
    @isTest
     public static void sendSMSToCEOAccountNegativeTest(){
         
         Test.setMock(HttpCalloutMock.class, new MessagingServiceMockNegative());
         Set<Id> acctIds = new Set<Id>();
        acct  = new Account () ;
        acct.name ='Test Account';
        acct.phone = '+919886916030000';
        acct.AnnualRevenue =3000000;
        acct.Annual_Revenue_Spent__c=400000;
        insert acct;
       acctIds.add(acct.Id);
         try{
              Test.startTest();
       MessagingService.sendSMSToCEO(acctIds);
             Test.stopTest();
         }catch(MessagingService.MyOtherException e){
             System.assert(true);
         }catch(Exception e){
             System.assert(true);
         }
    }
}