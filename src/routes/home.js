module.exports = {
  method: 'GET',
  path: '/',
  handler: (request, reply) => {

    const context = {
      hello: 'Test'
    };

    return reply.view('index', context);
  }
};
