---
layout: post
title: That dreaded M in ASP.NET MVC
categories: []
tags:
- Architecture
- ASP.NET MVC
- Design
status: publish
type: post
published: true
meta:
  reddit: a:2:{s:5:"count";i:0;s:4:"time";i:1385704323;}
  tagazine-media: a:7:{s:7:"primary";s:53:"http://hhariri.files.wordpress.com/2011/01/image2.png";s:6:"images";a:14:{s:52:"http://hhariri.files.wordpress.com/2011/01/image.png";a:6:{s:8:"file_url";s:52:"http://hhariri.files.wordpress.com/2011/01/image.png";s:5:"width";s:3:"614";s:6:"height";s:3:"343";s:4:"type";s:5:"image";s:4:"area";s:6:"210602";s:9:"file_path";s:0:"";}s:58:"http://hhariri.files.wordpress.com/2011/01/image_thumb.png";a:6:{s:8:"file_url";s:58:"http://hhariri.files.wordpress.com/2011/01/image_thumb.png";s:5:"width";s:3:"474";s:6:"height";s:3:"265";s:4:"type";s:5:"image";s:4:"area";s:6:"125610";s:9:"file_path";s:0:"";}s:53:"http://hhariri.files.wordpress.com/2011/01/image1.png";a:6:{s:8:"file_url";s:53:"http://hhariri.files.wordpress.com/2011/01/image1.png";s:5:"width";s:3:"619";s:6:"height";s:3:"335";s:4:"type";s:5:"image";s:4:"area";s:6:"207365";s:9:"file_path";s:0:"";}s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb1.png";a:6:{s:8:"file_url";s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb1.png";s:5:"width";s:3:"490";s:6:"height";s:3:"265";s:4:"type";s:5:"image";s:4:"area";s:6:"129850";s:9:"file_path";s:0:"";}s:53:"http://hhariri.files.wordpress.com/2011/01/image2.png";a:6:{s:8:"file_url";s:53:"http://hhariri.files.wordpress.com/2011/01/image2.png";s:5:"width";s:3:"617";s:6:"height";s:3:"462";s:4:"type";s:5:"image";s:4:"area";s:6:"285054";s:9:"file_path";s:0:"";}s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb2.png";a:6:{s:8:"file_url";s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb2.png";s:5:"width";s:3:"354";s:6:"height";s:3:"265";s:4:"type";s:5:"image";s:4:"area";s:5:"93810";s:9:"file_path";s:0:"";}s:53:"http://hhariri.files.wordpress.com/2011/01/image3.png";a:6:{s:8:"file_url";s:53:"http://hhariri.files.wordpress.com/2011/01/image3.png";s:5:"width";s:3:"614";s:6:"height";s:3:"424";s:4:"type";s:5:"image";s:4:"area";s:6:"260336";s:9:"file_path";s:0:"";}s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb3.png";a:6:{s:8:"file_url";s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb3.png";s:5:"width";s:3:"384";s:6:"height";s:3:"265";s:4:"type";s:5:"image";s:4:"area";s:6:"101760";s:9:"file_path";s:0:"";}s:53:"http://hhariri.files.wordpress.com/2011/01/image4.png";a:6:{s:8:"file_url";s:53:"http://hhariri.files.wordpress.com/2011/01/image4.png";s:5:"width";s:3:"464";s:6:"height";s:3:"480";s:4:"type";s:5:"image";s:4:"area";s:6:"222720";s:9:"file_path";s:0:"";}s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb4.png";a:6:{s:8:"file_url";s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb4.png";s:5:"width";s:3:"367";s:6:"height";s:3:"380";s:4:"type";s:5:"image";s:4:"area";s:6:"139460";s:9:"file_path";s:0:"";}s:62:"http://hhariri.files.wordpress.com/2011/01/snaghtmlaa90b6d.png";a:6:{s:8:"file_url";s:62:"http://hhariri.files.wordpress.com/2011/01/snaghtmlaa90b6d.png";s:5:"width";s:3:"328";s:6:"height";s:3:"480";s:4:"type";s:5:"image";s:4:"area";s:6:"157440";s:9:"file_path";s:0:"";}s:68:"http://hhariri.files.wordpress.com/2011/01/snaghtmlaa90b6d_thumb.png";a:6:{s:8:"file_url";s:68:"http://hhariri.files.wordpress.com/2011/01/snaghtmlaa90b6d_thumb.png";s:5:"width";s:3:"360";s:6:"height";s:3:"527";s:4:"type";s:5:"image";s:4:"area";s:6:"189720";s:9:"file_path";s:0:"";}s:53:"http://hhariri.files.wordpress.com/2011/01/image5.png";a:6:{s:8:"file_url";s:53:"http://hhariri.files.wordpress.com/2011/01/image5.png";s:5:"width";s:3:"614";s:6:"height";s:3:"442";s:4:"type";s:5:"image";s:4:"area";s:6:"271388";s:9:"file_path";s:0:"";}s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb5.png";a:6:{s:8:"file_url";s:59:"http://hhariri.files.wordpress.com/2011/01/image_thumb5.png";s:5:"width";s:3:"368";s:6:"height";s:3:"265";s:4:"type";s:5:"image";s:4:"area";s:5:"97520";s:9:"file_path";s:0:"";}}s:6:"videos";a:0:{}s:11:"image_count";s:2:"14";s:6:"author";s:7:"5078411";s:7:"blog_id";s:8:"11677451";s:9:"mod_stamp";s:19:"2011-01-02
    11:33:50";}
  _elasticsearch_indexed_on: '2011-01-02 11:33:50'
