A script to solve the "Scramble Squares" [tile puzzle, Golf style](http://www.b-dazzle.com/puzzdetail.asp?PuzzID=52&CategoryName=Hobbies%20and%20Activities%20Puzzles&CatID=8)

I got tired of it [looking like this](http://twitpic.com/3jzmwa)

To solve it, run `ruby solver.rb`

Returned are a set of answers, each with 9 tiles defined this way (as elements in the array)
<pre>
0 1 2
3 4 5
6 7 8
</pre>

Each element in the array has four values, representing the images on the top, right, bottom, and left sides, in that order.  The images are coded as two-character values, with the image defined as the *first* character, and the ordinality as the *second*. For example:

 * WB: the **W**oman image, **B**ottom
 * CT: the **C**lub image, **T**op

 The codes are:

 * **W**oman
 * **B**ag
 * **M**an
 * **C**lub
