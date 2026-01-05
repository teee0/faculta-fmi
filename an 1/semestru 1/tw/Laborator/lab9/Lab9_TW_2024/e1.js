window.onload = function()
{
    let select = document.getElementById("numar");
    let input  = document.getElementById("rezervari");
    let finalizeaza = document.getElementById("finalizeaza");
    let container = document.querySelector(".container");

    select.onchange = function()
    {
        let n = parseInt(select.value);
        let array=[];
        for(let i = 0; i<n; i++)
        {
            let b = document.createElement("button");
            b.innerHTML = `${i+1}`;
            container.appendChild(b);
            b.style.backgroundColor = "lightgreen";

            b.onclick=function(){
                if(b.style.backgroundColor=="lightgreen")
                {
                    b.style.backgroundColor="red";
                    array.push(parseInt(b.innerHTML));
                }
                else
                {
                    b.style.backgroundColor="lightgreen";
                    array=array.filter(function(a){return a!==parseInt(b.innerHTML);})
                }
                array.sort(function(a,b){return a-b;});
                input.value=array.join(',');
            }
        }
    }
}
