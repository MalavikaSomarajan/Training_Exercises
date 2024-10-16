
function Product(name, price, quantity) {
      this.name = name;
      this.price = price;
      this.quantity = quantity;
}

Product.prototype.updateQuantity = function(newQuantity) {
      this.quantity = newQuantity;
};

Product.prototype.getDetails = function() {
     return {
     name: this.name,
     price: this.price,
     quantity: this.quantity
};
};

let inventory = [];

function addProduct() {
     const name = document.getElementById('productName').value;
     const price = parseFloat(document.getElementById('productPrice').value);
     const quantity = parseInt(document.getElementById('productQuantity').value);

if (name && !isNaN(price) && !isNaN(quantity)) {
      let productExists = false;

    inventory.forEach(product => {
        if (product.name === name) {
             product.updateQuantity(product.quantity = quantity); 
            productExists = true;
        }
   });

    if (!productExists) {
         const newProduct = new Product(name, price, quantity);
         inventory.push(newProduct);
   }

    document.getElementById('productName').value = '';
    document.getElementById('productPrice').value = '';
    document.getElementById('productQuantity').value = '';

    displayInventory();
} 

else {
    alert('Please fill out all fields correctly.');
}
}

function displayInventory() {
     const inventorylist = document.getElementById('inventory-list');    
     const table = document.getElementById('inventoryTable');
     const tbody = document.getElementById('inventoryBody');

    if(inventory.length=== 0){
      inventorylist.style.display= 'none';
    }

    inventorylist.style.display = 'block';
    table.style.display = 'table';

    tbody.innerHTML = '';

     inventory.forEach(product => {
         const row = document.createElement('tr');
         row.innerHTML = `
         <td>${product.name}</td>
         <td>$${product.price.toFixed(2)}</td>
         <td>${product.quantity}</td>
        `;
         tbody.appendChild(row);
    });
}