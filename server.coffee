express    = require 'express'
app        = express()

bodyParser = require 'body-parser'
nocache    = require 'nocache'
axios      = require 'axios'

fs         = require 'fs'
http       = require 'http'
https      = require 'https'

app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()
app.use nocache()

httpPort = process.env.PORT || 80
httpsPort = 443

router = express.Router()

router.post '/', (req, res)->
  payload = req.body
  accessToken = payload.accessToken

  if accessToken != 'JReHjrvJSyHah4MCfZTmTbbtpefZRgruNfraMVURCzfkzWAj5hRzHWhqzKqWkAZH'
    console.log 'Invalid Token', accessToken
    return

  ord = payload.data

  console.log 'Receiving', req.body

  name      = ord.shippingAddress.name
  split     = name.indexOf(' ')
  firstName = name.substr 0, split
  lastName  = name.substr split + 1

  tickets = []

  numTickets = 0

  for item in ord.items
    numTickets += item.quantity

  console.log "Buying #{ numTickets } Tickets"

  while numTickets > 0
    console.log "Ticket Sale"
    tickets.push
      email:      ord.email ? ''
      first_name: firstName ? ''
      last_name:  lastName  ? ''
      ticket_price:
        ticket_price_id: 124081
    numTickets--

  console.log "Confirm Sale of #{ tickets.length } Tickets"

  data =
    data:
      attributes:
        event_id: 138036
        invoice:
          email:      ord.email ? ''
          first_name: firstName ? ''
          last_name:  lastName  ? ''
        tickets: tickets
      type: 'checkout'

  console.log 'Posting Checkout Data', JSON.stringify(data)

  axios.post 'https://api.picatic.com/v2/checkout', data
    .then (req) ->
      checkoutData = req.data
      console.log 'Posting Checkout Confirmation Data', checkoutData.data.id
      return axios.post "https://api.picatic.com/v2/checkout/#{ checkoutData.data.id }/confirm"
    .then (req) ->
      console.log 'SUCCESS!'
    .catch (err) ->
      console.log 'Error', err

  res.send ord

app.use '/webhook', router
app.use express.static('public')

console.log 'Starting Server'

options =
  key: fs.readFileSync('./server.key'),
  cert: fs.readFileSync('./server.crt'),
  requestCert: false,
  rejectUnauthorized: false

http.createServer (req, res)->
  res.writeHead(301, { "Location": "https://" + req.headers['host'] + req.url })
  res.end()
.listen 80

https.createServer(options, app).listen 443
