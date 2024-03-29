const Api = require('../api');
const Middlaware = require('../middleware');
const statics = require('./statics');

module.exports = function (app = require('../index')(), server = require('express')()) {
  for(let static of statics) server.use(
    static.route,
    app.express.static(
      app.path[static.funcName]()
    )
  );

  let middlaware = Middlaware.get(app)
    .setMaxRequests(app.process.env.MAXREQUEST)
    .setTimeListenUsingMinute(app.process.env.RESETINTERVALMINUTE)
    .setDefaultResponseHeader({
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
      'Access-Control-Allow-Headers': '*',
      'Access-Control-Allow-Credentials': false
    })
    .listen();

  server.use(app.bodyparser.urlencoded({ extended: true }));

  try {
    server.use(app.bodyparser.json({ limit: app.process.env.LIMIT_REQUEST_LENGTH }));
  } catch (error) { }
  server.use((i, s, n) => middlaware.validate(i, s, n));

  for(let api of Api) server.use(api.route, api.use);
}