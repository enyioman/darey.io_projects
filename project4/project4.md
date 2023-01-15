# Implementing a MEAN STACK on AWS Cloud

### Objective: To create a simple Book Register web form using MEAN Stack


The MEAN stack uses:
1. MongoDB: a document database to store and retrieve data.
2. Express: a back-end application framework used to make requests to the database.
3. Angular: a front-end application framework that handles server and client requests.
4. Node.js: a JavaScript run-time environment that accepts requests and displays results to the end user.

## Preparing Prerequisites

Launch an EC2 instance with Ubuntu OS.

## Step 1: Install Node.js

Node.js is installed first to set up Express routes and AngularJS controllers.

Connect to the Ubuntu server with SSH.

Update and upgrade Ubuntu:

```
sudo apt update
```
```
sudo apt upgrade
```

Install Node.js:

```
sudo apt install -y nodejs
```

## Step 2: Install MongoDB

The MongoDB database will be used to contain book name, isbn number, author, and number of pages.

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
```

```
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
```

Install MongoDB:

```
sudo apt install -y mongodb
```

Start and verify that the server is up and running:

```
sudo service mongodb start
```

```
sudo systemctl status mongodb
```

![MongoDB up](./media/mongo.png)


Install npm - Node package manager:

```
sudo apt install -y npm
```

Install the body-parser package to help process JSON files passed in requests to the server:

```
sudo npm install body-parser
```

Create a folder called `Books`:

```
mkdir Books && cd Books
```

Initialize npm project in `Books` directory:

```
npm init
```

Create a file called `server.js` and add the following code:

```
vi server.js
```

```
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(express.static(__dirname + '/public'));
app.use(bodyParser.json());
require('./apps/routes')(app);
app.set('port', 3300);
app.listen(app.get('port'), function() {
    console.log('Server up: http://localhost:' + app.get('port'));
});
```

## Step 3: Install Express and set up routes to the server


Express is used to pass book information to and from the database. Mongoose package is used to create a schema for the database to store the data of the book register.

Install Mongoose:

```
sudo npm install express mongoose
```

Create a folder called `apps` in the `Books` directory:

```
mkdir apps && cd apps
```

Create a file called 'routes.js' and add the following code:

```
vi routes.js
```

```
var Book = require('./models/book');
module.exports = function(app) {
  app.get('/book', function(req, res) {
    Book.find({}, function(err, result) {
      if ( err ) throw err;
      res.json(result);
    });
  }); 
  app.post('/book', function(req, res) {
    var book = new Book( {
      name:req.body.name,
      isbn:req.body.isbn,
      author:req.body.author,
      pages:req.body.pages
    });
    book.save(function(err, result) {
      if ( err ) throw err;
      res.json( {
        message:"Successfully added book",
        book:result
      });
    });
  });
  app.delete("/book/:isbn", function(req, res) {
    Book.findOneAndRemove(req.query, function(err, result) {
      if ( err ) throw err;
      res.json( {
        message: "Successfully deleted the book",
        book: result
      });
    });
  });
  var path = require('path');
  app.get('*', function(req, res) {
    res.sendfile(path.join(__dirname + '/public', 'index.html'));
  });
};
```

Create a folder called `models` in the `apps` directory:

```
mkdir models && cd models
```

Create a file called 'book.js' and insert the following code:

```
vi book.js
```

```
var mongoose = require('mongoose');
var dbHost = 'mongodb://localhost:27017/test';
mongoose.connect(dbHost);
mongoose.connection;
mongoose.set('debug', true);
var bookSchema = mongoose.Schema( {
  name: String,
  isbn: {type: String, index: true},
  author: String,
  pages: Number
});
var Book = mongoose.model('Book', bookSchema);
module.exports = mongoose.model('Book', bookSchema);
```

## STEP 4: Access the routes with AngularJS

AngularJS creates dynamic views of the Book Register by connecting the web page to Express and performing actions on the Book Register.

Go back to `Books` and create a folder called `public`:

```
cd ../..
mkdir public && cd public
```

Create a file called `script.js` and add the following code that defines the controller configuration:

```
vi script.js
```

```
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
  $http( {
    method: 'GET',
    url: '/book'
  }).then(function successCallback(response) {
    $scope.books = response.data;
  }, function errorCallback(response) {
    console.log('Error: ' + response);
  });
  $scope.del_book = function(book) {
    $http( {
      method: 'DELETE',
      url: '/book/:isbn',
      params: {'isbn': book.isbn}
    }).then(function successCallback(response) {
      console.log(response);
    }, function errorCallback(response) {
      console.log('Error: ' + response);
    });
  };
  $scope.add_book = function() {
    var body = '{ "name": "' + $scope.Name + 
    '", "isbn": "' + $scope.Isbn +
    '", "author": "' + $scope.Author + 
    '", "pages": "' + $scope.Pages + '" }';
    $http({
      method: 'POST',
      url: '/book',
      data: body
    }).then(function successCallback(response) {
      console.log(response);
    }, function errorCallback(response) {
      console.log('Error: ' + response);
    });
  };
});
```

Create another file called `index.html` in the public folder and add the following code:

```
vi index.html
```

```
<!doctype html>
<html ng-app="myApp" ng-controller="myCtrl">
  <head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
    <script src="script.js"></script>
  </head>
  <body>
    <div>
      <table>
        <tr>
          <td>Name:</td>
          <td><input type="text" ng-model="Name"></td>
        </tr>
        <tr>
          <td>Isbn:</td>
          <td><input type="text" ng-model="Isbn"></td>
        </tr>
        <tr>
          <td>Author:</td>
          <td><input type="text" ng-model="Author"></td>
        </tr>
        <tr>
          <td>Pages:</td>
          <td><input type="number" ng-model="Pages"></td>
        </tr>
      </table>
      <button ng-click="add_book()">Add</button>
    </div>
    <hr>
    <div>
      <table>
        <tr>
          <th>Name</th>
          <th>Isbn</th>
          <th>Author</th>
          <th>Pages</th>

        </tr>
        <tr ng-repeat="book in books">
          <td>{{book.name}}</td>
          <td>{{book.isbn}}</td>
          <td>{{book.author}}</td>
          <td>{{book.pages}}</td>

          <td><input type="button" value="Delete" data-ng-click="del_book(book)"></td>
        </tr>
      </table>
    </div>
  </body>
</html>
```


Go back to `Books` folder and start the server:

```
node server.js
```

Edit the Security Group on the Ubuntu instance to allow TCP traffic on Port 3300:

![open port](./media/inboundsg.png)

The Book Register web application can now be accessed using the Public IP address of the instance or the DNS name.

![App running](./media/appup.png)







