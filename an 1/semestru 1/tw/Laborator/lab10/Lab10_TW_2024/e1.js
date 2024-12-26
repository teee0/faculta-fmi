window.onload = function(){
    let buton = document.getElementById('salveaza');
    let input = document.getElementById('mesaj');
    let paragraf = document.querySelector(".afiseaza");

    let mesajSalvat = localStorage.getItem("mesaj");
    if ( mesajSalvat ){
        paragraf.textContent = mesajSalvat;
    }

    input.onclick = function(event){
        event.stopPropagation();
    }

    buton.onclick = function(event){
        event.stopPropagation();

        let mesajCurent = input.value;
        localStorage.setItem("mesaj",mesajCurent);
        alert("Mesajul a fost salvat!");
        paragraf.textContent=mesajCurent;
    }

    document.body.onclick = function(){
        /*console.log(event.target.tagName);*/
        localStorage.removeItem("mesaj");
        paragraf.textContent = "Niciun mesaj salvat încă.";
    }
}
