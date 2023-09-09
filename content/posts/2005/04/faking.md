---
date: "2005-04-14T20:20:00Z"
tags:
- coding
- test automation
- unit testing
title: The Unbearable Lightness of Faking
---

<p>If you want to test class in isolation, but the class works with a collaborator, you may need to provide a fake collaborator for the class to work with. A fake collaborator provides useful isolation in two directions:</p>

<ul>
	<li>It isolates the test from the quirks of the real collaborators. This makes failures more informative: If the test fails, the fault is likely in the test subject, and not in the collaborator.</li>
	<li>It isolates the real collaborators from the test. This is important if the real collaborator is, say, the corporate accounts receivable database. You don't want your tests messing with that.</li>
</ul>
Fake collaborators often provide other benefits over real collaborators.  One benefit is that <strong>fake collaborators increase testability by increasing your control over the test subject's environment.</strong> It's usually easier to set up a fake collaborator to feed your test subject a particular data value than to set up the real collaborator to do the same thing. And if the real collaborator takes a long time to do its work, you can gain control over the speed of the test by writing a fake collaborator that takes essentially no time at all.

<strong>Fake collaborators also increase testability in another way: They give you greater visibility into the results produced by the test subject.</strong> Sometimes it's difficult or time consuming to observe what data the test subject delivered to a real collaborator. If you write a fake collaborator, it's easy to instruct it to remember the data that the test subject delivered. And it's easy to gain access to that information so that you can compare it to your expectations.

I've identified a number of jobs that I often want fake collaborators to do for me when I'm writing tests. Each of these jobs helps me to gain control over the test environment or visibility into the test results.
<ol>
	<li> <strong>Fill in an argument to a method call.</strong> Suppose the test subject requires me to pass an argument to it—either through the constructor or through the method I'm testing—but the argument is never used during the test. In this case, all I need the "collaborator" to do is to fill in a value in the method call. If that's all I need, I can pass <code>null</code>.</li>
	<li> <strong>Accept calls from the test subject.</strong> If the test subject calls the collaborator's methods, but test doesn't care what the collaborator does, I can write a fake collaborator with dummy methods. If the interface specifies that a method doesn't need to return anything, I can simply write a dummy method with an empty body. If the method must return a value, I can write the dummy method to return a simple default value, such as <code>0</code>, <code>null</code>, or <code>false</code>.  Objects like this, and similar objects with very simple default behavior, are often called <em>Null Objects.</em></li>
	<li> <strong>Provide inputs to the test subject.</strong>  Sometimes the test subject requires a value other than <code>0</code>, <code>null</code>, or <code>false</code> in order to run. And sometimes I'm writing a test to determine whether the test subject responds appropriately when it receives specific interesting values from its collaborators. In either case, I enhance the fake collaborator to store an appropriate value and deliver it to the test subject when called.</li>
	<li> <strong>Record outputs from the test subject.</strong> Sometimes I want to know whether the test subject send the right information to the collaborator. I can write the fake collaborator's methods to store the inputs it receives from the test subject. And I can write accessor methods in the fake collaborator, if necessary, so that the test method can retrieve them.</li>
	<li> <strong>Verify outputs from the test subject.</strong> Sometimes it's useful to have the collaborator do the verification itself, rather than having the test retrieve values from the collaborator and verify them. When I want this, I can create a <em>mock object,</em> an object that has expectations and can verify them. I can either write my own mock objects, including the verification methods, or I can use one of the numerous mock object libraries that make mocking easier. I use the simple mock features that come with <a href="http://www.nunit.org/">NUnit</a>.</li>
	<li> <strong>Verify what methods the test subject calls.</strong> Sometimes I want to verify not only whether the collaborator received the right values, but also whether the test subject called all of the right methods. And sometimes I want to make sure the test subject does <em>not</em> call certain methods.  Mock object libraries typically provide ways to verify function calls.</li>
	<li> <strong>Verify the sequence in which the test subject calls method.</strong> Every now and then, I want to verify that the test subject not only called the right methods on the collaborator, but also called them in a specific order. This can be useful for testing protocols. Some mock libraries provide a way to verify the order of method calls. The NUnit mock library does not. When I need this feature, I often write a <em>logging</em> collaborator that simply writes each expected method call to a string and each actual call to another string. To verify whether the actual calls matched expectations, my test can direct the logging collaborator to compare the two strings.</li>
	<li> <strong>Collaborate fully.</strong> If the test somehow requires the full behavior of a real collaborator, I can use a real collaborator. So far, I haven't found a need for this when I'm trying to test classes in isolation. I do use real collaborators when my intention is to <a href="/dalecoding/2005/04/isolation">test the collaboration</a>, and not just one class or another.</li>
</ol>
I've numbered these features in order of <em>lightness</em>.  The lighter features are easier to create; the heavier features take more work.  <code>null</code> is the lightest collaborator of all, and the real collaborator is the heaviest.

My preference when writing tests is to <strong>use the lighest fake collaborator that gives me the visibility and control that I need for the purposes of my test.</strong>  This keeps my tests as light and flexible as they can be.

Often I start by passing the lightest collaborator of all, <code>null</code> to the test subject, and then wait for the test tell me when I need to add more behavior to the collaborator. If the test subject needs something other than null, I'll find out when I try to run the test and get a null reference pointer exception. Then I'll move to a Null Object. If the default values returned from the Null Object don't satisfy the test subject, the test usually signals that with an exception or failure of some kind, and I'll move to a heavier collaborator.

I call this approach <strong> <em>The Unbearable Lightness of Faking:</em> start with the lightest possible collaborator, and use it until the lightness becomes unbearable and I absolutely must switch to something heavier.</strong>
