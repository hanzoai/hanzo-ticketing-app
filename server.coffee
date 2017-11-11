express    = require 'express'
app        = express()

bodyParser = require 'body-parser'
axios      = require 'axios'

app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

port = process.env.PORT || 80

router = express.Router()

router.post '/', (req, res)->
  ord = req.body

  console.log 'Receiving', req.body

  name      = ord.shippingAddress.name
  split     = name.indexOf(' ')
  firstName = name.substr 0, split
  lastName  = name.substr split + 1

  data =
    data:
      attributes:
        event_id: 134785
        invoice:
          email:      ord.email ? ''
          first_name: firstName ? ''
          last_name:  lastName  ? ''
        tickets: [
          {
            email:      ord.email ? ''
            first_name: firstName ? ''
            last_name:  lastName  ? ''
            ticket_price:
              ticket_price_id: 120658
          }
        ]
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

console.log 'Starting Server on ' + port
app.listen port
