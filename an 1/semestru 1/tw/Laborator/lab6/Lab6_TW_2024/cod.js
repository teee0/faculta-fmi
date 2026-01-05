/*let coșCumpărături
={
    cașcaval: "12.5 RON",
    făină: "3 RON",
    ouă: "5 RON",
    unt: "10 RON"
};

function calc(o)
{
    s=0;
    for (let i in o){
        s+=parseFloat(o[i]);
    }
    return s;
}
function adaugăIngredient(ingredient, preț)
{
    coșCumpărături.ingredient=preț;
    console.log(`ingredient nou: ${ingredient}, prețul ${preț}`);
}
*/
games=[
    {   name:        "The Last of Us",
        alt_names:    ["TLoU","The Last of Us Remastered","TLoU Remastered"],
        launch_date: 2012,
        price:       "50 RON"
    },
    {   name:        "Metro Last Light",
        alt_names:    ["Metro Redux Last Light"],
        launch_date: 2014,
        price:       "60 RON"
    },
    {   name:        "Metro 2033",
        alt_names:    ["Metro Redux 2033"],
        launch_date: 2014,
        price:       "60 RON"
    }
];
function calcJocuri(listă)
{
    sumă=0;
    for (let o of listă){
        sumă+=parseFloat(o.price);
    }
    return sumă;
}

function cautăJoc(nume)
{
    for (g of games)
    {
        if (g.name==nume || g.alt_names.includes(nume))
            return g;
    }
    return null;
}

function afișeazăJocul()
{
    let jocCăutat = prompt("Numele jocului");
    let g = cautăJoc(jocCăutat);
    if(g){
        alert(`Jocul ${g.name}/${g.alt_names.join("/")} s-a lansat în anul ${g.launch_date} și are prețul de ${g.price}`);
    }
}

function cautăPreț(preț)
{
    let jocuriGăsite=[];
    for (g of games)
    {
        if (g.price<=preț)
            jocuriGăsite.push(g);
    }
    return jocuriGăsite;
}
function afișeazăJocul()
{
    let prețMaxim = prompt("Prețul maxim");
    let jocuriGăsite = cautăPreț(prețMaxim);
    if(jocuriGăsite.length>0){
        alert(`Jocurile de ${prețMaxim} RON sau sub sunt ${jocuriGăsite[0]/*nescris*/}`)
    }
}
/*
console.log(calc(coșCumpărături));
adaugăIngredient("sare", "2 RON");

console.log(calc(coșCumpărături));
*/
//console.log(calcJocuri(games));
afișeazăJocul()
