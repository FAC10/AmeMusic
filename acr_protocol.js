var url = require('url');
var fs = require('fs');
var crypto = require('crypto');
//npm install request
var request = require('request');
require('env2')('config.env');

// Replace "###...###" below with your project's host, access_key and access_secret.
var defaultOptions = {
  host: process.env.HOST,
  endpoint: '/v1/identify',
  signature_version: '1',
  data_type:'audio',
  secure: true,
  access_key: process.env.ACCESS_KEY,
  access_secret: process.env.SECRET
};

function buildStringToSign(method, uri, accessKey, dataType, signatureVersion, timestamp) {
  return [method, uri, accessKey, dataType, signatureVersion, timestamp].join('\n');
}

function sign(signString, accessSecret) {
  return crypto.createHmac('sha1', accessSecret)
    .update(new Buffer(signString, 'utf-8'))
    .digest().toString('base64');
}

/**
 * Identifies a sample of bytes
 */
function identify(data, options, cb) {

  var current_data = new Date();
  var timestamp = current_data.getTime()/1000;

  var stringToSign = buildStringToSign('POST',
    options.endpoint,
    options.access_key,
    options.data_type,
    options.signature_version,
    timestamp);

  var signature = sign(stringToSign, options.access_secret);

  var formData = {
    sample: data,
    access_key:options.access_key,
    data_type:options.data_type,
    signature_version:options.signature_version,
    signature:signature,
    sample_bytes:data.length,
    timestamp:timestamp,
  }
  request.post({
    url: "http://"+options.host + options.endpoint,
    method: 'POST',
    formData: formData
  }, cb);
}

var bitmap = fs.readFileSync('./sample.wav');

identify(new Buffer(bitmap), defaultOptions, function (err, httpResponse, body) {
  if (err) console.log(err);
  console.log('>>',body);
});