comments: true
---
<p>When it comes to working with Models in MVC, I’ve tried many approaches, some good, others not so much. I’ve ended up settling on ViewModels, whereby the Model I submit is dictated by the View I’m working with. This allows me the flexibility of displaying or gathering only the information I need. It also allows me to provide additional information on the view that isn’t necessarily required by my domain. </p> <p>It works, but it also adds a lot of friction. Be it mapping, be it validation, it’s continuously repeating same processes over and over again. Even automating some of this still requires constant set up. Every time I work with ASP.NET MVC, I dread having to deal with all this. Way too much friction. </p> <p>I’ve often wondered whether I’m overly complicating myself by trying to add so much flexibility. I mean if the Rails guys can work with ActiveRecord, why can’t I? Granted that maybe much of the drawbacks of ActiveRecord can be remedied in some way in Rails because of Ruby being a dynamic language and allowing for things such as Mixins, but still, what about the other stuff? The mapping to an actual domain model. What happens when they need a list of countries? What happens when they have to update only 2 out of 7 fields of their domain model? </p> <p>I decided to ask <a href="http://twitter.com/ironshay">Shay</a> how he works. As a guy who works with both ASP.NET MVC and Rails, and has written a book on <a href="http://www.amazon.com/IronRuby-Unleashed-Shay-Friedman/dp/0672330784">IronRuby</a>, I thought he’d be a good candidate. Plus, he’s a nice guy. </p> <p>I have to say I wasn’t really surprised by his answer. He binds directly to his Domain Model in ASP.NET MVC. I asked how he dealt with additional info: Html Helpers. I asked how he solved partial updates: In the controller. Although, not surprising, it was interesting. As a guy that’s worked heavily in Rails, he seems to cope fine with this approach in C#. </p> <p>So again I wonder, am I focusing on too much flexibility? I decided to ask others by running a quick survey on Twitter asking how people worked with M in MVC. </p> <p>1. First the disqualifying question. Are you using Strongly-Typed views?</p> <p><a href="http://hhariri.files.wordpress.com/2011/01/image.png"><img style="display:inline;border-width:0;" title="image" border="0" alt="image" src="http://hhariri.files.wordpress.com/2011/01/image_thumb.png" width="474" height="265"></a> </p> <p>98% voted they are. I’m guessing more than 2 people were not, but since the Survey was focused on strongly-typed views, they probably didn’t take part.</p> <p>2. Now the question to see if I am the odd one out using ViewModels</p> <p><a href="http://hhariri.files.wordpress.com/2011/01/image1.png"><img style="display:inline;border-width:0;" title="image" border="0" alt="image" src="http://hhariri.files.wordpress.com/2011/01/image_thumb1.png" width="490" height="265"></a> </p> <p>Apparently not. 78% of people use ViewModels. </p> <p>3. The next question was how one deals with only partially updating some fields of a Domain Model if binding directly to them.</p> <p><a href="http://hhariri.files.wordpress.com/2011/01/image2.png"><img style="display:inline;border-width:0;" title="image" border="0" alt="image" src="http://hhariri.files.wordpress.com/2011/01/image_thumb2.png" width="354" height="265"></a> </p> <p>4. What about that damn list of countries? </p> <p><a href="http://hhariri.files.wordpress.com/2011/01/image3.png"><img style="display:inline;border-width:0;" title="image" border="0" alt="image" src="http://hhariri.files.wordpress.com/2011/01/image_thumb3.png" width="384" height="265"></a> </p> <p>(I’ve actually found another way to solve this problem, partially based on conventions, and we might even build it in to <a href="http://github.com/hhariri/AutoReST">AutoReST</a>. But that’s for another post).</p> <p>5. Key question the following. Mappings (read friction). If you use ViewModels, do you manually map information or use something like AutoMapper? </p> <p><a href="http://hhariri.files.wordpress.com/2011/01/image4.png"><img style="display:inline;border-width:0;" title="image" border="0" alt="image" src="http://hhariri.files.wordpress.com/2011/01/image_thumb4.png" width="367" height="380"></a> </p> <p>Surprised by the number of people doing manual mapping. You would think that if AutoMapper’s only responsibility is to do mapping for you, why not use it? Could it be again the same issue? Too much friction to setup? NuGet to the rescue? Too much ceremony? </p> <p>6. Here’s another one. Validation.</p> <p><a href="http://hhariri.files.wordpress.com/2011/01/snaghtmlaa90b6d.png"><img style="display:inline;border-width:0;" title="SNAGHTMLaa90b6d" border="0" alt="SNAGHTMLaa90b6d" src="http://hhariri.files.wordpress.com/2011/01/snaghtmlaa90b6d_thumb.png" width="360" height="527"></a></p> <p>So pretty much everyone (79%), some way or other has to deal with decorating their models with attributes. </p> <p>7. Finally, I was curious how people felt in general with the development process. Did they also encounter friction?</p> <p><a href="http://hhariri.files.wordpress.com/2011/01/image5.png"><img style="display:inline;border-width:0;" title="image" border="0" alt="image" src="http://hhariri.files.wordpress.com/2011/01/image_thumb5.png" width="368" height="265"></a> </p> <p>Not surprisingly, 70% find some level of friction in doing web development. </p> <h3>Conclusions</h3> <p>First off, this is not a stab at ASP.NET MVC. If you take it like that, you’re barking up the wrong tree. I’m sure in one way or another, any platform or language has a certain level of friction when it comes to developing applications. No, this is more of a self-stabbing. </p> <p>I also agree that on the whole, there’s too much friction. However, I’m not sure how much of that friction is caused by the platform vs the mentality of us developers to think big and try to build in so much unneeded flexibility. Are we really applying YAGNI? Are we really applying KISS? Maybe adding so much flexibility in terms of ViewModels because, and I quote, “<em>when dealing with complex scenarios, simple approaches fall apart” </em>only actually solve a 5% edge case that could be remedied in a different way. </p> <p>Maybe we should stop being afraid of trying to be too strict and not flexible enough. Maybe we should take the concept of conventions more seriously than just what folders our Views, Controllers and Models reside in. Maybe we should push conventions to the limit and see if we actually reduce this friction. </p> <p>And that’s the next journey I’m going to embark on. It might be time to drop the ViewModel, it might not be. What I do know is that writing good software shouldn’t be so complex. </p>