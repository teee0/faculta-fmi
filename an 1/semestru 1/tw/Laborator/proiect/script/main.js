window.onload = function()
{

  if (localStorage.getItem("loggedIn")!="true") {
    localStorage.setItem("loggedIn","true");
    window.location.href = "./login.html";
  }


  else if(localStorage.getItem("loggedIn") )
  {
    footer = document.querySelector("footer");

    butonsus = document.createElement("button");

    butonsus.innerHTML = "log out";

    butonsus.style.padding = "0.2vw 0.5vw";
    butonsus.style.fontSize = "1em";
    butonsus.style.position = "relative";
    butonsus.style.left = "45%";

    butonsus.style.cursor = "pointer";

    butonsus.type = "button";
    butonsus.addEventListener("click", function() {
                                        localStorage.clear();
                                        window.location.href = "./login.html";
                                       }
                              );

    footer.appendChild(butonsus);


    setInterval(function()
                {
                  const randomColor = `rgb(${Math.random() * 255}, ${Math.random() * 255}, ${Math.random() * 255})`;
                  butonsus.style.backgroundColor = randomColor;
                }, 1000);
  }

  document.querySelector("footer").addEventListener("click", function(event) {
    event.target.classList.add("clicked");

    event.stopPropagation();
  });

}
