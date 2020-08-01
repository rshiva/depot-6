import consumer from "./consumer"

document.addEventListener('turbolinks:load',() => {
  const element = document.getElementById("product_comments")
  const product_id = element.getAttribute("data-product-id")
  consumer.subscriptions.create({channel: "ProductsChannel", product_id: product_id}, {
    connected() {
      console.log("connect to Products Channel")
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log("receving data --",data)
      const messagesContainer = document.getElementById("product_comments")
      messagesContainer.innerHTML = messagesContainer.innerHTML + data.html

      const storeElement = document.querySelector("main.store")
      if (storeElement) {
        storeElement.innerHTML = data.html
        
      }
    }
  });
})

