# Example Project to Learn Frontend Web Development

This folder contains a sample blog website to show various aspects of HTML and CSS.

If you want to implement this from scratch, I'd recommend the following order:

- Create the sample HTML content.
  - Emmet abbreviations are you friend.
    You can use `html:5` to generate the basic structure of the website.
    Then, use abbreviations like `article*5>h1+p*3>lorem` to generate various placeholder articles.
- Create some basic CSS styles: remove `body`'s default margin, change the background and text colors.
- Add a custom font. I recommend using [Google Fonts](https://fonts.google.com) for this.
- Use flexblock and/or CSS Grid to position elements wherever you want them.

## Further Learning

This is a really simple website that doesn't do much.
Here are some ways you can improve it:

- We have just a single page.
  Wouldn't it be awesome to have a page for the articles themselves? Feel free to create one or two.  
  This should raise another problem though: as you've probably noticed, you're repeating a lot of code.
  There are tools that let you include fragments of code (e.g. the navbar and the footer), such as [PHP](https://www.php.net/) (not recommended) or [Static Site Generators](https://jamstack.org/generators/).
  These will take significantly more time to learn, but it's totally worth it!

- The page does not have any interaction whatsoever.
  Maybe you'd like to have the cards raise when you hover them?
  With CSS [Animations](https://www.w3schools.com/css/css3_animations.asp) and
  [Transitions](https://www.w3schools.com/css/css3_transitions.asp) and the
  [`:hover` CSS selector](https://www.w3schools.com/cssref/sel_hover.asp) you can do that. Try it out!

- The links on the sidebar don't do anything.
  Wouldn't it be cool if they scrolled to the corresponding article?
  You can use the `id` property to link to specific parts of your page.
  You can even make the scroll smooth if you include [`scroll-behavior: smooth;` on the `html` element](https://css-tricks.com/almanac/properties/s/scroll-behavior/).

- Use your imagination! Add pictures, change the colors of elements, go wild!
