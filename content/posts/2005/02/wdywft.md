---
date: "2005-02-22T18:05:00Z"
tags:
- coding
- test automation
- testing
- unit tests
title: What Do You Want From Tests?
---

<p> <strong>Automated tests are software</strong>. At first glance, this seems like a non-blinding non-flash of non-insight. But I'm learning a lot about testing by applying this non-insight mindfully.</p>
One thing I'm learning is how often I forget that automated tests are software. When I'm writing tests, I often neglect to apply all of the principles help me to write software well. What if I were to apply some of those principles mindfully?

A key principle is that <strong>we write software in order to serve some specific set of needs for some specific set of people</strong>.  When I'm trying to understand what software to write, I apply this principle in the form of a few questions:  <em>Whose needs will the software serve? What needs will trigger those people to interact with the software? What roles will the software play in satisfying those needs?</em>

Let's apply this principle to the tests we write:  <strong>Whose needs will these tests serve? What needs would trigger those people to interact with the tests? What roles will the tests play in satisfying those needs?</strong>

These days, I write software mostly for my own needs. And mostly I write the software alone. So the "whose needs" question is an easy one: When I write tests, I'm writing them mostly for me, for my own needs.

More enlightening for me—as a solo software developer writing tests solely for my own needs—are other questions. What needs trigger me to interact with the tests, either by running them or by reading test code? What roles do the tests play in satisfying those needs? Here's a partial list of answers:

I want to <em>know whether my software is ready to deliver.</em>
<ul>
	<li> I want test code to <strong>help me understand which parts of the system are tested and which are not.</strong></li>
</ul>
I want to <em>know whether there are defects in the software I'm writing.</em>
<ul>
	<li> I want tests to <strong>expose defects.</strong></li>
</ul>
I want to <em>know how to correct defects.
</em>
<ul>
	<li>I want tests to <strong>direct me to the defective part of the software.</strong></li>
</ul>
I want to <em>understand the meaning of the test results.</em>
<ul>
	<li> I want each test's code to <strong>indicate clearly how the test stimulates the software, and in what conditions.</strong></li>
</ul>
<ul>
	<li>I want test reports to <strong>describe the test stimulus, the relevant test conditions, and the software's response.</strong></li>
</ul>
When I'm adding a feature, I want to <em>know when I'm done.
</em>
<ul>
	<li>I want tests to <strong>tell me which of the feature's responsibilities the software fulfills, and which it does not.</strong></li>
</ul>
When I'm editing software, I want to <em>know whether my edits are having unintended effects.
</em>
<ul>
	<li>I want tests to <strong>detect changes in the behavior of the surrounding software.</strong></li>
</ul>
When I'm preparing to edit software, I want to <em>know what the existing code does</em>, so that I don't inadvertently break it.
<ul>
	<li>I want test code to <strong>describe clearly what the existing software does.</strong></li>
</ul>
That's a partial list needs for a single stakeholder. I'm sure you can think of additional needs that you have when you run tests or read test code, and additional ways that you want tests to help you satisfy those needs. And if we were to consider other people who might interact with our tests, we would discover even more needs. And then there are all of the people who do not interact with the tests and yet are affected by them.

That's a lot of stakeholders, and a lot of needs. I'm more likely to satisfy all of these people's needs (including my own) when I'm aware of what the needs are. And I'm more likely to be aware of the needs when I ask questions like the ones I've used here. And I'm more likely to ask these questions I remember that tests are software.

What do <em>you</em> want from tests?
