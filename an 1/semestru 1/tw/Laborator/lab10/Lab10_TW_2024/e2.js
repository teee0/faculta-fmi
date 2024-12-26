window.onload = function()
{
    let inputNume = document.getElementById('nume');
    let inputEmail = document.getElementById('email');
    let inputVarsta = document.getElementById('varsta');

    let buton = document.getElementById('salveaza');
    let paragraf = document.querySelector("div#informatii p");

    let array;
    if ( array ){
        array= JSON.parse(localStorage.getItem("date"));
        // paragraf.textContent=dateSalvate;
        for (let el of array){
            paragraf.innerHTML=`${el.name}, ${el.email}, ${email.varsta}`;
        }
    }

    // input.onclick = function(event){
    //     event.stopPropagation();
    // }

    buton.onclick = function(event){
        event.stopPropagation();

        ob={nume:inputNume.value, email:inputEmail.value, varsta:inputVarsta.value};
        array.push(ob);
        localStorage.setItem("date",JSON.stringify(array));
        alert("Datele au fost salvate!");
        // paragraf.textContent=JSON.stringify(ob);
        for (let el of array){
            paragraf.innerHTML=`${el.name}, ${el.email}, ${email.varsta}`;
        }
    }

    document.body.onclick = function(){
        /*console.log(event.target.tagName);*/
        localStorage.removeItem("mesaj");
        paragraf.textContent = "Niciun mesaj salvat încă.";
    }
}
