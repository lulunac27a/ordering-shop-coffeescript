names = document.getElementById "name"
quantity = document.getElementById "quantity"
price = document.getElementById "price"
tax = document.getElementById "tax"
orderList = document.getElementById "orders"
orders = []

window.addOrder = ->
	if (names.value and not isNaN parseInt quantity.value) and ((not isNaN parseFloat price.value) and not isNaN parseFloat tax.value) #make sure all inputs are valid
		orders.push #add order to list of orders
			names: names.value
			quantity: parseInt quantity.value 
			price: (parseInt price.value * 100) / 100
			tax: (parseInt tax.value * 100) / 100
		names.value = ''
		quantity.value = ''
		price.value = ''
		tax.value = ''
		updateList() #update order list for each record

updateList = ->
	total = orders.reduce (totalPrice, order) ->
		totalPrice + order.quantity * order.price * (1 + order.tax / 100)
	, 0

	html = '<table><tr><th>Name</th><th>Quantity</th><th>Price</th><th>Tax</th><th>Total</th><th></th></tr>' #set HTML content output for all order records
	orders.forEach (order, i) ->
		html += '<tr><td>' + order.names + '</td>'
		html += '<td style="text-align: right;">' + order.quantity + '</td>'
		html += '<td style="text-align: right;">$' + order.price.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + '</td>'
		html += '<td style="text-align: right;">' + order.tax.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + '%</td>'
		html += '<td style="text-align: right;">$' + (order.quantity * order.price * (1 + order.tax / 100)).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + '</td>'
		html += '<td><button onclick="deleteOrder(' + i + ')">Delete</button></td></tr>'
	html += '<tr><td colspan="4"></td><td style="text-align: right;">Total: $' + total.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + '</td><td></td></tr>'
	html += '</table>'
	orderList.innerHTML = html #set order list HTML output

window.deleteOrder = (i) ->
	orders.splice i, 1 #remove order from index i
	updateList()


