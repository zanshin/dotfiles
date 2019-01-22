const test      = require('tape')
    , http      = require('http')
    , fs        = require('fs')
    , bl        = require('bl')
    , xtend     = require('xtend')
    , EE        = require('events').EventEmitter
    , jsonist   = require('./')
    , stringify = require('json-stringify-safe')
    , after     = require('after')


function testServer (serverResponse, statusCode) {
  var ee     = new EE()
    , server = http.createServer(handler)

  function handler (req, res) {
    req.pipe(bl(function (err, data) {
      if (err)
        return ee.emit('error', err)

      ee.emit('request', req, data.toString())

      setTimeout(server.close.bind(server), 20)
    }))

    res.writeHead(
        typeof statusCode == 'number' ? statusCode : 200
      , { 'content-type': 'application/json' }
    )
    res.end(serverResponse || '')
  }

  server.listen(function () {
    ee.emit('ready', 'http://localhost:' + server.address().port)
  })

  server.on('close', ee.emit.bind(ee, 'close'))

  return ee
}


'get delete'.split(' ').forEach(function (type) {
  test(type + ' fetch json doc', function (t) {
    t.plan(7)

    var testDoc = { a: 'test', doc: true, arr: [ { of: 'things' } ] }

    testServer(stringify(testDoc))
      .on('ready', function (url) {
        jsonist[type](url, function (err, data, response) {
          t.notOk(err, 'no error')
          t.deepEqual(data, testDoc, 'got correct doc')
          t.ok(response, 'got response object')
          t.equal(
              response && response.headers && response.headers['content-type']
            , 'application/json', 'verified response object by content-type header'
          )
        })
      })
      .on('request', function (req, data) {
        t.equal(req.method, type.toUpperCase(), 'got ' + type + ' request')
        t.equal(req.headers['accept'], 'application/json', 'got correct accept header')
      })
      .on('close', t.ok.bind(t, true, 'ended'))
  })

  test(type + ' fetch non-json doc', function (t) {
    t.plan(7)

    testServer('this is not json')
      .on('ready', function (url) {
        jsonist[type](url, function (err, data, response) {
          t.ok(err, 'got error')
          t.notOk(data, 'no data')
          t.notOk(response, 'no response obj')
          t.ok(/JSON/.test(err.message), 'error says something about "JSON"')
        })
      })
      .on('request', function (req, data) {
        t.equal(req.method, type.toUpperCase(), 'got ' + type + ' request')
        t.equal(req.headers['accept'], 'application/json', 'got correct accept header')
      })
      .on('close', t.ok.bind(t, true, 'ended'))
  })
})

