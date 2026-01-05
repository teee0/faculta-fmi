#include <iostream>
#include <algorithm>

using namespace std;

struct Node {
    int key;
    int val;
    int height;
    Node* left;
    Node* right;

    Node(int k, int v)
        : key(k), val(v), height(1), left(nullptr), right(nullptr) {}
};

class AVLTree {
public:
    AVLTree() : root(nullptr) {}

    void insert(int key, int val) {
        root = insert(root, key, val);
    }

    void remove(int key) {
        root = remove(root, key);
    }

    Node* search(int key) {
        return search(root, key);
    }

private:
    Node* root;

    int height(Node* node) {
        return node ? node->height : 0;
    }

    int balanceFactor(Node* node) {
        return height(node->left) - height(node->right);
    }

    void updateHeight(Node* node) {
        node->height = 1 + max(height(node->left), height(node->right));
    }

    Node* rotateRight(Node* y) {
        Node* x = y->left;
        Node* T2 = x->right;
        x->right = y;
        y->left = T2;
        updateHeight(y);
        updateHeight(x);
        return x;
    }

    Node* rotateLeft(Node* x) {
        Node* y = x->right;
        Node* T2 = y->left;
        y->left = x;
        x->right = T2;
        updateHeight(x);
        updateHeight(y);
        return y;
    }

    Node* rebalance(Node* node) {
        updateHeight(node);
        int balance = balanceFactor(node);

        if (balance > 1) {
            
            if (balanceFactor(node->left) < 0) //LR
                node->left = rotateLeft(node->left);
            //LL
            return rotateRight(node);
        }

        if (balance < -1) {
            if (balanceFactor(node->right) > 0) //RL
                node->right = rotateRight(node->right);
            //RR
            return rotateLeft(node);
        }

        return node;
    }

    Node* insert(Node* node, int key, int val) {
        if (!node)
            return new Node(key, val);
        //parcurgere pana la nod
        if (key < node->key)
            node->left = insert(node->left, key, val);
        else if (key > node->key)
            node->right = insert(node->right, key, val);
        else {
            //dacă există deja actualizează valoarea
            node->val = val;
            return node;
        }

        return rebalance(node);
    }

    Node* minValueNode(Node* node) {
        Node* current = node;
        while (current->left)
            current = current->left;
        return current;
    }

    Node* remove(Node* node, int key) {
        if (!node) return nullptr;

        //parcurgere pana la nod
        if (key < node->key)
            node->left = remove(node->left, key);
        else if (key > node->key)
            node->right = remove(node->right, key);
        else {
            //caz în care nodul are 0 sau 1 fiu
            if (!node->left || !node->right) {
                //nodul se înlocuiește cu fiul pe care îl are sau cun null dacă nu are
                Node* temp = node->left ? node->left : node->right;
                delete node;
                return temp;
            }
            //caz în care nodul are 2 fii 
            else {
                //nodul se înlocuiește în arbore cu fiul drept
                Node* temp = minValueNode(node->right);
                node->key = temp->key;
                node->val = temp->val;
                node->right = remove(node->right, temp->key);
            }
        }

        return rebalance(node);
    }

    Node* search(Node* node, int key) {
        if (!node || node->key == key) return node;
        if (key < node->key) return search(node->left, key);
        return search(node->right, key);
    }
};


int main() {
    AVLTree tree;
    tree.insert(10, 10);
    tree.insert(20, 20);
    tree.insert(30, 30);
    tree.insert(25, 25);

    Node* nod_cautat = tree.search(25);
    if (nod_cautat)
        cout << "Nodul 25 a fost găsit cu valoarea: " << nod_cautat->val << endl;
    else
        cout << "Nodul 25 nu a fost găsit." << endl;

    tree.remove(20);
    nod_cautat = tree.search(20);
    if (!nod_cautat)
        cout << "Nodul 20 a fost șters." << endl;

    return 0;
}
