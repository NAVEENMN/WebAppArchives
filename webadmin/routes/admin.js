var express = require('express');
const request = require('request');
const axios = require('axios');
var mongo = require('mongodb');
var router = express.Router();

function dbconnect(){
  var MongoClient = require('mongodb').MongoClient;
  const uri = "mongodb+srv://admin:cortexadmin123@cluster0-onaoj.mongodb.net/test?retryWrites=true&w=majority";
  const client = new MongoClient.connect(uri, function(err, db) {
    if (err) throw err;
    console.log("Database connected!");
    db.close();
  });
  return client;
}

function post_req_axios(url, payload) {
  axios({
    method: 'post',
    url: url,
    data: payload,
  }).then(data=>console.log(data.data))
  .catch(err=>console.log(err))
}

/* Admin requests. */
router.get('/', function(req, res, next) {
  var db_client = dbconnect();
  res.render('admin', { project_id: 'BD001' });
});

router.get('/users', function(req, res, next) {
  var db_client = dbconnect();
  res.render('admin', { project_id: 'BD001' });
});

router.get('/geo', function(req, res, next) {
  var db_client = dbconnect();
  res.render('admin', { project_id: 'BD001' });
});

module.exports = router;
