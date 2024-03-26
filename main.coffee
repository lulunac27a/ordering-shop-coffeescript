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
	html = '<table><tr><th>Name</th><th>Quantity</th><th>Price</th><th>Total</th></tr>'
	orders.forEach (order) ->
		html += '<tr><td>' + order.name + '</td>'
		html += '<td>' + order.quantity + '</td>'
		html += '<td>' + order.price.toFixed(2) + '</td>'
		html += '<td>' + (order.quantity * order.price).toFixed(2) + '</td></tr>'
	html += '</table>'
	orderList.innerHTML = html

