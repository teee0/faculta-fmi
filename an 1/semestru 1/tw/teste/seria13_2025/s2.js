window.onload = function () {
  document.body.style.width = "100vw";
  document.body.style.height = "100vh";
  document.body.addEventListener("keydown", function (event) {
    if (event.key === "b") {
      let buton = document.createElement("button");
      document.body.appendChild(buton);
      buton.style.height = "50px";
      buton.style.width = "100px";
      buton.className = `color${Math.floor(Math.random() * 5) + 1}`;
      buton.innerHTML = window.getComputedStyle(buton).backgroundColor;

      buton.onclick = function (event) {
        event.stopPropagation();
      };
    }
  });
  document.body.addEventListener("click", function (event) {
    let butoane = document.querySelectorAll("button");
    alert(butoane.length);
  });
};
