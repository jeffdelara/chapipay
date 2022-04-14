console.log('cart update');

const quantities = document.querySelectorAll('.quantity');

const updateSubtotal = (cartItem) => {
  const subtotal = document.getElementById(`cart_item_subtotal_${cartItem.id}`);
  const subtotalAmount = cartItem.quantity * cartItem.product.price;
  subtotal.dataset.subtotal = subtotalAmount;
  subtotal.textContent = subtotalAmount;
}; 

const updateTotal = () => {
  const subtotals = document.querySelectorAll('.subtotals');
  
  let total = 0.0;
  subtotals.forEach(element => {
    total += +element.dataset.subtotal;
  });

  const totalView = document.getElementById('cart_item_total');
  totalView.textContent = total;
}

const headers = {
  'Content-Type': 'application/json',
  'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
};

const updateCart = (cartId, quantity) => {
  const url = `/cart/${cartId}`;
  const payload = {
    cart_items: {
      quantity: quantity,
      id: cartId
    }
  }
  const options = {
    method: 'PATCH', 
    headers: headers, 
    body: JSON.stringify(payload)
  }

  fetch(url, options)
    .then(response => {
      return response.json();
    })
    .then(data => {
      if (data.status === 'ok') {
        updateSubtotal(data.cart_item);
        updateTotal();
      }
    })
};

quantities.forEach(element => {
  element.addEventListener('change', (event) => {
    const cartId = element.dataset.cartId;
    const quantity = element.value;

    updateCart(cartId, quantity);
  });
});