'post put'.split(' ').forEach(function (type) {
  test(type + ' json, no response', function (t) {
    t.plan(9)

    var testDoc = { a: 'test2', doc: true, arr: [ { of: 'things' } ] }

    testServer('')
      .on('ready', function (url) {
        jsonist[type](url, xtend(testDoc), function (err, data, response) {
          t.notOk(err, 'no error')
          t.notOk(data, 'no data')
          t.ok(response, 'got response object')
          t.equal(
              response && response.headers && response.headers['content-type']
            , 'application/json', 'verified response object by content-type header'
          )
        })
      })
      .on('request', function (req, data) {
        t.equal(req.method, type.toUpperCase(), 'got ' + type + ' request')
        t.equal(req.headers['accept'], 'application/json', 'got correct accept header')
        t.equal(req.headers['content-type'], 'application/json', 'got correct encoding')
        t.deepEqual(JSON.parse(data), testDoc, 'got correct ' + type)
      })
      .on('close', t.ok.bind(t, true, 'ended'))
  })

  test(type + ' json, with response', function (t) {
    t.plan(9)

    var sendDoc = { a: 'test2', doc: true, arr: [ { of: 'things' } ] }
      , recvDoc = { recv: 'this', obj: true }

    testServer(stringify(recvDoc))
      .on('ready', function (url) {
        jsonist[type](url, xtend(sendDoc), function (err, data, response) {
          t.notOk(err, 'no error')
          t.deepEqual(data, recvDoc)
          t.ok(response, 'got response object')
          t.equal(
              response && response.headers && response.headers['content-type']
            , 'application/json', 'verified response object by content-type header'
          )
        })
      })
      .on('request', function (req, data) {
        t.equal(req.method, type.toUpperCase(), 'got ' + type + ' request')
        t.equal(req.headers['accept'], 'application/json', 'got correct accept header')
        t.equal(req.headers['content-type'], 'application/json', 'got correct encoding')
        t.deepEqual(JSON.parse(data), sendDoc, 'got correct ' + type)
      })
      .on('close', t.ok.bind(t, true, 'ended'))
  })

  test(type + ' data with no pipe function treated as data', function (t) {
    t.plan(9)

    var sendDoc = {
            a    : 'test2'
          , doc  : true
          , arr  : [ { of: 'things' } ]
          , pipe : 'this is a string and not a function'
        }
      , recvDoc = { recv: 'this', obj: true }

    testServer(stringify(recvDoc))
      .on('ready', function (url) {
        jsonist[type](url, xtend(sendDoc), function (err, data, response) {
          t.notOk(err, 'no error')
          t.deepEqual(data, recvDoc)
          t.ok(response, 'got response object')
          t.equal(
              response && response.headers && response.headers['content-type']
            , 'application/json', 'verified response object by content-type header'
          )
        })
      })
      .on('request', function (req, data) {
        t.equal(req.method, type.toUpperCase(), 'got ' + type + ' request')
        t.equal(req.headers['accept'], 'application/json', 'got correct accept header')
        t.equal(req.headers['content-type'], 'application/json', 'got correct encoding')
        t.deepEqual(JSON.parse(data), sendDoc, 'got correct ' + type)
      })
      .on('close', t.ok.bind(t, true, 'ended'))
  })

  test(type + ' data with pipe function will data.pipe(req)', function (t) {
    t.plan(10)

    var sendDoc = {
            a    : 'test2'
          , doc  : true
          , arr  : [ { of: 'things' } ]
        }
      , stream = {
          pipe: function (req) {
            t.ok(req, 'request should be set')
            req.end(stringify(sendDoc))
          }
        }
      , recvDoc = { recv: 'this', obj: true }

    testServer(stringify(recvDoc))
      .on('ready', function (url) {
        jsonist[type](url, stream, function (err, data, response) {
          t.notOk(err, 'no error')
          t.deepEqual(data, recvDoc)
          t.ok(response, 'got response object')
          t.equal(
              response && response.headers && response.headers['content-type']
            , 'application/json', 'verified response object by content-type header'
          )
        })
      })
      .on('request', function (req, data) {
        t.equal(req.method, type.toUpperCase(), 'got ' + type + ' request')
        t.equal(req.headers['accept'], 'application/json', 'got correct accept header')
        t.equal(req.headers['content-type'], 'application/json', 'got correct encoding')
        t.deepEqual(JSON.parse(data), sendDoc, 'got correct ' + type)
      })
      .on('close', t.ok.bind(t, true, 'ended'))
  })

  test(type + ' data with pipe function and real stream works', function (t) {
    t.plan(9)

    var file    = __dirname + '/package.json'
      , content = JSON.parse(fs.readFileSync(file))
      , stream  = fs.createReadStream(file)
      , recvDoc = { recv: 'this', obj: true }

    testServer(stringify(recvDoc))
      .on('ready', function (url) {
        jsonist[type](url, stream, function (err, data, response) {
          t.notOk(err, 'no error')
          t.deepEqual(data, recvDoc)
          t.ok(response, 'got response object')
          t.equal(
              response && response.headers && response.headers['content-type']
            , 'application/json', 'verified response object by content-type header'
          )
        })
      })
      .on('request', function (req, data) {
        t.equal(req.method, type.toUpperCase(), 'got ' + type + ' request')
        t.equal(req.headers['accept'], 'application/json', 'got correct accept header')
        t.equal(req.headers['content-type'], 'application/json', 'got correct encoding')
        t.deepEqual(JSON.parse(data), content, 'got correct ' + type)
      })
      .on('close', t.ok.bind(t, true, 'ended'))
  })
})


