@isTest
public class AccountHandler_Test {

@isTest
static void testBulkStatusUpdate() {
    
TriggerConfig__c triggerConfig = new TriggerConfig__c();
    triggerConfig.ApexHandler__c = 'AccountHandler';
    triggerConfig.IsActive__c = true;
    triggerConfig.Name = 'Account';
    insert triggerConfig;

    List<Account> accList = new List<Account>();
    for(Integer i=0; i<200; i++) {
    
        accList.add(new Account(Name = 'Test Acc ' + i, Status__c = ''));
    }
    insert accList; 

    Set<Id> accIds = new Set<Id>();
    List<Contact> conList = new List<Contact>();
    for(Account a : accList) {
        accIds.add(a.Id);
        conList.add(new Contact(LastName = 'Test Con ' + a.Name, AccountId = a.Id, Status__c = ''));
    }
    insert conList;

    // Step 2: ACT - Trigger Business Logic
    List<Account> updateAccList = [SELECT id,Status__c from Account where Id IN :accIds];
    for(Account a : updateAccList) {
        a.Status__c = 'New';
    }

    Test.startTest();
    update updateAccList; 
    Test.stopTest();

    // Step 3: VERIFY - Check if Child Contacts are now "Pending"
    List<Contact> updatedContacts = [SELECT Id, Status__c FROM Contact WHERE AccountId IN :accIds];
    
    System.assertEquals(200, updatedContacts.size(), '200 Contacts');
    System.assertEquals('New', updatedContacts[0].Status__c, 'Status Change');

}
}