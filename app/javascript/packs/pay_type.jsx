import React from 'react'
import ReactDom from 'react-dom'
import PayTypeSelector from 'PayTypeSelector'

document.addEventListener("turbolinks:load", function(){
  var element =  document.getElementById("pay-type-component");
  ReactDom.render(<PayTypeSelector/>, element);

})