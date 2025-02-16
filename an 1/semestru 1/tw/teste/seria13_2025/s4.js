window.onload = function () {
  buton = document.querySelector("button");
  buton.addEventListener("click", function (event) {
    event.stopPropagation();
    //aici cerere
    fetch("s4.json")
      .then((response) => response.json())
      .then((raspus) => {if raspuns.includes()};

  });
};
