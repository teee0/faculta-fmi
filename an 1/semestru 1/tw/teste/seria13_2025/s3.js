window.onload = function () {
  let box = document.getElementById("pauza");
  let lista = document.querySelectorAll("li");
  li.forEach((element) => {
    element.style.order = `${i}`;
  });

  box.addEventListener("change", function (event) {
    if (box.checked) {
      li.forEach((element) => {
        element.style.order = `${parseInt(element.style.order) + 1}`;
      });
    }
  });
};
