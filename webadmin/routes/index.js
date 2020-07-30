var express = require('express');
const request = require('request');
const axios = require('axios');
var mongo = require('mongodb');

var router = express.Router();
const MongoClient = require('mongodb').MongoClient;
const uri = "mongodb+srv://admin:cortexadmin123@cluster0-onaoj.mongodb.net/test?retryWrites=true&w=majority";
const client = new MongoClient(uri, { useNewUrlParser: true });
// for input validation you can use joi
// npm install mongodb --save


function db_insert(database_name, collection, payload, resref) {

  console.log(database_name, collection, payload);
  client.connect(err => {
    const collection = client.db('Users').collection('account');
    // perform actions on the collection object
    collection.insertOne(payload, function(err, res) {
      if (err) throw err;
      console.log("1 document inserted");
      resref.send(res);
    });
    client.close();
  });

}

function post_req(url, payload) {
  request.post(url, {json: payload}, (error, res, body) => {
    if (error) {
      console.error(error);
      return
    }
    console.log(`statusCode: ${res.statusCode}`)
    console.log(body)
  });
}

function post_req_axios(url, payload) {
  axios({
    method: 'post',
    url: url,
    data: payload,
  }).then(data=>console.log(data.data))
  .catch(err=>console.log(err))
}

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { project_id: 'BD001' });
});

router.post('/api', function(req, res, next) {
  var payload = req.body;
  if (payload.privilage == "admin") {
    if(payload.op == "add_new_user") {
      console.log(payload);
      db_insert('Users', 'account', payload, res);
    }
  } else {
    if(payload.op == "upload_map_image") {
      post_req_axios('https://7f0k3s6r3e.execute-api.us-east-1.amazonaws.com/dev', payload);
    }
  }
});

// example
router.get('/:userid/projects/:projectid/', function(req, res, next) {
  var user_id = req.params.userid;
  var project_id = req.params.projectid;
  // for query: req.query ex: /:userid/projects/:projectid/?sortby=
  res.send(req.params);
});

// npm install body-parser --save
// npm install express-graphql graphql --save

router.get('/partials', function(req, res) {
    res.render('sample_content' , {result_from_database: res.body} );
});

module.exports = router;
