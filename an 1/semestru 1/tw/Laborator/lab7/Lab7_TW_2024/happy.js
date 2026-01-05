window.addEventListener("load",function(){
    let container = document.getElementById("container");
    let paragraf = document.querySelector("#game p")
    let score = document.getElementById("scor");
    paragraf.style.visibility="visible";
    let s=0;
    for (let i=0;i<20;i++)
    {

        let imagine = document.createElement("img");
        imagine.src="sad.png";
        imagine.alt="sad";
        container.appendChild(imagine);

        imagine.addEventListener("click",function(){
            if (imagine.alt=="sad")/*(imagine.src.slice(imagine.src.lastIndexOf("/")+1)=="sad.png")*/
            {
                imagine.src="happy.png";
                imagine.alt="happy"
                s++;
            }
            else {
                imagine.src="sad.png";
                s--;
            }
            score.innerHTML=`${s}`;
        });
    }
    setTimeout(function(){
        document.querySelector("h1").innerHTML = "Jocul s-a terminat!";
        container.remove();
    }
    ,10000);
});
