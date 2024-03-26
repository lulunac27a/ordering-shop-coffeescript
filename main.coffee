names = document.getElementById "name"
quantity = document.getElementById "quantity"
price = document.getElementById "price"
orderList = document.getElementById "orders"
orders = []

window.addOrder = ->
	if (names.value and not isNaN parseInt quantity.value) and not isNaN parseFloat price.value#make sure all inputs are valid
		orders.push#add order to list of orders
			names: names.value
			quantity: parseInt quantity.value 
			price: parseFloat price.value
		names.value = ''
		quantity.value = ''
		price.value = ''
		updateList()#update order list for each record

updateList = ->
	total = orders.reduce (totalPrice, order) ->
		totalPrice + order.quantity * order.price
	, 0

	html = '<table><tr><th>Name</th><th>Quantity</th><th>Price</th><th>Total</th><th></th></tr>'#set HTML content output for all order records
	orders.forEach (order, i) ->
		html += '<tr><td>' + order.names + '</td>'
		html += '<td style="text-align: right;">' + order.quantity + '</td>'
		html += '<td style="text-align: right;">$' + order.price.toFixed(2) + '</td>'
		html += '<td style="text-align: right;">$' + (order.quantity * order.price).toFixed(2) + '</td>'
		html += '<td><button onclick="deleteOrder(' + i + ')">Delete</button></td></tr>'
	html += '<tr><td colspan="3"></td><td style="text-align: right;">Total: $' + total.toFixed(2) + '</td><td></td></tr>'
	html += '</table>'
	orderList.innerHTML = html#set order list HTML output

window.deleteOrder = (i) ->
	orders.splice i, 1#remove order from index i
	updateList()


