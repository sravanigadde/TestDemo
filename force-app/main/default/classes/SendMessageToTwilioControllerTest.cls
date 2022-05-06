/**
 * Test class for the controller class SendMessageToTwilioController
 **/
@isTest
public class SendMessageToTwilioControllerTest {
    @testSetup 
    public static void setup() {
      
    }
        
    @isTest
    public static void getAccountDataTest(){
       Account acct  = new Account () ;
       acct.name ='Test Account';
       acct.phone = '+919886916030';
       acct.AnnualRevenue =3000000;
       acct.Annual_Revenue_Spent__c=400000;
       insert acct;
       System.debug('Account dedtails : '+acct);
       SendMessageToTwilioController.AccountDataWrapper acctWrapper =SendMessageToTwilioController.getAccountData(acct.Id);
       System.assertEquals(acct.name,acctWrapper.acctName);        
    }
    @isTest
     public static void sendSMSToAccountTest(){
           //Create custom setting
        API_details__c setting = new API_details__c();
        setting.Name = 'Twilio';
        setting.accountSID__c = 'ABC';
        setting.EndPointURL__c = 'https://api.twilio.com';
        setting.FromPhone__c = '+9188777656544';
        setting.Token__c = '12345';
        insert setting;
         
         Test.setMock(HttpCalloutMock.class, new MessagingServiceMock());
         Test.startTest();
         String msg =SendMessageToTwilioController.sendSMSToAccount('+919886916030');
         Test.stopTest();      
    }
     
}