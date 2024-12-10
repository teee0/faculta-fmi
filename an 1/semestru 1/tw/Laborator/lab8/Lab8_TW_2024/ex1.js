window.addEventListener("load",function(){
    document.body.addEventListener("click",function(event){
        let notificare = document.createElement("div");
        notificare.innerHTML = "<p>Aceasta este o notificare!</p>";
        notificare.className = "popup";
        document.body.appendChild(notificare);
    })
});
