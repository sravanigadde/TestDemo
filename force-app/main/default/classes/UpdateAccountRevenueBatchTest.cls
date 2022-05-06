@isTest
public class UpdateAccountRevenueBatchTest {

     @isTest
    public static void executeBatchTest() {
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
        opp.StageName = 'Closed Won';
        opp.AccountId=acct.Id;
        insert opp;
        Test.setMock(HttpCalloutMock.class, new MessagingServiceMock());
        UpdateAccountRevenueBatch b = new UpdateAccountRevenueBatch();
        Database.executeBatch(b);
        
    }
}