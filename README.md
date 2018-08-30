# Digital-Pharmacist

![Screenshot 1](https://raw.githubusercontent.com/JeanPierreFig/Digital-Pharmacist/master/IMG_1600.PNG)
![Screenshot 2](https://raw.githubusercontent.com/JeanPierreFig/Digital-Pharmacist/master/IMG_1601.PNG)

# Detail challenges experienced (if any)
The first challenge I encountered was the fact that, for the past 2 years I have mainly been coding in swift, 
But after I started working on the project everything came back to me. Unfortunately, this led me to take a bit
more time creating the project.

API's used where http://www.zipcodeapi.com and http://www.developer.forecast.io. I did not use any kind of Third-Party
Libraries for this project even though there was one for Dark Sky. The reason for this is because don't need to add a 
whole layer of bloat for a simple API call. If the scope of the project was bigger then I might consider using the 
Library or create my own helper class. 

# Detail improvements you would make if you had additional time.

I would improve the overall UI design of the app. In addition, I would like to include more data points for the user to get a better
understanding of the forecast. Under the hood, if there would be a need for more then one API call, I would create a 
helper class for all NSURLSessionDataTask calls to keep the viewController clean.
