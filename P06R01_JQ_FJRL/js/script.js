$(function () {

  const pizzas = [
    { id: 1, name: "Pepperoni", desc: "Doble pepperoni y mozzarella derretida.", price: 149, category: "clasicas", img: "img/pizza-pepperoni.svg" },
    { id: 2, name: "Hawaiana", desc: "Jamón, piña y mozzarella.", price: 145, category: "clasicas", img: "img/pizza-hawaiana.svg" },
    { id: 3, name: "Cuatro Quesos", desc: "Mozzarella, parmesano, gorgonzola y provolone.", price: 169, category: "especiales", img: "img/pizza-cuatro-quesos.svg" },
    { id: 4, name: "BBQ Pollo", desc: "Pollo asado, salsa BBQ y cebolla morada.", price: 175, category: "especiales", img: "img/pizza-bbq-pollo.svg" },
    { id: 5, name: "Refresco 600ml", desc: "Bebida gaseosa bien fría.", price: 25, category: "bebidas", img: "img/drink-refresco.svg" },
  ];

  let cart = [];

  function renderMenu(filter) {
    const $grid = $("#menuGrid").empty();

    const items = filter === "todas" ? pizzas : pizzas.filter(p => p.category === filter);

    items.forEach(p => {
      const $card = $(`
        <article class="card" data-id="${p.id}">
          <div class="card__img"><img src="${p.img}" alt="${p.name}"></div>
          <div class="card__body">
            <h3 class="card__title">${p.name}</h3>
            <p class="card__desc">${p.desc}</p>
            <div class="card__footer">
              <span class="card__price">$${p.price.toFixed(2)}</span>
              <button class="card__add" aria-label="Agregar ${p.name}">+</button>
            </div>
          </div>
        </article>
      `);
      $grid.append($card);
    });
  }

  renderMenu("todas");

  $("#filters").on("click", ".filter-btn", function () {
    $(".filter-btn").removeClass("active");
    $(this).addClass("active");
    renderMenu($(this).data("filter"));
  });

  function saveCart() {
    localStorage.setItem("rosadoCart", JSON.stringify(cart));
  }

  function loadCart() {
    const saved = localStorage.getItem("rosadoCart");
    cart = saved ? JSON.parse(saved) : [];
  }

  function findPizza(id) {
    return pizzas.find(p => p.id === id);
  }

  function addToCart(id) {
    const existing = cart.find(item => item.id === id);
    if (existing) {
      existing.qty += 1;
    } else {
      cart.push({ id, qty: 1 });
    }
    saveCart();
    renderCart();
    showToast("Agregado al carrito");
    bumpCartIcon();
  }

  // Suma o resta unidades a un producto del carrito
  function changeQty(id, delta) {
    const item = cart.find(i => i.id === id);
    if (!item) return;
    item.qty += delta;
    
    if (item.qty <= 0) {
      cart = cart.filter(i => i.id !== id);
    }
    saveCart();
    renderCart();
  }

  // Elimina por completo un producto del carrito, sin importar su cantidad
  function removeFromCart(id) {
    cart = cart.filter(i => i.id !== id);
    saveCart();
    renderCart();
  }

  function renderCart() {
    const $items = $("#cartItems");

    const totalCount = cart.reduce((sum, i) => sum + i.qty, 0);
    $("#cartCount").text(totalCount);

    if (cart.length === 0) {
      $items.html('<p class="cart__empty" id="cartEmpty">Tu carrito está vacío</p>');
      $("#cartTotal").text("$0.00");
      return;
    }

    $items.empty();
    let total = 0;

    // Se genera una fila por cada producto del carrito
    cart.forEach(item => {
      const pizza = findPizza(item.id);
      if (!pizza) return; // seguridad por si el id ya no existe en el catálogo

      const subtotal = pizza.price * item.qty;
      total += subtotal;

      const $row = $(`
        <div class="cart-item" data-id="${pizza.id}">
          <div class="cart-item__img"><img src="${pizza.img}" alt="${pizza.name}"></div>
          <div class="cart-item__info">
            <div class="cart-item__name">${pizza.name}</div>
            <div class="cart-item__price">$${subtotal.toFixed(2)}</div>
          </div>
          <div class="cart-item__qty">
            <button class="qty-btn qty-minus" aria-label="Restar">-</button>
            <span>${item.qty}</span>
            <button class="qty-btn qty-plus" aria-label="Sumar">+</button>
          </div>
          <button class="cart-item__remove" aria-label="Eliminar">&times;</button>
        </div>
      `);
      $items.append($row);
    });

    // Muestra el total acumulado
    $("#cartTotal").text("$" + total.toFixed(2));
  }

  // Pequeña animación en el ícono del carrito al agregar un producto
  function bumpCartIcon() {
    $("#cartBtn").css("transform", "scale(1.15)");
    setTimeout(() => $("#cartBtn").css("transform", "scale(1)"), 150);
  }

  $("#menuGrid").on("click", ".card__add", function () {
    const id = parseInt($(this).closest(".card").data("id"), 10);
    addToCart(id);
  });

  $("#cartItems").on("click", ".qty-plus", function () {
    const id = parseInt($(this).closest(".cart-item").data("id"), 10);
    changeQty(id, 1);
  });

  // Botón "-" de una fila del carrito: decrementa la cantidad
  $("#cartItems").on("click", ".qty-minus", function () {
    const id = parseInt($(this).closest(".cart-item").data("id"), 10);
    changeQty(id, -1);
  });

  // Botón "x" de una fila del carrito: elimina el producto por completo
  $("#cartItems").on("click", ".cart-item__remove", function () {
    const id = parseInt($(this).closest(".cart-item").data("id"), 10);
    removeFromCart(id);
  });

  function openCart() {
    $("#cart").addClass("open");
    $("#overlay").addClass("show");
  }
  // Oculta el panel del carrito y el overlay
  function closeCart() {
    $("#cart").removeClass("open");
    $("#overlay").removeClass("show");
  }

  $("#cartBtn").on("click", openCart);
  // Botón "x" dentro del panel: lo cierra
  $("#cartClose").on("click", closeCart);
  $("#overlay").on("click", function () {
    closeCart();
    closeNav();
  });

  // Simula el envío del pedido al presionar "Realizar pedido"
  $("#checkoutBtn").on("click", function () {
    if (cart.length === 0) {
      showToast("Tu carrito está vacío");
      return;
    }
    showToast("¡Pedido realizado con éxito!");
    cart = [];
    saveCart();
    renderCart();
    closeCart();
  });

  function closeNav() {
    $("#nav").removeClass("open");
    $("#hamburger").removeClass("open");
  }

  $("#hamburger").on("click", function () {
    $("#nav").toggleClass("open");
    $(this).toggleClass("open");
  });

  // Al hacer click en cualquier link del menú, éste se cierra automáticamente
  $(".nav__link").on("click", closeNav);

  let toastTimer; // guarda el setTimeout activo para poder cancelarlo
  function showToast(message) {
    clearTimeout(toastTimer);
    $("#toast").text(message).addClass("show");
    toastTimer = setTimeout(() => $("#toast").removeClass("show"), 2200);
  }

  function setError(fieldId, message) {
    $("#" + fieldId).toggleClass("invalid", !!message);
    $("#" + fieldId + "Error").text(message || "");
  }

  function validateForm() {
    let valid = true;

    const name = $("#name").val().trim();
    if (name.length < 3) {
      setError("name", "Ingresa un nombre válido (mínimo 3 caracteres).");
      valid = false;
    } else {
      setError("name", "");
    }

    const message = $("#message").val().trim();
    if (message.length < 10) {
      setError("message", "Tu mensaje debe tener al menos 10 caracteres.");
      valid = false;
    } else {
      setError("message", "");
    }

    return valid;
  }

  // Evento submit del formulario: evita el envío real (recarga de página) y valida
  $("#contactForm").on("submit", function (e) {
    e.preventDefault();
    $("#formSuccess").removeClass("show");

    if (validateForm()) {
      // Si todo es válido: muestra mensaje de éxito y limpia el formulario
      $("#formSuccess").addClass("show");
      this.reset();
      $(".form-group input, .form-group textarea").removeClass("invalid");
      // El mensaje de éxito se oculta solo después de 4s
      setTimeout(() => $("#formSuccess").removeClass("show"), 4500);
    }
  });

  $("#contactForm input, #contactForm textarea").on("blur", validateForm);

  $(window).on("scroll", function () {
    $(".header").css("box-shadow", $(window).scrollTop() > 10 ? "0 2px 12px rgba(0,0,0,0.06)" : "none");
  });

  
  $("#year").text(new Date().getFullYear());
  loadCart();
  renderCart();
});
