from django.shortcuts import render
from django.http import HttpResponse

from datetime import datetime
from itertools import count
#from urllib.parse import urlparse
'''Creați o clasă numită Accesare cu proprietățile id, ip_client,  url și data. 
Proprietatea id se autoincrementeaza la crearea unei noi instante a clasei Accesare.
Creați metodele:
lista_parametri() care returnează o listă de tupluri unde prima valoare e numele parametrului și a doua e valoarea (None daca nu e setat)
url() care returnează tot url-ul împreuna cu query string
data() care returnează un obiect de tip datetime și primește ca parametru un string de formatare
pagina() care returnează doar numele paginii accesate din cadrul aplicatiei (fara domeniu sau parametri). De exemplu, / sau /info.
'''

def log_request( r ):
    return 0    
class Accesare:
    id_it = count(1)
    # constructor
    def __init__(request):
        self.id = next(self.id_it)
    
    def id(self):
        return self._id

    def lista_parametri(self):
        pass
    
    def url(self):
        return self._

    def data(self, format_string):
        return self._data.strftime(format_string)

    def pagina(self):
        url_parsat = urlparse(self._url)
        return url_parsat.netloc
    



def testt():
    x = Accesare("11.11.111","http://www.ceva.com/altceva")
    return urlparse(x.url()).netloc #x.pagina()

def index(request):
    log_request(request)
    return HttpResponse(f'''
                     <html>
                     <body>
                     <p><b>Primul</b> raspuns </p>
                     <p>{testt()}</p>
                     </body>
                     </html>
                     ''')

def info(request):
    log_request(request)
    return HttpResponse(f'''
                     <html>
                     <body>
                     <h1>Informații despre server</h1>
                     <p>{request.GET.get("data")}</p>
                     <p>{request.GET.getlist("a","b")}</p>
                     </body>
                     </html>
                     ''')

def log(request):
    log_request(request)
    return HttpResponse(f'''
                     <html>
                     <body>
                     <h1>Informații despre server</h1>
                     <p>{request.GET.get("data")}</p>
                     <p>{request.GET.getlist("a","b")}</p>
                     </body>
                     </html>
                     ''')

def functie(request):
    val_a=request.GET.get("a")
    val_b=request.GET.get("b",10)
    return HttpResponse(f"{val_a} {val_b}")