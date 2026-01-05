#include <iostream>
#include <string>
#include <vector>

class Curs {};

class Student {
	std::string nume = "Ion";
	int an = 1;
	int grupa;
public:
	Student() {
		std::cout << "constr implicit student\n";
	}
	~Student() {
		std::cout << "destr student " << nume
		  << "\n";
	}
	Student(const Student& other)
		: nume(other.nume), an(other.an),
			grupa(other.grupa)
	{
		std::cout << "cc stud " << nume << "\n";
	}
	Student& operator=(const Student& other) {
		nume = other.nume;
		an = other.an;
		grupa = other.grupa;
		std::cout << "op= stud " << nume << "\n";
		return *this;
	}
	Student(std::string nume_, int an_, int grupa_)
		: nume(nume_), an(an_), grupa(grupa_) {
			//this->nume = nume_;
			//this->nume.operator=(nume_);
		std::cout << "constr init student "
		  << nume << "\n";
	}
	explicit Student(std::string nume_) : Student(nume_, 1, 150)
		 {
			//this->nume = nume_;
			//this->nume.operator=(nume_);
		std::cout << "constr init student "
		  << nume << "\n";
	}
	const std::string& getNume() const {
		// return nume;
		return this->nume;
	}
	void setNume(const std::string& nume_) {
		// logica speciala daca vrem
		// if(this->nume.empty())
			this->nume = nume_;
	}
	int getAn() const { return an; }
	void setAn(int an_) { an = an_; }
	int getGrupa() const { return grupa; }
	void setGrupa(int grupa_) { grupa = grupa_; }
	friend std::ostream& operator<<(std::ostream& os, const Student& student);
};

std::ostream& operator<<(std::ostream& os, const Student& student) {
	/*os << student.getNume() << " "
	   << student.getAn() << " "
	   << student.getGrupa() << "\n";*/
	os << student.nume << " "
	   << student.an << " "
	   << student.grupa << "\n";
	return os;
}

class Facultate {
	std::string nume;
	// std::vector<Student> studenti;
	Student student;
public:
	// Facultate(std::string nume_, const std::vector<Student>& studenti_) {
	Facultate(const std::string& nume_, const Student& student_)
	 : nume(nume_), student(student_) {
		// nume = nume_;
		std::cout << "constr facultate\n";
		// studenti = studenti_;
		// student = student_;
	}
};

void f(Student st) {
	// st.getNume() = "abc";
	std::cout << "f cu student\n";
}

void f(const std::string& st) {
	std::cout << "f cu string\n";
}

int main() {
	Curs c1, c2;
	Curs c3(c1), c4 = c2;
	c1 = c3;
	Student st1, st2;
	Student st3("Johnny", 1, 151);
	Student st4("Johann", 1, 152);
	// Student st5 = std::string("Ionica");
	f(std::string("Ioo"));
	st1.setNume("John");
	st1.setGrupa(151);
	st2.setNume("Iona");
	st2.setAn(2);
	st2.setGrupa(152);
	// in loc de
	// std::cout << st1.nume;
	// avem getter pt mai multa
	// flexibilitate + mai mult control
	// std::cout << st1.getNume() << " " << st1.getAn() << " " << st1.getGrupa() << "\n";
	// std::cout << st2.getNume() << " " << st2.getAn() << " " << st2.getGrupa() << "\n";
	// std::cout << st3.getNume() << " " << st3.getAn() << " " << st3.getGrupa() << "\n";
	std::cout << st1 << st2 << st3;
	operator<<(std::cout, st3.getNume());
	// in loc de
	// st1.nume = "ceva";
	// avem setters
	st1.setNume("ceva");
	std::vector<Student> studenti{st1, st2, st3};
	std::cout << "inainte de facultate\n";
	// Facultate f1("fmi", studenti);
	Facultate f1("fmi", st1);
	std::cout << "dupa facultate\n";
	return 0;
}
