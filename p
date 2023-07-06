#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;
ofstream file("Accounts.txt", ios::app);
ifstream f("Accounts.txt");
fstream read_file("Accounts.txt");

class Account
{
    int id;
    string fName;
    string sName;
    string password;
    double balance;

public:
    Account() {}
    Account(int id, string password)
    {
    }
    ~Account() {}

    string getFName()
    {
        return this->fName;
    }

    string getSName()
    {
        return this->sName;
    }
    void setFName(string name){
        fName=name;
    }
    void setSName(string name){
        sName=name;
    }
    string getPassword()
    {
        return this->password;
    }

    bool checkPassword(string password)
    {
        return (this->password == password);
    }

    double getBalance()
    {
        return this->balance;
    }

    void setBalance(double balance)
    {
        this->balance = balance;
    }
    void setId(int id)
    {
        this->id = id;
    }

    int getID()
    {
        return this->id;
    }

    void toString()
    {
        cout << "\n\n\\*************************\"ATM System\"************************************\\\n\n";
        cout << "Hello\nYour Account info\n"
             << "Your Name: " << this->fName << " " << this->sName
             << endl
             << "Password: " << this->password << endl
             << "Your Balance: " << this->balance << endl;
        cout << "\n\n\\***************************\"End\"**************************************************\\\n\n";
    }
};



class Deposite : public Account
{
    double amountIn;
public:

    Deposite(int id,double amount,double balance,string firstname,string lastname,string password)
    {
        ofstream file("Accounts.txt", ios::app);
ifstream f("Accounts.txt");
fstream read_file("Accounts.txt");
        amountIn=amount;
        vector<string> lines;
        string line;
        while (getline(read_file, line))
        {
                lines.push_back(line);
        }
          read_file.close();
            ofstream write_file("Accounts.txt");
            id--;
          for (int i = 0; i < lines.size(); i++)
            {
                if (i != id)
                write_file << lines[i] << endl;
                else
                write_file << (id+1) << " " << firstname << " " << lastname << " " << password << " " << (balance+amount) << endl;
            }
              write_file.close();

    }

    double getAmountIn()
    {
        return this->amountIn;
    }
};
class Withdraw : public Account
{
    double amountOut;

public:
    Withdraw(int id,double amount,double balance,string firstname,string lastname,string password)
    {
        ofstream file("Accounts.txt", ios::app);
ifstream f("Accounts.txt");
fstream read_file("Accounts.txt");
        amountOut = amount;
        if (amount > balance)
        {
            cout << "No enough money";
        }
        else
        {
            vector<string> lines;
        string line;
        while (getline(read_file, line))
        {
                lines.push_back(line);
        }
          read_file.close();
            ofstream write_file("Accounts.txt");
            id--;
          for (int i = 0; i < lines.size(); i++)
            {
                if (i != id)
                write_file << lines[i] << endl;
                else
                write_file << (id+1) << " " << firstname << " " << lastname << " " << password << " " << (balance-amount) << endl;
            }
              write_file.close();
        }
    }
    double getAmountOut()
    {
        return this->amountOut;
    }
};

class Transfer : public Account
{
private:
    double amount_transfer;
    int targetId;

public:
    Transfer(double amount, int targetId, int userId, double Balance, string fstname, string scname,string password)
    {
        ofstream file("Accounts.txt", ios::app);
ifstream f("Accounts.txt");
fstream read_file("Accounts.txt");
        int line = 0;
        int flag = 0;
        string s;
        string fname = "", sname= "",pass = "",balance = "";
        while (!f.eof())
        {
            line++;
            if (line == targetId)
            {
                getline(f,s);
                flag = 1;
                break;
            }
        }
        int n = 0;
        for(int i = 0; i < s.size(); i++)
        {
            if(n == 1){
                fname += s[i];
            }else if(n == 2)
                sname += s[i];
            else if(n == 3)
            {
                pass += s[i];
            }else if(n == 4)
                balance += s[i];
            if(s[i] == ' ')
                n++;
        }
        if (flag)
        {
            Withdraw b(userId,amount,Balance,fstname,scname, password);
            Deposite d(targetId,amount,stod(balance),fname,sname,pass);
        }
        else
        {
            cout << "ID Not Found!\n";
        }
    }
};

