public with sharing class AccountHelper {

public static List<Contact> updateChildContactsStatus(Set<Id> accIds, Map<Id, Account> newMap) {

    List<Contact> finalResult = new List<Contact>();

    for (Contact ObjCont : [SELECT Id,AccountId,Status__c FROM Contact WHERE AccountId IN :accIds]) {

        if (newMap.containsKey(ObjCont.AccountId)) {
            ObjCont.Status__c = newMap.get(ObjCont.AccountId).Status__c;
            finalResult.add(ObjCont);
        }
    }
    return finalResult;
}
}