def citire():
	with open("copaci.in") as fin:
		st,jos = [int(x) for x in fin.readline().split()]
		dr,sus = [int(x) for x in fin.readline().split()]
		L_copaci = [ tuple([int(x) for x in linie.split()]) for linie in fin]
		
		dreptunghi = (st, jos, dr, sus)
		fin.close()
		return dreptunghi, L_copaci
		
def dr_max(st,jos,dr,sus,L_copaci):
	for x,y in L_copaci:
		if st < x < dr and jos < y < sus:
			#taiere pe orizontala => jos,sus
			aria1, dr1 = dr_max(st, jos, dr, y)
			aria2, dr2 = dr_max(st, y, dr, sus)
			
			#taiere pe verticala => st,dr
			aria1, dr1 = dr_max(st, jos, x, sus)
			aria2, dr2 = dr_max(x, jos, dr, sus)
			
			aria,dreptunghi = max([(aria1, dr1), (aria2, dr2),
									(aria3, dr3), (aria4,dr4)])
			break
	else:
		aria = (dr-st)*(sus-jos)
		dreptunghi=(st,jos,dr,sus)
	return aria,dreptunghi
