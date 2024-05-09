@isTest
private class OppReminderEmailBatchTest {
    @isTest
    static void testOppReminderEmailBatch() {
        
        // Create test data: Opportunity with close date 3 days from now
        Opportunity testOpp = new Opportunity(
            Name = 'Test Opp',
            CloseDate = Date.today().addDays(3),
            StageName = 'Prospecting'
        );
        insert testOpp;
        
        // Create test user
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = 'testuser@example.com',
            Alias = 'tuser',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            ProfileId = UserInfo.getProfileId()
        );
        
        //insert testUser; 
        // (User i insert ettigimizde DML hatasi aliyoruz, O yuzden insert etmeden test ediyoruz.)

         Test.startTest();

        // Start batch job
        OppReminderEmailBatch batchJob = new OppReminderEmailBatch();
        ID batchprocessId = Database.executeBatch(batchJob);

        Test.stopTest();

        // Verify that emails were sent
        Integer expectedEmailsSent = 1; 
        List<EmailMessage> sentEmails = [SELECT Id FROM EmailMessage];
        System.assertEquals(expectedEmailsSent, sentEmails.size(), 'correct number of emails sent');
    }

    @isTest
    static void testSchedulableExecution() {
        Test.startTest();

        // Schedule job
        OppReminderEmailBatch schedulable = new OppReminderEmailBatch();
        String sch = '0 0 0 * * ?'; // Run daily at midnight
        System.schedule('Test Opp Reminder Email Batch Schedule', sch, schedulable);

        Test.stopTest();

        // Verify that the job is scheduled
        CronTrigger cron = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'Test Opp Reminder Email Batch Schedule'];
        System.assertNotEquals(null, cron, 'Batch job not scheduled');
    }
}