fetch("http://type.fit/api/quotes")
.them(function f(response){
    return response.json();
})
.then (function f(value){
    console.log(value);
})




fetch("https://sabohema.com")
  .then(function f(response) {
    return response.json();
  })
  .then(function f(data) {
    console.log(data);
  });


  fetch("https://type.fit/api/quotes")
  .then(function(response) {
    return response.json();
  })
  .then(function(data) {
    console.log(data);
  });