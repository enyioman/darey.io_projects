In the course of building this solution, the following were the challenges I faced and how I was able to resolve them.

**Error 1:**

After configuring Nginx to use PHP processor, I recieved a 502 error while trying to access the test file through the browser.

**Resolution:**

Found out the error was from the configuration in my Nginx root web directory. There was a disparity between the PHP version of my localhost and what I declared earlier in `/etc/nginx/sites-available/projectLEMP`.


**Error 2:**

I received an 'Access Denied' error while querying for my DB content. 

**Resolution:**

I modified the DB authentication parameters.
