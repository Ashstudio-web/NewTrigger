public with sharing class ContactHelper {

    public static List<Account> updateAccountDescription(Set<Id> accIds) {
        List<Account> accountsToUpdate = new List<Account>();

        for (Account acc : [SELECT Id, Description,
                           (SELECT Name FROM Contacts ORDER BY CreatedDate DESC LIMIT 1)
                           FROM Account WHERE Id IN :accIds]) {

            if (!acc.Contacts.isEmpty()) {
                acc.Description = 'Latest Contact: ' + acc.Contacts[0].Name;
                accountsToUpdate.add(acc);
            }
        }
        return accountsToUpdate;
    }
}