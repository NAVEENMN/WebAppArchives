var express = require('express');

var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { project_id: 'BD001' });
});

// npm install body-parser --save
router.post("/send_image", function(req, res){
  var payload = req.body;
  print("here");
  console.log(payload);
  res.send('/');
});

router.get('/partials', function(req, res) {
    res.render('sample_content' , {result_from_database: res.body} );
});

module.exports = router;
