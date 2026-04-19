class HashTable:
    def __init__(self, size):
        self.size = size
        self.table = [None] * size

    def hash_function(self, key):
        return hash(key) % self.size

    def insert(self, key, value):
        index = self.hash_function(key)
        if self.table[index] is None:
            self.table[index] = [(key, value)]
        else:
            for i, (k, v) in enumerate(self.table[index]):
                if k == key:
                    self.table[index][i] = (key, value)
                    break
            else:
                self.table[index].append((key, value))

    def get(self, key):
        index = self.hash_function(key)
        if self.table[index] is not None:
            for k, v in self.table[index]:
                if k == key:
                    return v
        return None

    def delete(self, key):
        index = self.hash_function(key)
        if self.table[index] is not None:
            for i, (k, v) in enumerate(self.table[index]):
                if k == key:
                    del self.table[index][i]
                    break

    def display(self):
        for index, items in enumerate(self.table):
            if items is not None:
                print(f"Bucket {index}: {items}")

hash_table = HashTable(10)
hash_table.insert("apple", 5)
hash_table.insert("banana", 7)
hash_table.insert("orange", 3)
hash_table.insert("grape", 2)
hash_table.display()
print(hash_table.get("apple"))
hash_table.delete("banana")
hash_table.display()

class CustomHashTable:
    def __init__(self):
        self.size = 100
        self.table = [None] * self.size

    def _hash(self, key):
        return hash(key) % self.size

    def put(self, key, value):
        index = self._hash(key)
        if self.table[index] is None:
            self.table[index] = []
        self.table[index].append((key, value))

    def get(self, key):
        index = self._hash(key)
        if self.table[index] is not None:
            for item in self.table[index]:
                if item[0] == key:
                    return item[1]
        return None

    def delete(self, key):
        index = self._hash(key)
        if self.table[index] is not None:
            for i, item in enumerate(self.table[index]):
                if item[0] == key:
                    del self.table[index][i]
                    break

    def display(self):
        for index, items in enumerate(self.table):
            if items is not None:
                print(f"Bucket {index}: {items}")

custom_hash_table = CustomHashTable()
custom_hash_table.put("key1", "value1")
custom_hash_table.put("key2", "value2")
custom_hash_table.display()
print(custom_hash_table.get("key1"))
custom_hash_table.delete("key2")
custom_hash_table.display()