window.onload=function()
{
    let input = document.getElementById("cuvant");
    let limba = document.getElementById("limba");
    let form = document.getElementById("form");

    let div = document.getElementById("rezultat");

    form.onsubmit = function(event)
    {
        event.preventDefault();//nu se mai trimit datele la server

        let cuvant = input.value;
        let limba = input.value;

        let url="http://localhost:8000/dictionar.json";
        fetch(url).then(function(raspuns){
            if (raspuns.status == 200)
            {
                return response.json();
            }
            else
            {
                throw new Error(`A apărut o eroare: statusul este ${response.status}`);
            }
        })
        .then(function(date)
        {
            let traducere = "Nu exista cuvantul";
            for (let ob of date){
                if(cuvant == ob.cuvant)
                {
                    traducere=ob[limba];
                }
                div.innerHTML = traducere;
            }
        })
        .catch(function(error)
        {
            console.log(error.message)
        })

    }
}
