Introduction:
==================================

Hey there! This submission is created by [Trevor Elwell](http://trevorelwell.me) and [Nick Montanaro](https://github.com/nicoNaN/). Our solution is to the [Uber coding challenge](https://github.com/uber/coding-challenge-tools/blob/master/coding_challenge.md) departure times problem.

Summary:
==================================

We wanted to come up with a way for users to quickly find the next train leaving from their closest BART station. Our solution is a rails application which geolocates the user based on their IP address, and then tells them the departure times of the trains for that day which haven't left that station yet. Our two main tools were the [Geocoder gem](https://github.com/alexreisner/geocoder) and the [BART API](http://api.bart.gov/docs/overview/index.aspx). 

How to use the app:
==================================

**NOTE** This works best if you're located in/around the San Francisco area. [Our application](https://vast-taiga-9481.herokuapp.com/) will geolocate you based on your IP address and then determine which BART station is nearest to you. It will then tell you the next train leaving the station (in case you're in a rush to leave) and all of the trains leaving after it that day. You can also check the departures for other stations.

It's a pretty simple application from a UX perspective so there isn't much to explain!

Approach:
==================================

For Nick and I this was our first pair programming excercise. We both have a lot of experience building applications and learning new concepts on our own, but going through the coding process with someone else watching was a challenge in itself. We both got the hang of it quickly, though, and we were able to work through the more difficult problems for the challenge.

As you'll notice, our solution is not focused on testing, but the UX, clarity, and correctness of the application is on point. It is a simple app that does one thing well: showing you the times of the trains that haven't left the closest BART station yet. (Note that this works best in the area surrounding San Francisco. Otherwise, you'll get the closest station to a far away place. For instance, coding in New York City I kept getting DALY station when I went onto the application.) 

Problems Encountered:
==================================

**1) Spoofing an IP on localhost.**

We ran into a wall quickly because we wanted to test our our cool new Geocoder gem but couldn't try out the IP geolocating functionality because neither one of us could get our application to return an IP address. Since we were both running rails locally whenever we ran something like `request.remote_ip` it would return `127.0.0.1` or `::1` or similar. When this was searched using the Geocoder tool it would return `nil` and was rather useless.

We found some solace through [stack overflow](http://stackoverflow.com/questions/3887943/get-real-ip-address-in-local-rails-development-environment), but after some initial frustration decided that the best way to move forward was to rely on `request.remote_ip` working properly once we actually pushed it to Heroku and hard coding in the IP during local testing. This actually proved very useful because we could try different IP addresses with the geolocater to ensure it was functioning properly. 


**2) Finding the closest BART station.**

Once we got past the problem of finding the user's IP address and geolocating it (returning latitude and longitude) we then reached the problem of how to actually find the closest BART station to the user. The good news is the BART API gives us the lat and lon of all of the BART stations. The bad news was, we didn't know what to do with these at first. 

Then we found a gem called [GeoDistance](https://github.com/kristianmandrup/geo-distance) which gives you the distance between two latitudes and longitudes. Hell, you can even use Haversine functions to make sure it's as exact as possible. Unfortunately, though, running a Haversine function on each BART station and isn't cheap and our app kept crashing whenever we ran it locally. There had to be a simpler way to do this!

Well there was, and it was called high-school geometry. Remember the handy old [distance equation](http://cs.selu.edu/~rbyrd/math/distance/)? It returns the distance between two points on the coordinate plane. All we had to do was treat two latitude and longitude points as plain old points and take the point of view of the early church and pretend that the world was flat and we were able to calculate distance between our user and all of the BART stations! Obviously a Haversine equation would be more accurate, but at these distances we decided that not factoring in the curvature of the Earth was not likely to result in the incorrect answer. So high-school math FTW with this problem!

**3) Getting the right time.**

Everything was working the way we wanted, we were happy and ready to push things up to Heroku. After the obligatory 50 problems that come with pushing to Heroku, we got it running. Except, of course, now our cutoff time was wrong when you went to the application. We wanted the application to function in the Pacific timezone and only give times based on that, but apparently wherever Heroku's servers are located was messing with our `Time` functions and resulted in our users being shown a lot of times at 4AM. 

Our solution is straightforward, but since neither of us were well acquainted with the `Time` or `TimeZone` modules it took a bit to find the proper solution. In order to accomplish what we wanted we first set a time zone using `Time.zone = 'America/Los_Angeles'` and then based our cutoff times on that timezone using `if Time.zone.parse(departure['origTime']) >= Time.zone.now` (this block determines whether or not to show a BART API item). But with this push our app is showing the correct times no matter where you look! 


Conclusion:
==================================

I'm very happy that we went through with this project. Not only did we come up with a good solution to a problem that we partially defined but we learned a lot about pair programming. There are a lot of `#ToDos` that we would like to accomplish if we were trying to fully flesh out this application. But as a learning excercise we took it in a very good direction and got a lot of use out of it.

Please comment with any questions or critiques- we're always interested in learning how we can improve.  