struct new_User
{
    string Fname;
    string Sname;
    string pass;
};
struct Already
{
    int ID;
    string pass;
};
void printOptions()
{
    cout << "\n1- New User\n2- Already User\n3- Exit \n\n";
}
void printOptions2()
{
    cout << "1- Deposite \n2- Withdrow \n3- Transfer \n4- Go Back \n5- Exit\n\n";
}
int main()
{
    int choice;

    while (true)
    {
        cout << "\nSelect an option:" << endl;
        printOptions();
        cout << "Enter your choice: ";
        cin >> choice;
        switch (choice)
        {
        case 1:
        {
            ifstream f("Accounts.txt");
            ofstream file("Accounts.txt", ios::app);
            new_User user;
            cout << "Enter the user's first name: ";
            cin >> user.Fname;
            cout << "Enter the user's second name: ";
            cin >> user.Sname;
            int lines = 0;
            cout << "Enter the user's pass: ";
            cin >> user.pass;
            while (!f.eof())
            {
                lines++;
                string s;
                getline(f, s);
            }
            file << lines << " " << user.Fname << " " << user.Sname << " " << user.pass << " " << 0;
            file << "\n";
            break;
        }
        case 2:
        {
            Already user;
            cout << "Enter the user's ID: ";
            cin >> user.ID;
            cout << "Enter the user's pass: ";
            cin >> user.pass;
            ifstream f("Accounts.txt");
            int lines = 0;
            string tmp;
            string bal;
            string firstname,lastname;
            double balance;
            int checkid = 0;
            while (!f.eof())
            {
                string s;
                lines++;
                getline(f, s);
                if (lines == user.ID)
                {
                    int n = 0;
                    checkid = 1;
                    for (int i = 0; i < s.length(); i++)
                    {
                        if(n==1 && s[i]!= ' '){
                            firstname+=s[i];
                        }
                        if(n==2 && s[i]!= ' '){
                            lastname+=s[i];
                        }
                        if(n==3&&s[i]!=' '){
                            tmp+=s[i];
                        }
                        if(n==4&&s[i]!=' '){
                            bal+=s[i];
                        }
                        if (s[i] == ' ')
                        {
                            n++;
                        }
                    }
                    break;
                }
            }
            if (checkid == 0 || tmp == "")
            {
                cout << "id not found\n";
                break;
            }
            if (tmp == user.pass)
            {
                cout << "\nSelect an option:" << endl;
                printOptions2();
                int option;
                double amount;
                int id;
                balance = stod(bal);
                do
                {
                    cout << "Eneter An Option: ";
                    cin >> option;
                    switch (option)
                    {
                    case 1:
                    {
                        cout << "Enter Amount To Deposite: ";
                        cin >> amount;

                        Deposite d(user.ID,amount,balance,firstname,lastname,tmp);
                        break;
                    }
                    case 2:
                    {
                        cout << "Enter Amount To Withdraw: ";
                        cin >> amount;
                        Withdraw wd(user.ID,amount,balance,firstname,lastname,tmp);
                        break;
                    }
                    case 3:
                    {
                        cout << "Enter Amount To Transfer: ";
                        cin >> amount;
                        cout<<"Enter the id for the recipient : ";
                        cin>>id;
                        //double amount, int targetId, int userId, double Balance, string fstname, string scname,string password
                        Transfer(amount,id,user.ID,balance,firstname,lastname,tmp);
                        break;
                    }
                    case 4:
                    {
                        continue;
                    }
                    case 5:
                    {
                        return 1;
                    }
                    }
                    if (option > 5)
                        cout << "Option Not Found, Please Enter a Corrct Option.\n";
                } while (option > 5);
            }
            else
            {
                cout << "pass not correct\n";
                cout<<user.ID << " " << firstname << " " << lastname << " " << bal <<endl;
                break;
            }
            break;
        }

        case 3:
        {
            return 1;
        }
        default:
        {
            cout << "Invalid choice. Please try again." << endl;
            break;
        }
        }
    }
    file.close();
    f.close();
}
