var express = require('express');
var router = express.Router();

require('dotenv').config();

// Import the Google Cloud Vision library
const vision = require('@google-cloud/vision');

// Create a client
const client = new vision.ImageAnnotatorClient();
router.get('/:type/:fileName/:token', async function (req, res, next) {

  var url = "https://firebasestorage.googleapis.com/v0/b/devhacks2020-1cf35.appspot.com/o/" + req.params.type + "%2F" + req.params.fileName + "?alt=media&token" + req.params.token;
  console.log(url + "");

  const [result] = await client.textDetection(url)
  const detections = result.textAnnotations;
  console.log(detections[0].locale)
  if (detections[0].locale != null) {
    res.json({ "data": "success", "text": detections[0] });

  }
  else {
    res.json({
      "data": "failure", "text": "null"
    });

  }


});
module.exports = router;
