def citeste_programul_cinematografelor(filename):
    program = {}

    with open(filename, 'r') as f:
        for linie in f:
            # Eliminăm caracterele de la finalul liniei
            linie = linie.strip()

            # Separăm părțile liniei folosind '%'
            parti = linie.split(' % ')

            # Primele două părți sunt numele cinematografului și filmul
            nume_cinematograf = parti[0]
            nume_film = parti[1]
            ore_difuzare = parti[2].split()  # Orele de difuzare sunt separate prin spațiu

            # Adăugăm în dicționar
            if nume_cinematograf not in program:
                program[nume_cinematograf] = {}
            program[nume_cinematograf][nume_film] = ore_difuzare

    return program

def afiseaza_program(program):
    for cinematograf, filme in program.items():
        print(f"Cinematograful {cinematograf}:")
        for film, ore in filme.items():
            print(f"  Filmul {film} este difuzat la orele: {', '.join(ore)}")
        print()

# Citirea și afisarea programului din fișierul 'cinema.in'
program_cinematografe = citeste_programul_cinematografelor('cinema.in')
afiseaza_program(program_cinematografe)
