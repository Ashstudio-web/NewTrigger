public class AccountHandler implements ITrigger
{
//To do.. initialise a global variable to hold the list of contacts to be updated. Finally, perform DML update in the andFinally method.
private List<Contact> contactsToUpdate = new List<Contact>();

public void bulkBefore(){
system.debug('--- bulkbEfore is called');
}

public void bulkAfter() {
        if (Trigger.isUpdate) {
            Set<Id> accIds = new Set<Id>();
            Map<Id, Account> oldMap = (Map<Id, Account>) Trigger.oldMap;

            for (Account acc : (List<Account>) Trigger.new) {
                if (acc.Status__c != oldMap.get(acc.Id).Status__c) {
                    accIds.add(acc.Id);
                }
            }
            if (!accIds.isEmpty()) {
               contactsToUpdate.addAll(AccountHelper.updateChildContactsStatus(accIds, (Map<Id, Account>) Trigger.newMap));                
                
            }
        }
    }

public void afterInsert(SObject so){
system.debug('--- afterInsert is called');

}


public void beforeInsert(SObject so){
system.debug('--- beforeInsert is called');


}
public void beforeUpdate(SObject oldSo, SObject so){
system.debug('--- beforeUpdate is called');

}

public void beforeDelete(SObject so){
system.debug('--- beforeDelete is called');
}

public void afterUpdate(SObject oldSo, SObject so){
system.debug('--- afterUpdate is called');

}

public void afterDelete(SObject so){
system.debug('--- afterDelete is called');
}

public void andFinally() {
       if (!contactsToUpdate.isEmpty()) {
        update contactsToUpdate;
    }
}
}