test('follow redirect', function (t) {
  t.plan(7)

  var expectedResponse = { ok: 'foobar!' }
    , server = http.createServer(function (req, res) {
        if (req.url == '/') { // 2 requests come in here
          t.ok('got /')
          res.writeHead(302, { 'location': '/foobar' })
          return res.end()
        }
        // one comes in here
        t.equal(req.url, '/foobar', 'got /foobar')
        res.writeHead(200, { 'content-type': 'application/json' })
        res.end(stringify(expectedResponse))
      })

  server.listen(function () {
    var port = server.address().port
      , done = after(2, function () { server.close() })

    jsonist.get('http://localhost:' + port, function (err, data) {
      // don't follow redirect, don't get data
      t.error(err, 'no error')
      t.equal(data, null, 'no redirect, no data')
      done()
    })

    jsonist.get('http://localhost:' + port, { followRedirects: true }, function (err, data) {
      t.error(err, 'no error')
      t.deepEqual(data, expectedResponse, 'redirect, got data')
      done()
    })
  })
})


test('follow redirect limit', function (t) {
  t.plan(6 + 10 + 5 + 10)

  var expectedResponse = { ok: 'foobar!' }
    , server = http.createServer(function (req, res) {
        var m = +req.url.match(/^\/(\d+)/)[1]
        if (m < 20) { // 2 requests come in here
          t.ok('got /')
          res.writeHead(302, { 'location': '/' + (m + 1) })
          return res.end()
        }
        // one comes in here
        t.equal(req.url, '/20', 'got /20')
        res.writeHead(200, { 'content-type': 'application/json' })
        res.end(stringify(expectedResponse))
      })

  server.listen(function () {
    var port = server.address().port
      , done = after(3, function () { server.close() })

    jsonist.get('http://localhost:' + port + '/1', { followRedirects: true }, function (err, data) {
      t.ok(err, 'got error')
      t.equal(err.message, 'Response was redirected too many times (10)')
      done()
    })

    jsonist.get('http://localhost:' + port + '/1', { followRedirects: 5 }, function (err, data) {
      t.ok(err, 'got error')
      t.equal(err.message, 'Response was redirected too many times (5)')
      done()
    })

    jsonist.get('http://localhost:' + port + '/11', { followRedirects: true }, function (err, data) {
      t.error(err, 'no error')
      t.deepEqual(data, expectedResponse, 'redirect, got data')
      done()
    })
  })
})


test('server error, non-JSON', function (t) {
  t.plan(7)

  var responseText = 'there was an error'

  testServer(responseText, 501)
    .on('ready', function (url) {
      jsonist.get(url, function (err, data, response) {
        t.ok(err)
        t.ok(err instanceof jsonist.HttpError)
        t.equal(err.data.toString(), responseText, 'got correct response')
        t.equal(err.statusCode, 501, 'got correct statusCode')
      })
    })
    .on('request', function (req, data) {
      t.equal(req.method, 'GET', 'got GET request')
      t.equal(req.headers['accept'], 'application/json', 'got correct accept header')
    })
    .on('close', t.ok.bind(t, true, 'ended'))
})


test('server error, with-JSON', function (t) {
  t.plan(8)

  var responseDoc = 'there was an error'

  testServer(stringify(responseDoc), 501)
    .on('ready', function (url) {
      jsonist.get(url, function (err, data, response) {
        t.notOk(err, 'no error')
        t.deepEqual(data, responseDoc, 'got correct doc')
        t.ok(response, 'got response object')
        t.equal(response.statusCode, 501, 'got correct status code')
        t.equal(
            response && response.headers && response.headers['content-type']
          , 'application/json', 'verified response object by content-type header'
        )
      })
    })
    .on('request', function (req, data) {
      t.equal(req.method, 'GET', 'got GET request')
      t.equal(req.headers['accept'], 'application/json', 'got correct accept header')
    })
    .on('close', t.ok.bind(t, true, 'ended'))
})
