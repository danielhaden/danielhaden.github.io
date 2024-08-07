<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>◊(hash-ref metas 'title)</title>
  <link rel="stylesheet" href="css/tufte.css"/>
  <link rel="stylesheet" href="css/joel.css"/>
  <link rel="alternate" type="application/atom+xml" title="Atom feed" href="feed.xml" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>daniel haden</title>

</head>

<body>
    <div id="header">
    <h1><a href="/">daniel haden</a></h1>
    <p>
      <a href="/">home</a>
      <a href="https://github.com/danielhaden">github</a>
      <a href="rss.xml">rss</a>
      <a href="https://www.linkedin.com/in/daniel-haden-87b2b3121/">linkedin</a>
    </p>
  </div>
  <div id="main">
    <h3>About Me</h3>
        ◊(map ->html (select-from-doc 'body here))

    <h4>Contact:</h4>
    <ul>
      <li>Email: firstname + lastname at protonmail.com
      <li>Github: <a href="https://github.com/danielhaden">https://github.com/danielhaden</a></li>
      <li>LinkedIn: <a href="https://www.linkedin.com/in/daniel-haden-87b2b3121">https://www.linkedin.com/in/daniel-haden-87b2b3121</a></li>
</ul>
    <h4>Projects:</h4>
    <ul>
      <li>New-Old Books Digital Library</li>
      <li>Antarctic TMA Videos</li>
      <li>Human Aided Machine Translation Software</li>
      <li>AI Art</li>
    
    <h4>Recent Articles</h4>
    <h4>Links:</h4>
    <ul>
      <li>Xorvoid</li>
      <li>Dmitrii Kovanikov</li>
	</ul>
   </div>
</body>
</html>
