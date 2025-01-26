function dată()
{
  if(localStorage.getItem("logare"))
  {
    text=document.createElement("p");
    document.body.appendChild(text);
    text.innerHTML=`Ultima logare: ${localStorage.getItem("logare")}`;
  }
}

window.onload = function()
{

  dată();

  document.getElementById("signupForm").addEventListener("submit", function(event) {
      event.preventDefault();

      const username = document.querySelector("input[name=username_signup]").value;
      const password = document.querySelector("input[name=password_signup]").value;
      const confirmPassword = document.querySelector("input[name=confirmPassword_signup]").value;

      const isValid = password.length >= 8;

      if (!isValid) {
        alert("Parola trebuie sa conțină 8 caractere");
        return;
      }


      if (password !== confirmPassword) {
          alert("Parolele nu sunt identice");
          return;
      }

      const existingUser = localStorage.getItem(username);
      if (existingUser) {
          alert("Username-ul e folosit deja");
          return;
      }
      localStorage.setItem(username, password);
      alert("Sign up successful!");
  });

  document.getElementById("loginForm").addEventListener("submit", function(event) {
    event.preventDefault();

    username = document.querySelector("input[name=username_login]").value;
    password = document.querySelector("input[name=password_login]").value;

    if (localStorage.getItem(username) != null) {
      if(password == localStorage.getItem(username))
        alert("Te-ai logat");

        const currentDate = new Date();
        const d = currentDate.toLocaleDateString();
        localStorage.setItem("logare",d);


        window.location.href = "./index.html";
    }
    else{
      alert("Log-in eșuat");
    }

  });
}
