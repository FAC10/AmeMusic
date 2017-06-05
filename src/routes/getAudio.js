var youtubeStream = require('youtube-audio-stream')

module.exports = {
  method: 'GET',
  path: '/getAudio',
  handler: (request, reply) => {

    var requestUrl = 'https://www.youtube.com/watch?v=7LU18BJunVk';

    // try {

      console.log(youtubeStream(requestUrl));

    // }
    // catch (exception) {
    //   reply.status(500).send(exception)
    // }
  reply('getting audio');
  }
}
