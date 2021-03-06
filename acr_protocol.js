const url = require('url');
const fs = require('fs');
const crypto = require('crypto');
// npm install request
const request = require('request');
require('env2')('config.env');

// Replace "###...###" below with your project's host, access_key and access_secret.
const defaultOptions = {
  host: process.env.HOST,
  endpoint: '/v1/identify',
  signature_version: '1',
  data_type: 'audio',
  secure: true,
  access_key: process.env.ACCESS_KEY,
  access_secret: process.env.SECRET,
};

function buildStringToSign(method, uri, accessKey, dataType, signatureVersion, timestamp) {
  return [method, uri, accessKey, dataType, signatureVersion, timestamp].join('\n');
}

function sign(signString, accessSecret) {
  return crypto
    .createHmac('sha1', accessSecret)
    .update(new Buffer(signString, 'utf-8'))
    .digest()
    .toString('base64');
}

/**
 * Identifies a sample of bytes
 */
function identify(data, options, cb) {
  const current_data = new Date();
  const timestamp = current_data.getTime() / 1000;

  const stringToSign = buildStringToSign(
    'POST',
    options.endpoint,
    options.access_key,
    options.data_type,
    options.signature_version,
    timestamp,
  );

  const signature = sign(stringToSign, options.access_secret);

  const formData = {
    sample: data,
    access_key: options.access_key,
    data_type: options.data_type,
    signature_version: options.signature_version,
    signature,
    sample_bytes: data.length,
    timestamp,
  };
  request.post(
    {
      url: `http://${options.host}${options.endpoint}`,
      method: 'POST',
      formData,
    },
    cb,
  );
}

const bitmap = fs.readFileSync('./sample.wav');

identify(new Buffer(bitmap), defaultOptions, (err, httpResponse, body) => {
  if (err) console.log(err);
  console.log('>>', body);
});
