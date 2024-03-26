name = document.getElementById("name")
quantity = document.getElementById("quantity")
price = document.getElementById("price")
orderList = document.getElementById("orders")
orders = []

window.addOrder = ->
	orders.push
		name: name.value
		quantity: parseInt(quantity.value)
		price: parseFloat(price.value)
	updateList()

updateList = ->
	total = orders.reduce (totalPrice, order) ->
		totalPrice + order.quantity * order.price
	, 0

	html = '<table><tr><th>Name</th><th>Quantity</th><th>Price</th><th>Total</th><th></th></tr>'
	orders.forEach (order, i) ->
		html += '<tr><td>' + order.name + '</td>'
		html += '<td>' + order.quantity + '</td>'
		html += '<td>$' + order.price.toFixed(2) + '</td>'
		html += '<td>$' + (order.quantity * order.price).toFixed(2) + '</td>'
		html += '<td><button onclick="deleteOrder(' + i + ')">Delete</button></td></tr>'
	html += '<tr><td colspan="3"></td><td>Total: $' + total.toFixed(2) + '</td><td></td></tr>'
	html += '</table>'
	orderList.innerHTML = html

window.deleteOrder = (i) ->
	orders.splice(i, 1)
	updateList()


