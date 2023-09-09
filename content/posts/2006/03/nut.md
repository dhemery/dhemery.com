---
date: "2006-03-27T16:05:00Z"
tags:
- coding
- naming
- test automation
- unit testing
title: Naming Unit Tests
---

<p>Last year I read <a href="http://www.agileprogrammer.com/oneagilecoder/">Brian Button's</a> wonderful article "Double Duty" in <em>Better Software</em> magazine (the February, 2005 issue). One of the things I learned is that Brian is the world's best namer of unit tests. I visited Brian's web site for more of his ideas and found an article called "<a href="http://www.agileprogrammer.com/oneagilecoder/archive/2005/03/27/3078.aspx">TDD Defeats Programmer's Block—Film at 11</a>." In this article, Brian describes using the Test Driven Development process to write a "continuous integration system" (a tool that automatically (re)builds software systems when programmers change the source code). Here are some examples of his unit test names:</p>

<ul>
	<li>Starting Build With No Previous State Only Starts Build For Last Change</li>
	<li>Previous Build Number Is Incremented After Successful Started Build</li>
	<li>Last Build Failing Leaves Last Build Set To Previous Build</li>
</ul>
What makes these names so good?  I analyzed a few dozen of Brian's test names and found this pattern:  <strong>stimulus and result in context</strong>.  Let's examine these names to identify the parts.

<strong>Starting Build With No Previous State Only Starts Build For Last Change</strong>:
<ul>
	<li>Context:  There is no previous state (i.e. no previous builds were done).</li>
	<li>Stimulus:  Start a build.</li>
	<li>Result:  A build was started for only the last change.</li>
</ul>
<strong>Previous Build Number Is Incremented After Successful Started Build</strong>:
<ul>
	<li>Context:  There were zero or more previous builds.</li>
	<li>Stimulus:  Request a build that will succeed.</li>
	<li>Result:  The build number is one more than before the build.</li>
</ul>
<strong>Last Build Failing Leaves Last Build Set To Previous Build</strong>:
<ul>
	<li>Context:  There were previous builds, the most recent of which is recorded in the system as the last build.</li>
	<li>Stimulus:  Request a build that will fail.</li>
	<li>Result:  The previously identified last build is still identified as the last build.</li>
</ul>
One of Brian's tests from a different system—an "animal factory" (a concept better left unexplained)—is called <strong>Default Animal Is Cow</strong>.
<ul>
	<li>Context:  No animal type has been identified as the desired type of animal for the system to manufacture.</li>
	<li>Stimulus:  Request that the system manufacture an animal.</li>
	<li>Result:  A new cow exists.</li>
</ul>
Now that I've learned the pattern that makes Brian's test names so useful, I can use it deliberately.  <strong>Using the context-stimulus-result scheme increases the value of tests as documentation.</strong> The resulting names make clear what specifically is being tested and under what specific conditions. This helps the reader to understand quickly what each test does, and what is covered by each set of tests.

Another benefit is that <strong>the context-stimulus-result naming scheme encourages you to clarify your thinking about each test.</strong> Each unit test establishes some set of starting conditions, or context. Each stimulates the system. Each compares the result to a desired result. In order to name these elements you will have to think about the specifics of each and clarify them well enough that you can describe each in a few words.

If you're having difficulty naming a test using this scheme, that may indicate a problem in your test. Perhaps the test is doing too much work, or your test suite is doing too little. For example, suppose you're testing software to manage bank accounts, and one test is called <em>Withdrawal Test</em>. We can tell from this name that the test tests the withdrawal feature in some way. But we don't know what specific aspects of withdrawals this test is testing.

Does <em>Withdrawal Test</em> test only that a withdrawal of less than the account balance reduces the balance by the proper amount? If so, calling this test "Withdrawal Test" may indicate that your suite of tests for the withdrawal feature is missing many important test cases. The name of the test gives readers an overly broad sense of what the test actually tests.

Does <em>Withdrawal Test</em> test a score of different stimuli under a dozen different conditions? If so, it's probably doing too much work. The name of the test does not quickly tell readers what is being tested.

Whether <em>Withdrawal Test</em> is doing too much work or too little, we can improve the test by applying the context-stimulus-result scheme.  If <em>Withdrawal Test</em> is doing too much, we can use the scheme to identify how to break the test into smaller, more focused tests with more descriptive names. If <em>Withdrawal Test</em> tests only one tiny aspect of withdrawals and leaves other aspects untested, we can use the scheme to create a better name for the test and to identify other tests to write.
