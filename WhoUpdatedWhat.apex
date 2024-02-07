/*
task: bir accountta herhangi bir update yapıldığında hangi fieldlerin kim tarafından 
ne zaman update edildiğini görmek istiyoruz.
cozum:
*/

trigger AccountFieldUpdateTrigger on Account (before update) {
    for (Account updatedAccount : Trigger.new) {
        Account oldAccount = Trigger.oldMap.get(updatedAccount.Id);
        String description = updatedAccount.Description != null ? updatedAccount.Description : '';
        
        // Tüm alanları kontrol et
        Map<String, Object> updatedFields = new Map<String, Object>();
        Schema.SObjectType accountType = Schema.getGlobalDescribe().get('Account');
        Map<String, Schema.SObjectField> fieldMap = accountType.getDescribe().fields.getMap();
        
        for (String fieldName : fieldMap.keySet()) {
            Object oldValue = oldAccount.get(fieldName);
            Object newValue = updatedAccount.get(fieldName);
            
            if (oldValue != newValue) {
                updatedFields.put(fieldName, newValue);
            }
        }
        
        // Eğer herhangi bir alan güncellendi ise Description alanını güncelle
        if (!updatedFields.isEmpty()) {
            String updateInfo = 'Bu hesapta şu alanlar güncellendi:\n';
            for (String fieldName : updatedFields.keySet()) {
                updateInfo += fieldName + ': ' + oldAccount.get(fieldName) + ' --> ' + updatedAccount.get(fieldName) + '\n';
            }
            
            // Güncelleme bilgisini Description alanına ekle
            description += '\n\n' + updateInfo + '\nGüncelleyen Kullanıcı: ' + UserInfo.getName() + '\nGüncelleme Tarihi: ' + Datetime.now();
            updatedAccount.Description = description;
        }
    }
}