@isTest
private class BirthdayEmailBatchTesta {

    @isTest
    static void testBatchExecution() {
        // Create test data
        List<Contact> testContacts = new List<Contact>();
        for(Integer i = 0; i < 10; i++) {
            testContacts.add(new Contact(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Birthdate = Date.today(),
                Email = 'test' + i + '@example.com'
            ));
        }
        insert testContacts;

        Test.startTest();

        // Start batch job
        BirthdayEmailBatch batchJob = new BirthdayEmailBatch();
        ID batchprocessId = Database.executeBatch(batchJob);

        Test.stopTest();

        // Verify that emails were sent
        Integer expectedEmailsSent = 10; // Assuming we created 10 test contacts with today's birthday
        List<EmailMessage> sentEmails = [SELECT Id FROM EmailMessage];
        System.assertEquals(expectedEmailsSent, sentEmails.size(), 'Incorrect number of emails sent');
    }

    @isTest
    static void testSchedulableExecution() {
        Test.startTest();

        // Schedule job
        BirthdayEmailBatch schedulable = new BirthdayEmailBatch();
        String sch = '0 0 0 * * ?'; // Run daily at midnight
        System.schedule('Test Birthday Email Batch Schedule', sch, schedulable);

        Test.stopTest();

        // Verify that the job is scheduled
        CronTrigger cron = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'Test Birthday Email Batch Schedule'];
        System.assertNotEquals(null, cron, 'Batch job not scheduled');
    }
}