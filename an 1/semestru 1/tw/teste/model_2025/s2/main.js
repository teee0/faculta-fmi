window.onload = function () {
  for (let i = 1; i <= Math.floor(Math.random() * 6) + 5; i++) {
    let sq = document.createElement("div");
    document.body.appendChild(sq);
    sq.className = "patrat";
    sq.style.top = `${Math.floor(Math.random() * (window.innerHeight - 50))}px`;
    sq.style.left = `${Math.floor(Math.random() * (window.innerWidth - 50))}px`;

    sq.addEventListener("click", function (event) {
      event.stopPropagation();
      sq.style.left = `${parseInt(sq.style.left) + 10}px`;
    });
  }
  document.body.addEventListener("click", function (event) {
    const patrate = document.querySelectorAll(".patrat");
    patrat_curent = patrate[Math.floor(Math.random() * patrate.length)];
    patrat_curent.style.top = `${event.clientY}px`;
    patrat_curent.style.left = `${event.clientX}px`;
  });
};
