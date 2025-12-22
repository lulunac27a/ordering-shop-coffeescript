names = document.getElementById 'name' #order name
quantity = document.getElementById 'quantity' #order quantity
price = document.getElementById 'price' #order price
tax = document.getElementById 'tax' #order tax in percent
orderList = document.getElementById 'orders' #list of orders
orders = [] #orders array

window.addOrder = ->#function to add order to list


    if (
        names.value and
        not isNaN(parseInt quantity.value) and
        (not isNaN(parseFloat price.value) and not isNaN parseFloat tax.value) #check to make sure all inputs are valid
    )
        orders.push
            #add order to list of orders
            names: names.value
            quantity: parseInt quantity.value, 10
            price: parseInt(price.value * 100, 10) / 100
            tax: parseInt(tax.value * 100, 10) / 100
        names.value = '' #set all input values to blank (empty text)
        quantity.value = ''
        price.value = ''
        tax.value = ''
        updateList() #update order list for each record

updateList = ->#function to update order list


    total = orders.reduce(
        (totalPrice, order) ->
            totalPrice + order.quantity * order.price * (1 + order.tax / 100) #calculate total price
    ,
        0
    )

    #build table using DOM APIs (avoid innerHTML for safety)
    table = document.createElement 'table'
    #header
    head = document.createElement 'thead'
    headerRow = document.createElement 'tr'
    for header in ['Name', 'Quantity', 'Price', 'Tax', 'Total', '']
        th = document.createElement 'th'
        th.textContent = header #set HTML content output for all order records
        headerRow.appendChild th
    head.appendChild headerRow
    table.appendChild head

    #body rows
    tbody = document.createElement 'tbody'
    orders.forEach (order, i) ->
        tr = document.createElement 'tr'

        #name
        tdName = document.createElement 'td'
        tdName.textContent = order.names
        tr.appendChild tdName

        #quantity
        tdQty = document.createElement 'td'
        tdQty.style.textAlign = 'right'
        tdQty.textContent = order.quantity
        tr.appendChild tdQty

        #price
        tdPrice = document.createElement 'td'
        tdPrice.style.textAlign = 'right'
        tdPrice.textContent =
            '$' +
            order.price.toLocaleString 'en-US',
                minimumFractionDigits: 2, maximumFractionDigits: 2
        tr.appendChild tdPrice

        #tax
        tdTax = document.createElement 'td'
        tdTax.style.textAlign = 'right'
        tdTax.textContent =
            order.tax.toLocaleString(
                'en-US'
                minimumFractionDigits: 2, maximumFractionDigits: 2
            ) + '%'
        tr.appendChild tdTax

        #total
        tdTotal = document.createElement 'td'
        tdTotal.style.textAlign = 'right'
        tdTotal.textContent =
            '$' +
            (order.quantity *
                order.price *
                (1 + order.tax / 100)).toLocaleString 'en-US',
                minimumFractionDigits: 2, maximumFractionDigits: 2
        tr.appendChild tdTotal

        #delete button
        tdBtn = document.createElement 'td'
        btn = document.createElement 'button'
        btn.textContent = 'Delete'
        btn.addEventListener 'click', -> window.deleteOrder i
        tdBtn.appendChild btn
        tr.appendChild tdBtn

        tbody.appendChild tr

    #total row
    totalRow = document.createElement 'tr'
    tdEmpty = document.createElement 'td'
    tdEmpty.setAttribute 'colspan', '4'
    totalRow.appendChild tdEmpty
    tdTotalLabel = document.createElement 'td'
    tdTotalLabel.style.textAlign = 'right'
    tdTotalLabel.textContent =
        'Total: $' +
        total.toLocaleString 'en-US',
            minimumFractionDigits: 2, maximumFractionDigits: 2
    totalRow.appendChild tdTotalLabel
    totalRow.appendChild document.createElement 'td'
    tbody.appendChild totalRow

    table.appendChild tbody

    #replace previous content safely without using innerHTML
    orderList.replaceChildren table #set order list DOM output

window.deleteOrder = (
    i #function to delete order from list
) ->
    if confirm(
        'Are you sure you want to delete this task named ' +
            orders[i].names +
            '?'
    )
        orders.splice i, 1 #remove order from index i
        updateList()
